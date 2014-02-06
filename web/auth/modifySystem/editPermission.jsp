<%-- 
    Copyright 2012, 2013 University of Saskatchewan

    This file is part of the Curriculum Alignment Tool (CAT).

    CAT is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    CAT is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with CAT.  If not, see <http://www.gnu.org/licenses/>.
--%>


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
