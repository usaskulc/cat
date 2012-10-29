<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*, java.text.NumberFormat"%>
<%
String departmentId = request.getParameter("department_id") ;
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
 Repeat using both drop-down menus for additional entries.
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
			<td><%=(displayIndex+1)%> <%=outcome.getName()%></td><td><%=infoDisplay %>, <%=formatter.format(link.getWeight())%> %, <%=link.getWhen().getName()%>
				 <%if(access){%>
				 	<a href="javascript:editOutcomeAssessment(<%=courseOfferingId%>,<%=outcomeLink.getId()%>);" class="smaller"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove" ></a>
				 	<%}%></td>
		</tr>
			<% 
		}
		
		if(access)
		{
		%>
		<tr><td><%=HTMLTools.createSelect("new_course_outcome",outcomes,null,null,false) %></td>
			<td><%=HTMLTools.createSelect("new_assessment_link", list, new Integer(-1),true)%>
			    <input type="button" onclick="editOutcomeAssessment(<%=courseOfferingId %>,-1);" value="add"/>
			</td>
		</tr>
		<%} %>
		
		
		
	</table>
</div>
<hr/>
