<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<h2>Organizations:</h2>

<ul>
<%
LdapConnection ldap = LdapConnection.instance();

List<Organization> organizations = OrganizationManager.instance().getAllOrganizations();
for(Organization organization : organizations)
{
%>
	<li><%=organization.getName()%> <a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/organizationPermissions.jsp?organization_id=<%=organization.getId()%>','modifyDiv');" class="smaller">
				<img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit"/>
				Edit Permissions
			</a></li>

<%
}
%>
</ul>

<hr/>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/systemPermissions.jsp','modifyDiv');">
				<img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit"/>
				System Permissions
</a>

<hr/>
<a href="importCourses.jsp" target="_blank">Course Import</a>
