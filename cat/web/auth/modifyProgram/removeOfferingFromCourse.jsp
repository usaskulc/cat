<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");

CourseManager manager = CourseManager.instance();

if(manager.removeCourseOfferingFromCourse(Integer.parseInt(courseOfferingId)))
{
	out.println("CourseOffering removed");
}
else
{
	out.println("ERROR: removing courseOffering");
}
%>
		