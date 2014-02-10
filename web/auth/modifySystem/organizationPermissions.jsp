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


<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
String organizationId = request.getParameter("organization_id");
Organization organization  = OrganizationManager.instance().getOrganizationById(Integer.parseInt(organizationId));
%>
<h2>Access Permissions for "<%=organization.getName()%>" granted to:</h2>
<ul>
<%
PermissionsManager manager = PermissionsManager.instance();
List<OrganizationAdmin> list = manager.getAdminsForOrganization(organizationId);

LdapConnection ldap = LdapConnection.instance();

for(OrganizationAdmin organizationAdmin : list)
{
%>
	<li><%=manager.getDisplayName(organizationAdmin)%><a href="javascript:modifyPermission(-1,<%=organizationId%>,'<%=organizationAdmin.getType()%>',escape('<%=organizationAdmin.getName().replaceAll("'","\\\\'")%>'),'','','delete',<%=organizationAdmin.getId()%>);">
				<img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove permission" title="Remove permission"/></a>
	</li>

<%
}%>
	
</ul>
<hr/>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/addPermission.jsp?organization_id=<%=organizationId%>','membersDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add person" title="Add person"/>
				Add a Person
			</a>
<br/>
<div id="messageDiv" class="completeMessage"></div>
<hr/>
<div id="membersDiv"></div>
