<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id") ;
try
{
@SuppressWarnings("unchecked")
HashMap<String,CourseOffering> userHasAccessToOfferings = (HashMap<String,CourseOffering>)session.getAttribute("userHasAccessToOfferings");

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin || (userHasAccessToOfferings!=null && userHasAccessToOfferings.containsKey(courseOfferingId));
CourseOffering courseOffering = new CourseOffering();
CourseManager cm = CourseManager.instance();
OrganizationManager dm = OrganizationManager.instance();
OutcomeManager om = OutcomeManager.instance();
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}
%>
<h2>Additional Information</h2>
<div id="courseOfferingComments">
	<%=courseOffering.getComments()==null?"No additional information entered. Select edit icon below to add additional information about your course.":courseOffering.getComments() %>
	
</div>
<br/>
<%if(access){%><a href="javascript:loadModify('/cat/auth/courseOffering/editComments.jsp?course_offering_id=<%=courseOfferingId%>','courseOfferingComments');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit comment" title="Edit comment"></a> <%}%>

<%}
catch(Exception e)
{
out.println(e);
}
%>