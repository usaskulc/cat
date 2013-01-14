<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
CourseManager manager = CourseManager.instance();
String action = request.getParameter("action");

if(action.equals("removeOrganization"))
{
	int linkId = HTMLTools.getInt(request.getParameter("dept_link_id"));
	
	if(manager.removeOrganizationFromCourse(linkId))
	{
		out.println("Organization removed");
	}
	else
	{
		out.println("ERROR: removing Organization");
	}
}
%>
		