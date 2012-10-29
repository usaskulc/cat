package ca.usask.gmcte.util;

import java.io.File;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import ca.usask.gmcte.currimap.model.CourseOffering;
import ca.usask.gmcte.currimap.model.Department;
import ca.usask.gmcte.currimap.model.LinkCourseOfferingTeachingMethod;
import ca.usask.gmcte.currimap.model.LinkCourseProgram;
import ca.usask.gmcte.currimap.model.LinkProgramProgramOutcome;
import ca.usask.gmcte.currimap.model.Organization;
import ca.usask.gmcte.currimap.model.Program;
import ca.usask.gmcte.currimap.model.ProgramOutcome;
import ca.usask.gmcte.currimap.model.ProgramOutcomeGroup;
import ca.usask.gmcte.currimap.model.to.ProgramOutcomeCourseContribution;


public class ExcelEporter
{


	public static File createExportFile(Organization organization) throws Exception
	{
		
		ResourceBundle bundle = ResourceBundle.getBundle("currimap");
		String folderName = bundle.getString("tempFileFolder");
		File tempFolder = new File(folderName);
		tempFolder = new File(tempFolder, ""+System.currentTimeMillis());
		tempFolder.mkdirs();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("MMM_dd_yyyy_H_mm");
		File file = new File(tempFolder,organization.getName().replaceAll(" ","_") +"_"+ dateFormatter.format(cal.getTime())+".xls");
		WritableWorkbook workbook = Workbook.createWorkbook(file); 
	
		int sheetIndex = 0;
		WritableSheet sheet = workbook.createSheet("Courses", sheetIndex++); 
		WritableSheet offeringsSheet = workbook.createSheet("Offerings", sheetIndex++); 
		

		WritableSheet teachingMethodSheet = workbook.createSheet("Instructional strategies", sheetIndex++); 
		
		
	
		WritableSheet assessmentSheet = workbook.createSheet("Assessments", sheetIndex++); 
		WritableSheet outcomesSheet = workbook.createSheet("Outcomes", sheetIndex++); 
		WritableSheet assessmentToOutcomeSheet = workbook.createSheet("Assessment of Outcomes", sheetIndex++); 
		WritableSheet courseWithinProgramSheet = workbook.createSheet("Course within Program", sheetIndex++); 
		WritableSheet courseToProgramSheet = workbook.createSheet("Course OC -> Program OC", sheetIndex++); 
		
		
		
		
		WritableFont biggerFont = new WritableFont(WritableFont.ARIAL, 12,WritableFont.BOLD, false);
		
		WritableCellFormat biggerFormat = new WritableCellFormat (biggerFont); 
		biggerFormat.setWrap(true);
		
		WritableCellFormat wrappedCell = new WritableCellFormat();
		wrappedCell.setWrap(true);
		
		Label constructionLabel = new Label(0, 0, "Coming soon",biggerFormat);
		assessmentSheet.addCell(constructionLabel);
		Label constructionLabel2 = new Label(0, 0, "Coming soon",biggerFormat);
		outcomesSheet.addCell(constructionLabel2);
		Label constructionLabel3 = new Label(0, 0, "Coming soon",biggerFormat);
		assessmentToOutcomeSheet.addCell(constructionLabel3);
		Label constructionLabel4 = new Label(0, 0, "Coming soon",biggerFormat);
		courseWithinProgramSheet.addCell(constructionLabel4);
		Label constructionLabel5 = new Label(0, 0, "Coming soon",biggerFormat);
		courseToProgramSheet.addCell(constructionLabel5);
		
		
		int col = 0;
		int row = 3;
		OrganizationManager om = OrganizationManager.instance();
		List<CourseAttribute> courseAttributes = om.getCourseAttributes(organization);
		
		
		List<Course> coursesLinkedToOrganization = om.getAllCourses(organization);
		
		
	/*	//main labels
		String[] labels = {"Subject", "Course Number"};
		int[] mainColumns = {0,1};
	
		for(int i = 0; i< labels.length; i++)
		{
			Label labelToAdd = new Label(mainColumns[i], row, labels[i],biggerFormat);
			sheet.addCell(labelToAdd);
		}
		//merge header main header cells
	//	sheet.mergeCells(mainColumns[2], row, mainColumns[3]-1, row);
	//	sheet.mergeCells(mainColumns[3], row, mainColumns[4]-1, row);
		*/
		
		Label orgLabel = new Label(0, 0, organization.getName(),biggerFormat);
		sheet.addCell(orgLabel);
	
		
		//add secondary headers
		row++;
		col=0;
		Label courseSubjectLabel = new Label(col++, row, "Subject",biggerFormat);
		sheet.addCell(courseSubjectLabel);
		Label courseNumberLabel = new Label(col++, row, "Number",biggerFormat);
		sheet.addCell(courseNumberLabel);
		Label courseIdLabel = new Label(col++, row, "course_id",biggerFormat);
		sheet.addCell(courseIdLabel);
		List<String> courseIds = new ArrayList<String>();
		for(int i = 0; i< 4; i++)
		{
			sheet.setColumnView(i,  30);
		}
		row++;
		col=0;
		for (Course c : coursesLinkedToOrganization)
		{
			Label subjectLabel = new Label(col++, row, c.getSubject(),wrappedCell);
			sheet.addCell(subjectLabel);
			Label numberLabel = new Label(col++, row, ""+c.getCourseNumber(),wrappedCell);
			sheet.addCell(numberLabel);
			Label idLabel = new Label(col++, row, ""+c.getId(),wrappedCell);
			sheet.addCell(idLabel);
			courseIds.add(""+c.getId());
			row++;
			col=0;
		}
		 CourseManager cm =  CourseManager.instance();
		List<CourseOffering> offerings = cm.getCourseOfferingsForCourses(courseIds);
		
		for(int i = 0; i< 10; i++)
		{
			offeringsSheet.setColumnView(i,  30);
		}
		row=0;
		col=0;
		courseIdLabel = new Label(col++, row, "course_id",biggerFormat);
		offeringsSheet.addCell(courseIdLabel);
		Label termLabel = new Label(col++, row, "Term",biggerFormat);
		offeringsSheet.addCell(termLabel);
		Label sectionNumberLabel = new Label(col++, row, "Section number",biggerFormat);
		offeringsSheet.addCell(sectionNumberLabel);
		Label mediumLabel = new Label(col++, row, "Medium",biggerFormat);
		offeringsSheet.addCell(mediumLabel);
		
		
		Label instrLabel= new Label(col++, row, "Instructor(s)",biggerFormat);
		offeringsSheet.addCell(instrLabel);
		Label numStudentsLabel = new Label(col++, row, "Num students",biggerFormat);
		offeringsSheet.addCell(numStudentsLabel);
		Label completionTimeLabel = new Label(col++, row, "Completion time",biggerFormat);
		offeringsSheet.addCell(completionTimeLabel);
		Label completionValueLabel = new Label(col++, row, "Completion time value",biggerFormat);
		offeringsSheet.addCell(completionValueLabel);
		Label commentsLabel = new Label(col++, row, "Comments",biggerFormat);
		offeringsSheet.addCell(commentsLabel);
		Label courseOfferingIdLabel = new Label(col++, row, "course_offering_id",biggerFormat);
		offeringsSheet.addCell(courseOfferingIdLabel);
		row++;
		col=0;
		for (CourseOffering co : offerings)
		{
			Label courseLabel = new Label(col++, row, ""+co.getCourse().getId());
			offeringsSheet.addCell(courseLabel);
			
			Label coTermLabel = new Label(col++, row, co.getTerm(),wrappedCell);
			offeringsSheet.addCell(coTermLabel);
			Label coSectionNumLabel = new Label(col++, row, ""+co.getSectionNumber(),wrappedCell);
			offeringsSheet.addCell(coSectionNumLabel);
			Label medLabel = new Label(col++, row, ""+co.getMedium(),wrappedCell);
			offeringsSheet.addCell(medLabel);
			Label instructorsLabel = new Label(col++, row, cm.getInstructorsString(co, false, "-2"),wrappedCell);
			offeringsSheet.addCell(instructorsLabel);
			Label studentsLabel = new Label(col++, row, ""+co.getNumStudents(),wrappedCell);
			offeringsSheet.addCell(studentsLabel);
			Label completionLabel = new Label(col++, row, co.getTimeItTook()!=null?co.getTimeItTook().getName():"",wrappedCell);
			offeringsSheet.addCell(completionLabel);
			Label completionCalcLabel = new Label(col++, row, co.getTimeItTook()!=null?""+co.getTimeItTook().getCalculationValue():"",wrappedCell);
			offeringsSheet.addCell(completionCalcLabel);
			Label commentLabel = new Label(col++, row, co.getComments()!=null?co.getComments():"", wrappedCell);
			offeringsSheet.addCell(commentLabel);
			Label idLabel = new Label(col++, row, ""+co.getId(),wrappedCell);
			offeringsSheet.addCell(idLabel);
			row++;
			col=0;
		}
		

		List<LinkCourseOfferingTeachingMethod> methods = cm.getTeachingMethods(courseIds);
		
		row=0;
		col=0;
		courseIdLabel = new Label(col++, row, "course_id",biggerFormat);
		teachingMethodSheet.addCell(courseIdLabel);
		courseOfferingIdLabel = new Label(col++, row, "course_offering_id",biggerFormat);
		teachingMethodSheet.addCell(courseOfferingIdLabel);
		
		Label stratLabel= new Label(col++, row, "Instructional strategy",biggerFormat);
		teachingMethodSheet.addCell(stratLabel);
		Label extentLabel = new Label(col++, row, "Extent of Use",biggerFormat);
		teachingMethodSheet.addCell(extentLabel);
		Label extentValueLabel = new Label(col++, row, "Extent of Use value",biggerFormat);
		teachingMethodSheet.addCell(extentValueLabel);
		
		for(int i = 0; i< 5; i++)
		{
			teachingMethodSheet.setColumnView(i,  30);
		}
		row++;
		col=0;
		for (LinkCourseOfferingTeachingMethod meth : methods)
		{
			Label courseLabel = new Label(col++, row, ""+meth.getCourseOffering().getCourse().getId());
			teachingMethodSheet.addCell(courseLabel);
			
			Label idLabel = new Label(col++, row, ""+meth.getCourseOffering().getId(),wrappedCell);
			teachingMethodSheet.addCell(idLabel);
			Label strategyLabel = new Label(col++, row, ""+meth.getTeachingMethod().getName(),wrappedCell);
			teachingMethodSheet.addCell(strategyLabel);
			Label extLabel = new Label(col++, row, ""+meth.getHowLong().getName(),wrappedCell);
			teachingMethodSheet.addCell(extLabel);
			Label extValLabel = new Label(col++, row, ""+meth.getHowLong().getComparativeValue(),wrappedCell);
			teachingMethodSheet.addCell(extValLabel);
			row++;
			col=0;
		}
		
		/*
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
		
		
		*/
		
		workbook.write();
		workbook.close(); 
		return file;
	}

	
	
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