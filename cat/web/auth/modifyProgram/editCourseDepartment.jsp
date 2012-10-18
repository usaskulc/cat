<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
CourseManager manager = CourseManager.instance();
String action = request.getParameter("action");

if(action.equals("removeDepartment"))
{
	int linkId = HTMLTools.getInt(request.getParameter("dept_link_id"));
	
	if(manager.removeDepartmentFromCourse(linkId))
	{
		out.println("Department removed");
	}
	else
	{
		out.println("ERROR: removing Department");
	}
}
%>
		