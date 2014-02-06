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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*, java.text.NumberFormat"%>
<%
String organizationId = request.getParameter("organization_id") ;
String courseOfferingId = request.getParameter("course_offering_id") ;

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

for(AssessmentTimeOption time : timeOptionsList)
{	
	timeOptions.add(time.getName());
}
double assessmentSum = 0.0;
NumberFormat formatter = NumberFormat.getInstance();
formatter.setMaximumFractionDigits(1);
%>
<h2>My Assessment Methods</h2>
<p>
This section gathers information about how and when students in your course are assessed. 
To complete this table, select the <i><b>add method</b></i> button and submit the information requested. 
Repeat this process until you have added all the assessment methods used in your course, totaling 100% of the grade. 
Two bar graphs will appear below showing the distribution of assessments across time and the types of assessment methods used.
</p>
<div>
	<table cellpadding="0" cellspacing="0" border="1">
		<tr><th>Method-name</th><th> % of total mark</th><th>Due</th></tr>
		<%
		for(LinkCourseOfferingAssessment link : list)
		{
			String additionalInfo = link.getAdditionalInfo();
			AssessmentGroup group = link.getAssessment().getGroup();
			String additionalInfoDisplay = "";
			if(group != null)
				additionalInfoDisplay = link.getAssessment().getGroup().getShortName()+ ": ";
			
			additionalInfoDisplay += link.getAssessment().getName() + (HTMLTools.isValid(additionalInfo)?" ( "+additionalInfo+" )":"");
			
			assessmentSum+= link.getWeight();
			%>
		<tr>
			<td><%=additionalInfoDisplay%> <a href="javascript:showMoreAssessmentInfo(<%=link.getId()%>,<%=courseOfferingId%>);" class="smaller">More info</a>
			<%if(link.getCriterionExists().equalsIgnoreCase("Y"))
				{%><span style="font-weight:bold;"> criterion threshold: <%=link.getCriterionLevel()%></span>
				<%}%> 
				 <%if(access){%>
				 	<a href="javascript:loadModify('/cat/auth/courseOffering/editAssessmentMethods.jsp?assessment_link_id=<%=link.getId()%>&course_offering_id=<%=courseOfferingId%>');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit assessment method" title="Edit assessment method"></a>
				 	<a href="javascript:removeAssessmentMethod(<%=link.getId()%>,<%=courseOfferingId%>);" class="smaller"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove assessment method" title="Remove assessment method" ></a>
				 	<%}%><div id="additionalAssessmentInfo_<%=link.getId()%>" style="display:none;padding:10px;"></div></td>
			<td><%=formatter.format(link.getWeight() )%> %</td>
			<td><%=link.getWhen().getName()%></td>
		</tr>
			<% 
		}
		
		
		
		if(list.isEmpty())
		{
			%>
			<tr><td colspan="3">No Assessment methods added (yet)</td></tr>
			<%
		}
		else
		{
			String sumStyle ="";
			String sumNote = "&nbsp;";
			if(Math.abs(assessmentSum - 100) > 0.05)
			{
				%>
				<tr style="color:red;font-weight:bold;">
					<td style="text-align:right;">Total : </td>
					<td>  <%=assessmentSum%> </td>
					<td> The total does not add up to 100%</td>
				</tr>	
				<%
			}
			else
			{
				%>
				<tr>
					<td style="text-align:right;">Total : </td>
					<td> 100% </td>
					<td>&nbsp;</td>
				</tr>
				<%
			}
		}
		if(access)
		{
		%>
		<tr><td colspan="4"><a href="javascript:loadModifyIntoDiv('/cat/auth/courseOffering/editAssessmentMethods.jsp?course_offering_id=<%=courseOfferingId%>','addAssessmentMethodDiv');" class="smaller"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add assessment method" title="Add assessment method">Add assessment method</a>
			<hr/>
			<div id="addAssessmentMethod">
				
			</div>
		</td></tr>
		<%} %>
		
		
		
	</table>
</div>
<div>
	Assessment options entered as "ongoing" will be evenly distributed between the entries marked with an *.
</div>
<hr/>
<%long time = System.currentTimeMillis(); %>
<div id="assessmentMethodsBargraphDiv" style="width:550px;height:300px;">
	<img src="/cat/auth/courseOffering/assessmentMethodBargraph.jsp?course_offering_id=<%=courseOffering.getId()%>&bogus_param=<%=time%>"/>
</div>
<div id="assessmentMethodGroupsDiv" style="width:550px;height:300px;">
	<img src="/cat/auth/courseOffering/assessmentMethodGroups.jsp?course_offering_id=<%=courseOffering.getId()%>&bogus_param=<%=time%>"/>	
</div>
