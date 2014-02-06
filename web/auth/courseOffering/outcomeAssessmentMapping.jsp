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
OutcomeManager om = OutcomeManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}
List<CourseOutcome> outcomes = om.getOutcomesForCourseOffering(courseOffering);
List<LinkCourseOfferingAssessment> list = cm.getAssessmentsForCourseOffering(courseOffering);
List<LinkAssessmentCourseOutcome> existingLinks = om.getLinkAssessmentCourseOutcomes(Integer.parseInt(courseOfferingId));
NumberFormat formatter = NumberFormat.getInstance();
formatter.setMaximumFractionDigits(1);
%>
<h2>How I Assess for My Course Learning Outcomes</h2>
<p>
This section gathers information on how your course learning outcomes are being assessed 
including any alignment between your goals for students' learning and how they demonstrate that learning.
<br/>
To link a course learning outcome to an assessment, select one of your course learning outcomes from the
 drop-down menu and then in the same row select the relevant assessment. Click "Add". 
Repeat using both drop-down menus for additional entries, including for matching multiple assessments with a single outcome.
 
 
 
 
</p>
<div>
	<table cellpadding="0" cellspacing="0" border="1">
		<tr><th>Course Learning Outcome</th><th>Assessed By:</th></tr>
		<%
		for(LinkAssessmentCourseOutcome outcomeLink : existingLinks)
		{
			CourseOutcome outcome = outcomeLink.getOutcome();
			int displayIndex = om.getCourseOutcomeIndex(outcomes, outcome.getId());
			LinkCourseOfferingAssessment link = outcomeLink.getAssessmentLink();
			String additionalInfo = link.getAdditionalInfo();
			AssessmentGroup group = link.getAssessment().getGroup();
			String infoDisplay = "";
			if(group != null)
				infoDisplay = link.getAssessment().getGroup().getShortName()+ ": ";
			
			infoDisplay += link.getAssessment().getName() + (HTMLTools.isValid(additionalInfo)?" ( "+additionalInfo+" )":"");
			%>
		<tr>
			<td><%=(displayIndex)%> <%=outcome.getName()%></td><td><%=infoDisplay %>, <%=formatter.format(link.getWeight())%> %, <%=link.getWhen().getName()%>
				 <%if(access){%>
				 	<a href="javascript:editOutcomeAssessment(<%=courseOfferingId%>,<%=outcomeLink.getId()%>);" class="smaller"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove outcome assessment link" title="Remove outcome assessment link" ></a>
				 	<%}%></td>
		</tr>
			<% 
		}
		
		if(access)
		{
		%>
		<tr><td><%=HTMLTools.createSelect("new_course_outcome",outcomes,null,null) %></td>
			<td><%=HTMLTools.createSelect("new_assessment_link", list, new Integer(-1),true)%>
			    <input type="button" onclick="editOutcomeAssessment(<%=courseOfferingId %>,-1);" value="add"/>
			</td>
		</tr>
		<%} %>
		
		
		
	</table>
</div>
<hr/>
