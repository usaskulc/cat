<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
OrganizationManager manager = OrganizationManager.instance();
String action = request.getParameter("action");

if(action.equals("removeType"))
{
	int linkId = HTMLTools.getInt(request.getParameter("link_id"));
	
	if(manager.removeCourseAttribute(linkId))
	{
		out.println("Course Attribute removed");
	}
	else
	{
		out.println("ERROR: removing Course Attribute");
	}
}
else if(action.equals("removeValue"))
{
	String linkId = request.getParameter("link_id");
	
	if(manager.removeCourseAttributeValue(Integer.parseInt(linkId)))
	{
		out.println("Course Attribute removed");
	}
	else
	{
		out.println("ERROR: removing Course Attribute");
	}
}
%>
		