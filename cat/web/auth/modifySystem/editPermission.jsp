<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));

String name = request.getParameter("name");
String first = request.getParameter("first");
String last = request.getParameter("last");

String type = request.getParameter("type");
String command = request.getParameter("command");
String permissionId = request.getParameter("permission_id");
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");

PermissionsManager manager = PermissionsManager.instance();
if(programId < 0 && organizationId < 0) // must be a system-permission
{
	if(command.equals("add"))
	{
		if(manager.saveSystemPermission(type,name, userid,first,last))
		{
			out.println("Permission added");
		}
		else
		{
			out.println("ERROR: could not add permission");
		}
	}
	else if (command.equals("delete"))
	{
		if(manager.removeSystemPermission(permissionId))
		{
			out.println("Permission removed");
		}
		else
		{
			out.println("ERROR: could not remove permission");
		}
	}
}

else if(organizationId > -1)
{
	if(command.equals("add"))
	{
		if(manager.saveOrganizationPermission(organizationId,type,name,first,last))
		{
			out.println("Permission added");
		}
		else
		{
			out.println("ERROR: could not add permission");
		}
	}
	else if (command.equals("delete"))
	{
		if(manager.removeOrganizationPermission(permissionId))
		{
			out.println("Permission removed");
		}
		else
		{
			out.println("ERROR: could not remove permission");
		}
	}
}

%>