<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String organizationId = request.getParameter("organization_id");
String courseOfferingId = request.getParameter("course_offering_id");
String name = request.getParameter("name");

Assessment createdAssessment = null;
CourseManager cm = CourseManager.instance();
if(name!=null)
{
	createdAssessment = cm.getAssessmentByName(name);
}
int assessmentMethodLinkId = HTMLTools.getInt(request.getParameter("assessment_link_id"));
LinkCourseOfferingAssessment o = new LinkCourseOfferingAssessment();
CourseOffering courseOffering = new CourseOffering();

boolean linkLoaded = false;
String assessmentId = null;
if(assessmentMethodLinkId > -1)
{
	o = cm.getLinkAssessmentById(assessmentMethodLinkId);
	linkLoaded = true;
	courseOffering = o.getCourseOffering();
	courseOfferingId = ""+courseOffering.getId();
	assessmentId = ""+ o.getAssessment().getId();
}
else 
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}
out.println(HTMLTools.createSelectAssessmentMethods("assessmentMethod", cm.getAssessments(),assessmentId));
	
%>
		
	


