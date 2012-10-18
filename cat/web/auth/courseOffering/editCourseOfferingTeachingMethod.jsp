<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
CourseManager manager = CourseManager.instance();
String courseOfferingId = request.getParameter("course_offering_id");
String teachingMethodId = request.getParameter("teaching_method_id");

String howLongId = request.getParameter("how_long_id");
if(HTMLTools.isValid(howLongId))
{
	if(howLongId.equals("-1"))
	{
		if(manager.deleteTeachingMethod(Integer.parseInt(courseOfferingId), Integer.parseInt(teachingMethodId)))
		{
			out.println("removed");
		}
		else
		{
			out.println("ERROR: Unable to remove Teachingmethod!");
		}
	}
	else
	{
		if(manager.addTeachingMethod(Integer.parseInt(courseOfferingId), Integer.parseInt(teachingMethodId),Integer.parseInt(howLongId)))
		{
			out.println("saved");
		}
		else
		{
			out.println("ERROR: Unable to save Teachingmethod changes!");
		}
	}
}
else
{
	out.println("ERROR: don't know what to do. No time id.");
}
%>
		