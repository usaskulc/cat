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
<h3>System Administration Permissions</h3>
<ul>
<%
PermissionsManager manager = PermissionsManager.instance();
List<SystemAdmin> list = manager.getSystemAdmins();

LdapConnection ldap = LdapConnection.instance();

for(SystemAdmin systemAdmin : list)
{
%>
	<li><%=manager.getDisplayName(systemAdmin)%><a href="javascript:modifyPermission(-1,-1,'<%=systemAdmin.getType()%>',escape('<%=systemAdmin.getName().replaceAll("'","\\\\'")%>'),'','','delete',<%=systemAdmin.getId()%>);">
				<img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove permission" title="Remove permission"/></a>
	</li>
<%
}%>
	
</ul>
<hr/>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/addPermission.jsp?program_id=-1','membersDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add person"/>
				Add a Person
			</a>
<br/>
<div id="messageDiv" class="completeMessage"></div>
<hr/>
<div id="membersDiv"></div>
