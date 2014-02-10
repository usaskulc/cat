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


<%@ page import="org.apache.log4j.Logger,java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.*,java.awt.image.BufferedImage,java.io.*,javax.imageio.*"%><%!
Logger logger = Logger.getLogger("programCourseAssessmentData.jsp");%>


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
HashMap<String,Program>  userHasAccessToOrganizations = (HashMap<String,Program> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}

ProgramManager pm = ProgramManager.instance();

Program o = pm.getProgramById(Integer.parseInt(programId));
List<AssessmentTimeOption> timeOptionsList = CourseManager.instance().getAssessmentTimeOptions();
int maxOptionIndex = 0;
int ongoingOptionIndex = -1;
int numTimePeriods = 0;
//time period options can have 3 different "time_period" indicators
//"N" means that it is NOT a time-period
//"Y" means that it IS a time-period and that any weight marked with "ongoing" should be spread out over these
//"O" means that any weight set for this option should be evenly distributed over all options that have 'Y'
List<String> columnNames = new ArrayList<String>();

boolean first = true;
int numOptions = 0;
for(AssessmentTimeOption timeOption : timeOptionsList)
{
	if(!timeOption.getTimePeriod().equalsIgnoreCase("O"))
	{
		columnNames.add(timeOption.getName());
		numOptions++;
	}
}


for(int i = 0 ; i < timeOptionsList.size(); i++)
{
	AssessmentTimeOption options = timeOptionsList.get(i);
	if(options.getDisplayIndex() > maxOptionIndex)
		maxOptionIndex = options.getDisplayIndex(); //need this many locations in array (+ one for course offering count)
	if(options.getTimePeriod().equalsIgnoreCase("O")) // this is an ongoing type, ditribute over all time-periods 
		ongoingOptionIndex = options.getDisplayIndex(); //need to be able to retrieve this column value later for distribution of the values accross time periods
	else if (options.getTimePeriod().equalsIgnoreCase("Y"))
		numTimePeriods++; // needed for calculation of ditribution
}	
boolean debug = request.getParameter("debug")!=null;
			
@SuppressWarnings("unchecked")
List<CourseAssessmentOption> assessmentData = pm.getProgramCourseAssessmentOptions(o,termList);
Map<String, Integer> offeringCounts = pm.getCourseOfferingCounts(o,termList );
HashMap<String, ArrayList<Double>> organizedData = pm.organizeAssessmentData(assessmentData, maxOptionIndex, offeringCounts);

if(debug)
	logger.error("maxOptionIndex="+maxOptionIndex+" ongoingOptionIndex="+ongoingOptionIndex+" numTimePeriods="+numTimePeriods);
List<Double> values = new ArrayList<Double>();
Double max = -1.0;
List<Integer> periods = new ArrayList<Integer>();
//no data
if(organizedData == null || organizedData.isEmpty() || courseIdList==null || courseIdList.isEmpty())
{
	if(debug)
		logger.error("NO DATA!");
	
	for(int i = 0; i < timeOptionsList.size()-1; i++)
	{
		values.add(new Double(0.0));
	}
	
}
else
{
	//initialize the results list
	ArrayList<Double> results = new ArrayList<Double>();
	
	for(int i = 0 ; i <= maxOptionIndex; i++)
		results.add(new Double(0.0));
	if(debug) logger.error("<table>");
	
	//go through the data and add the values found to the result array
	for(String courseId : organizedData.keySet())
	{
		if(debug) logger.error("<tr><td>CourseId="+courseId);
		if(courseIdList != null && courseIdList.contains(courseId))
		{
			ArrayList<Double> courseData = organizedData.get(courseId);
			
			for(int i=1 ; i <= maxOptionIndex  ; i++)
			{
				if(debug) logger.error("<td>" + results.get(i) + " => ");
				results.set(i, results.get(i)+courseData.get(i));
				if(debug) logger.error(results.get(i)+"</td>");
			}
			if(debug) logger.error("<td> Sum: " + results.get(0) + " => ");
			results.set(0, results.get(0)+1.0);
			if(debug) logger.error(results.get(0)+"</td>");
		}	
		if(debug) logger.error("</tr>");
	}
	if(debug) logger.error("</table>");
	if(debug)
	{
		logger.error("<table border=1><tr>");
		for(int i = 0 ; i <= maxOptionIndex; i++)
			logger.error("<td>"+ i + " "+ results.get(i)+"</td>");
		logger.error("</tr></table>");
	}
	
	
	//determine values to be distributed
	double distributeFromOngoing = 0.0;
	if(ongoingOptionIndex > -1 && numTimePeriods > 0)
	{
		distributeFromOngoing = results.get(ongoingOptionIndex)/ numTimePeriods;
		
	}
	if(debug)
		logger.error("distributeFromOngoing="+distributeFromOngoing+" ongoingOptionIndex="+ongoingOptionIndex+" numTimePeriods="+numTimePeriods);
	
	
	//display values found (divided by the number of courses to get the average)
	for(int i = 0 ; i < timeOptionsList.size(); i++)
	{
		AssessmentTimeOption option = timeOptionsList.get(i);
		Double valueToAdd = -1.1;
		if(option.getTimePeriod().equalsIgnoreCase("O")) // this is an ongoing type, ditribute over all time-periods 
		{
			//don't add.  Needs to be added to time-periods
		}
		else if (option.getTimePeriod().equalsIgnoreCase("Y"))
		{
			periods.add(new Integer(i));
			valueToAdd = (results.get(option.getDisplayIndex()) + distributeFromOngoing)/results.get(0);
		}
		else
		{
			valueToAdd = (results.get(option.getDisplayIndex()))/results.get(0);
		}
		if(valueToAdd > max)
			max = valueToAdd;
		values.add(valueToAdd);
	}
}
AssessmentBarChartGenerator bcg = new AssessmentBarChartGenerator(); 
bcg.init(columnNames.size(), columnNames,"No data to display, please select Assessment Methods above.", values, max,periods);
BufferedImage offImage = bcg.getImage();

response.setContentType("image/png");
OutputStream os = response.getOutputStream();
ImageIO.write(offImage, "png", os);
os.close();
%>
