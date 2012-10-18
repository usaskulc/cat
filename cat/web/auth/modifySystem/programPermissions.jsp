<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
String programId = request.getParameter("program_id");
PermissionsManager manager = PermissionsManager.instance();
List<ProgramAdmin> list = manager.getAdminsForGroup(programId);

LdapConnection ldap = LdapConnection.instance();
String prevType="";

for(ProgramAdmin programAdmin : list)
{
	if(!prevType.equals(programAdmin.getType()))
	{
		if(prevType.length()>0)
		{
			out.println("</ul>");
		}
		out.println("<h3>"+programAdmin.getType()+"</h3><ul>");
	}
%>
	<li><%=manager.getDisplayName(programAdmin)%><a href="javascript:modifyPermission(<%=programId%>,-1,'<%=programAdmin.getType()%>',escape('<%=programAdmin.getName().replaceAll("'","\\\\'")%>'),'delete',<%=programAdmin.getId()%>);">
				<img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove"/></a>
	<% if (programAdmin.getType().equalsIgnoreCase("LDAP"))
	{%>			
				<a href="javascript:loadURLIntoId('/cat/auth/modifySystem/ldapGroupMembers.jsp?group_name='+escape('<%=programAdmin.getName().replaceAll("'","\\\\'")%>'),'#membersDiv');" class="smaller">Show Members</a>
	<%}%>
	</li>

<%
	prevType = programAdmin.getType();
}%>
	
</ul>
<hr/>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/addPermission.jsp?program_id=<%=programId%>','membersDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add Group or person
			</a>
<br/>
<div id="messageDiv" class="completeMessage"></div>
<hr/>
<div id="membersDiv"></div>