package ca.usask.gmcte.util;

import java.io.File;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import ca.usask.gmcte.currimap.action.CourseManager;
import ca.usask.gmcte.currimap.action.OrganizationManager;
import ca.usask.gmcte.currimap.action.ProgramManager;
import ca.usask.gmcte.currimap.model.Course;
import ca.usask.gmcte.currimap.model.CourseAttribute;
import ca.usask.gmcte.currimap.model.CourseAttributeValue;
import ca.usask.gmcte.currimap.model.Department;
import ca.usask.gmcte.currimap.model.LinkCourseProgram;
import ca.usask.gmcte.currimap.model.LinkProgramProgramOutcome;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.currimap.model.ProgramOutcome;
import ca.usask.gmcte.currimap.model.ProgramOutcomeGroup;
import ca.usask.gmcte.currimap.model.to.ProgramOutcomeCourseContribution;


public class ExcelEporter
{

	public static File createExcelFile(Program program) throws Exception
	{
		
		ResourceBundle bundle = ResourceBundle.getBundle("currimap");
		String folderName = bundle.getString("tempFileFolder");
		File tempFolder = new File(folderName);
		tempFolder = new File(tempFolder, ""+System.currentTimeMillis());
		tempFolder.mkdirs();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("MMM_dd_yyyy_H_mm");
		File file = new File(tempFolder,program.getName() +"_"+ dateFormatter.format(cal.getTime())+".xls");
		WritableWorkbook workbook = Workbook.createWorkbook(file); 
	
		WritableSheet sheet = workbook.createSheet("First Sheet", 0); 
		
		WritableFont biggerFont = new WritableFont(WritableFont.ARIAL, 14,WritableFont.BOLD, false);
		
		WritableCellFormat biggerFormat = new WritableCellFormat (biggerFont); 
		biggerFormat.setWrap(true);
		
		WritableCellFormat wrappedCell = new WritableCellFormat();
		wrappedCell.setWrap(true);
		
		int col = 0;
		int row = 3;
		Organization organization = program.getOrganization();
		if(organization.getParentOrganization() != null)
			organization = organization.getParentOrganization();
		
		List<CourseAttribute> courseAttributes = OrganizationManager.instance().getCourseAttributes(organization);
		
		
		
		//main labels
		String[] labels = {"Program Outcome Category", "Program Outcome","Core Course Contributions","Service Course Contributions","Total Contribution" };
		
		/*index 0 = outcome group
		 * 1 = program outcome
		 * 2 = core courses
		 * 3 = service courses
		 * 4 = sum of contributions
		 */
		int[] mainColumns = {0,1,2,5,8};
	
		for(int i = 0; i< labels.length; i++)
		{
			Label labelToAdd = new Label(mainColumns[i], row, labels[i],biggerFormat);
			sheet.addCell(labelToAdd);
		}
		//merge header main header cells
		sheet.mergeCells(mainColumns[2], row, mainColumns[3]-1, row);
		sheet.mergeCells(mainColumns[3], row, mainColumns[4]-1, row);
			
		for(int i = 0; i< Math.max(mainColumns[4]+1,(courseAttributes.size()+2)*2); i++)
		{
			sheet.setColumnView(i,  30);
		}
	
		//add secondary headers
		row++;
		col = mainColumns[2];
		Label courseHeaderLabel = new Label(col++, row, "Course",biggerFormat);
		sheet.addCell(courseHeaderLabel);
		
		Label contributionsHeaderLabel = new Label(col, row, "Contribution-values",biggerFormat);
		sheet.addCell(contributionsHeaderLabel);
		sheet.mergeCells(col, row, col+4, row);
		col += 5; //(leave 5 columns for contribution-values)
		
		col = mainColumns[3];
		courseHeaderLabel = new Label(col++, row, "Course",biggerFormat);
		sheet.addCell(courseHeaderLabel);
		contributionsHeaderLabel = new Label(col, row, "Contribution-values",biggerFormat);
		sheet.addCell(contributionsHeaderLabel);
		sheet.mergeCells(col, row, col+4, row);
		
		
		//start of program outcome-groups
		row = 6; 
		col = 0;
		
		ProgramManager pm = ProgramManager.instance();
		Map<String, Integer> offeringCounts = pm.getCourseOfferingCounts(program );
		List<LinkCourseProgram> courseLinks = pm.getLinkCourseProgramForProgram(program);

		List<ProgramOutcomeGroup> groups = pm.getProgramOutcomeGroupsProgram(program);
		
		List<ProgramOutcomeCourseContribution> coreContributions = pm.getProgramOutcomeCoreCourseContributionForProgram(program);
		List<ProgramOutcomeCourseContribution> serviceContributions = pm.getProgramOutcomeServiceCourseContributionForProgram(program);
		NumberFormat formatter = NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(1);
		for(ProgramOutcomeGroup group : groups)
		{
			
			col = mainColumns[0];
			List<LinkProgramProgramOutcome> programOutcomes = pm.getProgramOutcomeForGroupAndProgram(program,group);
			
			//program outcome group
			Label groupLabel = new Label(col++, row, group.getName(),wrappedCell);
			sheet.addCell(groupLabel);
			
			
			for(LinkProgramProgramOutcome programOutcomeLink: programOutcomes)
			{
				int coreRow = row;
				int serviceRow = row;
				int programOutcomeTotalRow = row;
				col = mainColumns[1];
			
				ProgramOutcome programOutcome = programOutcomeLink.getProgramOutcome();
				//program outcome
				Label outcomeLabel = new Label(col++, row, programOutcome.getName(),wrappedCell);
				sheet.addCell(outcomeLabel);
				
				double total = 0.0;
				
				for(LinkCourseProgram courseLink :courseLinks)
				{
					double coreContribution = 0.0;
					double serviceContribution = 0.0;
					int coreColumn = mainColumns[2];
					int serviceColumn = mainColumns[3];
					
					if(isContruibutingCourse(coreContributions, courseLink.getCourse(),programOutcome.getId()))
					{
						//put course info and attributes in starting at programCoreOutcomeColumn and programCoreOutcomeRow
						placeCourseInfo(sheet,coreColumn++, coreRow, null, null, courseLink.getCourse());
						
						//put contributions in at programCoreOutcomeColumn + # of attributes and programCoreOutcomeRow
						coreContribution = placeContributions(sheet,coreColumn, coreRow, coreContributions, programOutcome.getId() ,courseLink.getCourse().getId(),offeringCounts);
						
						//increase programCoreOutcomeRow
						coreRow++;
					}
					else if  (isContruibutingCourse(serviceContributions, courseLink.getCourse(),programOutcome.getId()))
						//this must be a service course
					{
						//put course info and attributes in starting at programServiceOutcomeColumn and programServiceOutcomeRow
						placeCourseInfo(sheet,serviceColumn++, serviceRow, null, null, courseLink.getCourse());
						
						//put contributions in at programServiceOutcomeColumn + # of attributes and programServiceOutcomeRow
						serviceContribution = placeContributions(sheet,serviceColumn, serviceRow, serviceContributions, programOutcome.getId() ,courseLink.getCourse().getId(),offeringCounts);
						
						//increase programServiceOutcomeRow
						serviceRow++;
					}
					//next outcome row should be the max of programServiceOutcomeRow and programCoreOutcomeRow
					total += coreContribution + serviceContribution;
				}//done looping through courses for this program outcome
				
				row = Math.max(serviceRow, coreRow);
				
				Number totalNumber = new Number(mainColumns[4],programOutcomeTotalRow, total);
				sheet.addCell(totalNumber);
			}
		
		}
		row++;
		col = 0;
		if(courseAttributes != null && !courseAttributes.isEmpty())
		{
			Label courseAttributesLabel = new Label(col, row++, "Course Attributes",biggerFormat);
			sheet.addCell(courseAttributesLabel);
			
			
			
	
			int coreColumnHome = 0;
			int serviceColumnHome = coreColumnHome + 2 + courseAttributes.size();
			
			int serviceColumn = serviceColumnHome;
			int coreColumn = coreColumnHome;
			
			Label coreCourseAttributesLabel = new Label(coreColumn, row, "Core courses",biggerFormat);
			sheet.addCell(coreCourseAttributesLabel);
			
			Label serviceCourseAttributesLabel = new Label(serviceColumn, row++, "Service courses",biggerFormat);
			sheet.addCell(serviceCourseAttributesLabel);
			
			
			Label courseNameHeaderLabel = new Label(coreColumn++, row, "Course",biggerFormat);
			sheet.addCell(courseNameHeaderLabel);
			courseNameHeaderLabel = new Label(serviceColumn++, row, "Course",biggerFormat);
			sheet.addCell(courseNameHeaderLabel);
			
			for(CourseAttribute courseAttribute: courseAttributes)
			{
				Label labelToAdd = new Label(coreColumn++, row, courseAttribute.getName(),biggerFormat);
				sheet.addCell(labelToAdd);
				labelToAdd = new Label(serviceColumn++, row, courseAttribute.getName(),biggerFormat);
				sheet.addCell(labelToAdd);
			
			}
			row++;
			col = 0;
			int coreRow = row;
			int serviceRow = row; 
			
			for(LinkCourseProgram courseLink :courseLinks)
			{
				serviceColumn = serviceColumnHome;
				coreColumn = coreColumnHome;
				List<Department> depts = CourseManager.instance().getDepartmentForCourse(courseLink.getCourse());
				boolean deptMatches = false;
				for(Department dept: depts)
				{
					if(dept.getId() == program.getOrganization().getDepartment().getId() || dept.getId() == organization.getDepartment().getId())
						deptMatches = true;
				}
				List<CourseAttributeValue> attributeValues = CourseManager.instance().getCourseAttributeValues(courseLink.getCourse().getId(), program.getId());
				
				if(deptMatches) //core course
				{
					placeCourseInfo(sheet,coreColumn, coreRow++ , courseAttributes, attributeValues, courseLink.getCourse());
						
				}
				else // service course
				{
					placeCourseInfo(sheet,serviceColumn, serviceRow++ , courseAttributes, attributeValues, courseLink.getCourse());
				}
			}
		}
		
		
		
		
		workbook.write();
		workbook.close(); 
		return file;
	}
	private static void placeCourseInfo(WritableSheet sheet,int column, int row, List<CourseAttribute> courseAttributes, List<CourseAttributeValue> attributeValues, Course course) throws RowsExceededException, WriteException
	{
		
		Label courseContributionLabel = new Label(column++, row, course.getSubject() + " " + course.getCourseNumber());
		sheet.addCell(courseContributionLabel);
		if(courseAttributes != null)
		{
			for(CourseAttribute attribute : courseAttributes)
			{
				for(CourseAttributeValue value : attributeValues)
				{
					if(value.getAttribute().getId() == attribute.getId())
					{	
						Label courseAttrLabel = new Label(column++, row, value.getValue());
						sheet.addCell(courseAttrLabel);
					}
				}
			}
		}
	}
	private static double placeContributions(WritableSheet sheet, int column, int row, List<ProgramOutcomeCourseContribution> contributions, int programOutcomeId ,int courseId,Map<String, Integer> offeringCounts) throws RowsExceededException, WriteException
	{
		double sum = 0.0;
		double contributionValue = 0.0;
		boolean contributionFound = false;
		//do stuff for core course
		for (ProgramOutcomeCourseContribution contribution:contributions)
		{
			
			if(contribution.getCourseId() == courseId)
			{
				if(contribution.getProgramOutcomeId() == programOutcomeId)
				{
				
					int count = offeringCounts.get(""+contribution.getCourseId()) != null?offeringCounts.get(""+contribution.getCourseId()): 1; 
					contributionValue = (0.0+contribution.getContributionSum())/count;
					sum = sum + contributionValue;
					contributionFound = true;
				}
			}
		}
		if(contributionFound && contributionValue > 0.05)
		{
			Number number = new Number(column++, row, contributionValue);
			sheet.addCell(number);
		}
		return sum;
	}
	
	
	private static boolean isContruibutingCourse(List<ProgramOutcomeCourseContribution> contributions, Course course, int programOutcomeId)
	{
		for (ProgramOutcomeCourseContribution contribution:contributions)
		{
			if(contribution.getCourseId() == course.getId() && contribution.getProgramOutcomeId() == programOutcomeId)
			{
				if(contribution.getContributionSum() > 0)
					return true;
			}
		}
		return false;
	}


}