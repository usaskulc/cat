<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
String organizationId = request.getParameter("organization_id");
Organization organization  = OrganizationManager.instance().getOrganizationById(Integer.parseInt(organizationId));
%>
<h2>Access Permissions for "<%=organization.getName()%>" granted to:</h2>
<%
PermissionsManager manager = PermissionsManager.instance();
List<OrganizationAdmin> list = manager.getAdminsForOrganization(organizationId);

LdapConnection ldap = LdapConnection.instance();
String prevType="";

for(OrganizationAdmin organizationAdmin : list)
{
	if(!prevType.equals(organizationAdmin.getType()))
	{
		if(prevType.length()>0)
		{
			out.println("</ul>");
		}
		out.println("<h3>"+organizationAdmin.getTypeDisplay()+"</h3><ul>");
	}
%>
	<li><%=manager.getDisplayName(organizationAdmin)%><a href="javascript:modifyPermission(-1,<%=organizationId%>,'<%=organizationAdmin.getType()%>',escape('<%=organizationAdmin.getName().replaceAll("'","\\\\'")%>'),'delete',<%=organizationAdmin.getId()%>);">
				<img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove"/></a>
	<% if (organizationAdmin.getType().equalsIgnoreCase("LDAP"))
	{%>			
				<a href="javascript:loadURLIntoId('/cat/auth/modifySystem/ldapGroupMembers.jsp?group_name='+escape('<%=organizationAdmin.getName().replaceAll("'","\\\\'")%>'),'#membersDiv');'"class="smaller">Show Members</a>
	<%}%>
	</li>

<%
	prevType = organizationAdmin.getType();
}%>
	
</ul>
<hr/>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/addPermission.jsp?organization_id=<%=organizationId%>','membersDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add Department or Person
			</a>
<br/>
<div id="messageDiv" class="completeMessage"></div>
<hr/>
<div id="membersDiv"></div>