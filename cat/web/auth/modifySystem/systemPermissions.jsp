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
				<img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove"/></a>
	</li>
<%
}%>
	
</ul>
<hr/>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/addPermission.jsp?program_id=-1','membersDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add a Person
			</a>
<br/>
<div id="messageDiv" class="completeMessage"></div>
<hr/>
<div id="membersDiv"></div>