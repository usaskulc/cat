<%-- 
    Copyright 2012, 2013 University of Saskatchewan

    This file is part of the Curriculum Alignment Tool (CAT).

    CAT is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    CAT is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with CAT.  If not, see <http://www.gnu.org/licenses/>.
--%>


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,org.apache.log4j.Logger,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.*,java.awt.image.BufferedImage,java.io.*,javax.imageio.*"%>
<%!Logger logger = Logger.getLogger("ProgramCourseTechingMethodData.jsp");%>
<%
String[] courseIds = request.getParameterValues("course_id");
List<String> courseIdList = null;
if(courseIds!=null && courseIds.length > 0)
	courseIdList = Arrays.asList(courseIds);
String[] terms = request.getParameterValues("term");
List<String> termList = new ArrayList<String>();
if(terms!=null && terms.length > 0)
	termList = Arrays.asList(terms);
String programId = request.getParameter("program_id");
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}

ProgramManager pm = ProgramManager.instance();

Program o = pm.getProgramById(Integer.parseInt(programId));
List<TeachingMethod> teachingMethodslist = CourseManager.instance().getAllTeachingMethods();
//the available teaching methods to be displayeed along the right
List<String> teachingMethodsDisplay = new ArrayList<String>();
for(TeachingMethod tm : teachingMethodslist)
	teachingMethodsDisplay.add(tm.getName());

//maximum index for determining totals
int maxValue = teachingMethodslist.get(teachingMethodslist.size()-1).getDisplayIndex();

boolean debug = request.getParameter("debug")!=null;
				
@SuppressWarnings("unchecked")
List<CourseTeachingMethodOption> teachingMethodData = pm.getProgramCourseTeachingMethodOptions(o,termList);
Map<String, Integer> offeringCounts = pm.getCourseOfferingCounts( o,termList );
HashMap<String, ArrayList<Double>> organizedTeachingMethodData = pm.organizeTeachingMethodData(teachingMethodData, maxValue, offeringCounts);

if(debug)
{
	for(String key: organizedTeachingMethodData.keySet())
	{
		logger.error("key="+key);
		ArrayList<Double> vals = organizedTeachingMethodData.get(key);
		for(Double val: vals)
			logger.error("\t"+val);
	}
}


//the actual values for the bars
List<Double> values = new ArrayList<Double>();

List<TeachingMethodPortionOption> optionsList = CourseManager.instance().getTeachingMethodPortionOptions();
boolean first = true;
//labels to be displayed for y-axis
List<String> yLabels = new ArrayList<String>();
//corresponding values for y-axis
List<Integer> yValues = new ArrayList<Integer>();

//highest possible y-axis value
int maxYValue = 0;

double maxColumnValue = -1.0;
for(TeachingMethodPortionOption option : optionsList)
{
	yLabels.add(option.getName()+" ("+option.getComparativeValue()+")");
	yValues.add(option.getComparativeValue());
	if(maxYValue < option.getComparativeValue())
		maxYValue = option.getComparativeValue();
}
//no data
if(organizedTeachingMethodData == null || organizedTeachingMethodData.isEmpty() || courseIdList==null || courseIdList.isEmpty())
{
	for(int i = 0; i < teachingMethodslist.size(); i++)
	{
		values.add(new Double(0.0));
	}
	
}
else
{
	List<Double> workingValues = new ArrayList<Double>();
	for(int i = 0 ; i <= teachingMethodslist.size(); i++)
		workingValues.add(new Double(0.0));
	for(int i = 0 ; i < teachingMethodslist.size(); i++)
		values.add(new Double(0.0));
	
	if(debug) logger.error("<table>");
	
	//go through the data and add the values found to the result array
	for(String courseId : organizedTeachingMethodData.keySet())
	{
		if(debug) logger.error("<tr><td>CourseId="+courseId);
		if(courseIdList != null && courseIdList.contains(courseId))
		{
			ArrayList<Double> courseData = organizedTeachingMethodData.get(courseId);
			
			for(int i=1 ; i <= teachingMethodslist.size()  ; i++)
			{
				if(debug) logger.error("<td>" + workingValues.get(i) + " => ");
					workingValues.set(i, workingValues.get(i)+courseData.get(i));
				if(debug) logger.error(workingValues.get(i)+"</td>");
			}
			if(debug) logger.error("<td> Sum: " + workingValues.get(0) + " => ");
			workingValues.set(0, workingValues.get(0)+1.0);
			if(debug) logger.error(workingValues.get(0)+"</td>");
		}	
		if(debug) logger.error("</tr>");
	}
	if(debug) logger.error("</table>");
	if(debug)
	{
		logger.error("<table border=1><tr>");
		for(int i = 0 ; i <= teachingMethodslist.size(); i++)
			logger.error("<td>"+ i + " "+ workingValues.get(i)+"</td>");
		logger.error("</tr></table>");
	}
	//display values found (divided by the number of courses to get the average)
	for(int i = 0 ; i < teachingMethodslist.size(); i++)
	{
		TeachingMethod option = teachingMethodslist.get(i);
		double colValue = (workingValues.get(option.getDisplayIndex()))/workingValues.get(0);
		logger.error("Index= "+i+" displayIndex= "+option.getDisplayIndex()+" value[i]="+workingValues.get(i)+" workingValues[option]="
				+workingValues.get(option.getDisplayIndex())+" #courses="+workingValues.get(0)+" colValue="+colValue);
		
		values.set(option.getDisplayIndex()-1,colValue);
		if(colValue > maxColumnValue)
			maxColumnValue = colValue;
	}
	if(debug)
	{
		logger.error("<table border=1><tr>");
		for(int i = 0 ; i < values.size(); i++)
			logger.error("<td>Final value "+ i + " "+ values.get(i)+"</td>");
		logger.error("</tr></table>");
	}
	
}
BarChartTeachingMethodGenerator bcg = new BarChartTeachingMethodGenerator(); 
bcg.init(teachingMethodslist.size(), 
		teachingMethodsDisplay, 
		 "No data to display, please select some courses above.", 
		 values, 
		 maxColumnValue,
		 yValues, 
		 yLabels,
		 maxYValue);
BufferedImage offImage = bcg.getImage();

response.setContentType("image/png");
OutputStream os = response.getOutputStream();
ImageIO.write(offImage, "png", os);
os.close();

%>
