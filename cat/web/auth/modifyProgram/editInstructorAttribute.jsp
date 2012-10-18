<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
OrganizationManager manager = OrganizationManager.instance();
String action = request.getParameter("action");

if(action.equals("removeType"))
{
	int linkId = HTMLTools.getInt(request.getParameter("link_id"));
	
	if(manager.removeAttribute(linkId))
	{
		out.println("Instructor Attribute removed");
	}
	else
	{
		out.println("ERROR: removing Instructor Attribute");
	}
}
else if(action.equals("removeValue"))
{
	String linkId = request.getParameter("link_id");
	
	if(manager.removeAttributeValue(Integer.parseInt(linkId)))
	{
		out.println("Instructor Attribute removed");
	}
	else
	{
		out.println("ERROR: removing Instructor Attribute");
	}
}
%>
		