<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
CourseManager manager = CourseManager.instance();
String action = request.getParameter("action");


if(action.equals("delete"))
{
	int linkId = HTMLTools.getInt(request.getParameter("user_or_link"));
	
	if(manager.removeInstructorFromCourseOffering(linkId))
	{
		out.println("Instructor removed");
	}
	else
	{
		out.println("ERROR: removing Instructor");
	}
}
else if(action.equals("add"))
{
	int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
	String instructorUserid = request.getParameter("user_or_link");
	
	if(manager.addInstructorToCourseOffering(instructorUserid, courseOfferingId))
	{
		out.println("Instructor added");
	}
	else
	{
		out.println("ERROR: adding Instructor");
	}
}
else
{
	out.println("ERROR: don't know what to do, action ["+action+"] not recognized.");
}

%>
		