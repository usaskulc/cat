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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,org.apache.log4j.Logger,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,java.awt.image.BufferedImage,java.io.*,javax.imageio.*"%><%!
Logger logger = Logger.getLogger("assessmentMethodBarG=graph.jsp");%><%
String courseOfferingId = request.getParameter("course_offering_id") ;
String loadValuesOnlyString = request.getParameter("load_values");
boolean loadValuesOnly = HTMLTools.isValid(loadValuesOnlyString) && loadValuesOnlyString.equals("true");
boolean debug = request.getParameter("debug") != null;
@SuppressWarnings("unchecked")
HashMap<String,CourseOffering> userHasAccessToOfferings = (HashMap<String,CourseOffering>)session.getAttribute("userHasAccessToOfferings");

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin || (userHasAccessToOfferings!=null && userHasAccessToOfferings.containsKey(courseOfferingId));

CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}

List<LinkCourseOfferingAssessment> list = cm.getAssessmentsForCourseOffering(courseOffering);

List<AssessmentTimeOption> timeOptionsList = cm.getAssessmentTimeOptions();

List<String> timeOptions = new ArrayList<String>();
TreeMap<String,Double> mapping = new TreeMap<String,Double>();

//labels for x-axis, to be dsiplayed along the right as a list
List<String> timePeriodOptions = new ArrayList<String>();

//time period options can have 3 different "time_period" indicators
//"N" means that it is NOT a time-period
//"Y" means that it IS a time-period and that any weight marked with "ongoing" should be spread out over these
//"O" means that any weight set for this option should be evenly distributed over all options that have 'Y'
boolean firstTimePeriod = true;
StringBuilder timePeriodIndexes = new StringBuilder();
int index = 0;
List<Integer> periods = new ArrayList<Integer>();
for(AssessmentTimeOption time : timeOptionsList)
{	
	timeOptions.add(time.getName());
	if(!time.getTimePeriod().equals("O"))
	{
		mapping.put(time.getName(), new Double(0));
		if(time.getTimePeriod().equals("Y"))
		{
			timePeriodOptions.add(time.getName());
			if(firstTimePeriod)
				firstTimePeriod = false;
			else
				timePeriodIndexes.append(",");
			timePeriodIndexes.append(index);
			periods.add(index);
		}
	}
	index++;
}

Double ongoingWeight = 0.0;
for(LinkCourseOfferingAssessment link : list)
{
	
	//if this assessment is
	if(!link.getWhen().getTimePeriod().equals("O"))
	{
		Double tally = mapping.get(link.getWhen().getName());
		tally = tally +  link.getWeight();
		mapping.put(link.getWhen().getName(),tally);
	}
	else
	{
		ongoingWeight = ongoingWeight + link.getWeight();
	}
}
//add the "ongoing" weights to the designated "time-period" options

Double toAdd = 0.0;
if(timePeriodOptions != null && timePeriodOptions.size() > 0)
{
	toAdd = ongoingWeight/timePeriodOptions.size();
	for(String option: timePeriodOptions)
	{
		Double tally = mapping.get(option);
		tally = tally +  toAdd;
		mapping.put(option,tally);
	}
}

List<String> columnNames = new ArrayList<String>();
List<Double> values = new ArrayList<Double>();
boolean first = true;
Double max = 0.0;
for(String timeOption : timeOptions)
{
	Double value = mapping.get(timeOption);
	if(value == null)
		continue;
	columnNames.add(timeOption);
	values.add(value);
	if(value > max)
		max = value;
}
AssessmentBarChartGenerator bcg = new AssessmentBarChartGenerator(); 
bcg.init(columnNames.size(), columnNames,"No data to display, please select Assessment Methods above.", values, max,periods);
BufferedImage offImage = bcg.getImage();

response.setContentType("image/png");
OutputStream os = response.getOutputStream();
ImageIO.write(offImage, "png", os);
os.close();

%>
