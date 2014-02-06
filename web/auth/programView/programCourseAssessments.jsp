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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.*"%>
<%
String[] courseIds = request.getParameterValues("course_id");
List<String> courseIdList = null;
if(courseIds!=null && courseIds.length > 0)
	courseIdList = Arrays.asList(courseIds);

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
if(!access)
{
		out.println("Access denied!");
		return;
}
ProgramManager pm = ProgramManager.instance();

Program o = pm.getProgramById(Integer.parseInt(programId));

CourseManager cm = CourseManager.instance();
List<AssessmentTimeOption> timeOptionsList = cm.getAssessmentTimeOptions();
int maxOptionIndex = 0;
int ongoingOptionIndex = -1;
int numTimePeriods = 0;
for(int i = 0 ; i < timeOptionsList.size(); i++)
{	
	AssessmentTimeOption options = timeOptionsList.get(i);
	if(options.getDisplayIndex() > maxOptionIndex)
		maxOptionIndex = options.getDisplayIndex();
	if(options.getTimePeriod().equalsIgnoreCase("O"))
	{// this is an ongoing type, ditribute over all time-periods 
		ongoingOptionIndex = i;
		
	}
	else if (options.getTimePeriod().equalsIgnoreCase("Y"))
		numTimePeriods++;
}
@SuppressWarnings("unchecked")
HashMap<String, ArrayList<Double>>  organizedData = (HashMap<String, ArrayList<Double>>)session.getAttribute("organizedData");
if(organizedData == null)
{
	List<CourseAssessmentOption> assessmentData = pm.getProgramCourseAssessmentOptions(o);
	Map<String, Integer> offeringCounts = pm.getCourseOfferingCounts( o );
	organizedData = pm.organizeAssessmentData(assessmentData, maxOptionIndex, offeringCounts);
}
StringBuilder columnNames = new StringBuilder();
StringBuilder values = new StringBuilder();
boolean first = true;
int numOptions = 0;
for(AssessmentTimeOption timeOption : timeOptionsList)
{
	if(!timeOption.getTimePeriod().equalsIgnoreCase("O"))
	{
		if(first)
			first = false;
		else
			columnNames.append(",");
	
		columnNames.append(timeOption.getName());
		numOptions++;
	}
}
List<LinkCourseProgram> courseLinks = pm.getLinkCourseProgramForProgram(o);
HashMap<String,StringBuilder> required = new HashMap<String, StringBuilder>();
HashMap<String,StringBuilder> elective = new HashMap<String, StringBuilder>();

String[] years = {"100-level", "200-level", "300-level" , "400-level","500-level","800-level", "900-level"};
String[] yearCodes = {"firstYear", "secondYear", "thirdYear" , "fourthYear","500-level","800-level", "900-level"};

for(String year : yearCodes)
{
	StringBuilder courses1 = new StringBuilder();
	StringBuilder courses2 = new StringBuilder();
	required.put(year,courses1);
	elective.put(year,courses2);
}
for(LinkCourseProgram courseLink : courseLinks)
{
	Course c = courseLink.getCourse();
	CourseClassification classification = courseLink.getCourseClassification();
	//out.println("Course="+c.getCourseNumber() + "index="+ ((c.getCourseNumber()/100) -1) +" "+classification.getName());
	int index = (c.getCourseNumber()/100) -1;
	if (index > 4) // 800 or 900
		index -= 2;

	if(classification.getName().equalsIgnoreCase("required"))
	{
		if(index < yearCodes.length)
		{
			StringBuilder toAddTo = required.get(yearCodes[index]);
			toAddTo.append("<input type=\"checkbox\" class=\"course ");
			toAddTo.append(yearCodes[index]);
			toAddTo.append(" required\"  value=\"");
			toAddTo.append(c.getId());
			toAddTo.append("\" onclick=\"gatherAssessmentData(");
			toAddTo.append(programId);
			toAddTo.append(",this);\">");
			toAddTo.append(c.getSubject());
			toAddTo.append(" ");
			toAddTo.append(c.getCourseNumber());
			toAddTo.append("<br>\n");
		}
	}
	else
	{
		if(index < yearCodes.length)
		{
			StringBuilder toAddTo = elective.get(yearCodes[index]);
			toAddTo.append("<input type=\"checkbox\" class=\"course ");
			toAddTo.append(yearCodes[index]);
			toAddTo.append(" elective\" value=\"");
			toAddTo.append(c.getId());
			toAddTo.append("\" onclick=\"gatherAssessmentData(");
			toAddTo.append(programId);
			toAddTo.append(",this);\">");
			toAddTo.append(c.getSubject());
			toAddTo.append(" ");
			toAddTo.append(c.getCourseNumber());
			toAddTo.append("<br>\n");
		}
	}
}
String current = "required";
%><table id="uofs_table">
<tr><th colspan="7"><input class="course" type="checkbox" id="<%=current%>" value=".<%=current%>" onclick="gatherAssessmentData(<%=programId%>,this);">All <%=current%> Courses</th></tr>
<tr class="required">
<%for(int i = 0; i< yearCodes.length; i++)
{%>
	<th><input type="checkbox" class="course <%=current%>" id="<%=yearCodes[i]%>" value=".<%=yearCodes[i]%>.<%=current%>" onclick="gatherAssessmentData(<%=programId%>,this);"><%=years[i]%></th>
<%
}
%></tr>
<tr>
<%
for(int i = 0; i< yearCodes.length; i++)
{
%>	

	<td>
		<%=required.get(yearCodes[i]).toString()%>
	</td>
<%}
current="elective";

%>
</tr>
</table>
<br><br>
<table>
<tr><th colspan="7"><input class="course" type="checkbox" id="<%=current%>" value=".<%=current%>" onclick="gatherAssessmentData(<%=programId%>,this);">All elective or optional Courses</th></tr>
<tr class="required">
<%for(int i = 0; i< yearCodes.length; i++)
{%>
	<th><input type="checkbox" class="course <%=current%>" id="<%=yearCodes[i]%>" value=".<%=yearCodes[i]%>.<%=current%>" onclick="gatherAssessmentData(<%=programId%>,this);"><%=years[i]%></th>
<%
}
%></tr>
<tr>
<%
for(int i = 0; i< yearCodes.length; i++)
{
%>	

	<td>
		<%=elective.get(yearCodes[i]).toString()%>
	</td>
<%}
long time = System.currentTimeMillis();

%>
</tr>
</table>
<table>
	<tr><td><div id="summaryAssessmentDiv" style="width:550px;height:300px;">
		<img src="/cat/auth/programView/programCourseAssessmentData.jsp?program_id=<%=programId%>&time=<%=time%>" style="width:550px;height:300px;"></img>
	</div></td>
		<td>
	<div id="summaryTeachingMethodsDiv"  style="width:550px;height:300px;">
		<img src="/cat/auth/programView/programCourseTeachingMethodData.jsp?program_id=<%=programId%>&time=<%=time%>" style="width:550px;height:300px;"></img>
	</div></td>
		</tr>
	<tr><td><div id="summaryAssessmentGroupsDiv" style="width:550px;height:300px;">
		<img src="/cat/auth/programView/programAssessmentGroups.jsp?program_id=<%=programId%>&time=<%=time%>" style="width:550px;height:300px;"></img>
	</div></td>
	
		<td>
		&nbsp;
		</td>
		</tr>
		
</table>
