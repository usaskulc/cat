<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<h2>Organization Permissions</h2>

<ul>
<%
LdapConnection ldap = LdapConnection.instance();

List<Organization> organizations = OrganizationManager.instance().getAllOrganizations();
for(Organization organization : organizations)
{
%>
	<li><%=organization.getName()%> <a href="javascript:deleteOrganization(<%=organization.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Delete"/></a> <a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/organizationPermissions.jsp?organization_id=<%=organization.getId()%>','modifyDiv');" class="smaller">
			<img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit"/>
				Edit Permissions
			</a></li>

<%
}
%>
</ul>
	<div class="formElement">
		<div class="label">&nbsp;</div>
		<div class="field"><div id="message2Div" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>

<hr/>
<h2>System Permissions</h2>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/systemPermissions.jsp','modifyDiv');">
				<img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit"/>
				System Permissions
</a>

<hr/>
<h2>Importing Course Offerings</h2>
<a href="importCourses.jsp" target="_blank">Course Import</a>
