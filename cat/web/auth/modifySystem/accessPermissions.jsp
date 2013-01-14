<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%String clientBrowser=request.getHeader("User-Agent");
//simplify the client browser
if(clientBrowser.indexOf("Mac")>-1)
	clientBrowser="mac";
else if (clientBrowser.indexOf("Linux")>-1)
	clientBrowser="linux";
else
	clientBrowser="windows"; %>

<a href="javascript:toggleDisplay('organizationPermissionsSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="organizationPermissionsSection_img">Manage Organization Permissions</a>
<div id="organizationPermissionsSection_div" style="display:none;">
					
<h2>Organization Permissions</h2>

<ul>
<%
List<Organization> organizations = OrganizationManager.instance().getAllOrganizations(false);
for(Organization organization : organizations)
{
%>
	<li><span style="color:<%=organization.getActive().equals("Y")?"black":"grey"%>;"><%=organization.getName()%> <%=organization.getActive().equals("Y")?"":"(inactive)"%></span>
<a href="javascript:deleteOrganization(<%=organization.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Delete"/></a> 
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/organizationPermissions.jsp?organization_id=<%=organization.getId()%>','modifyDiv');" class="smaller">
			<img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit"/>
				Edit Permissions
			</a></li>

<%
}
%>
</ul>
</div>
	<div class="formElement">
		<div class="label">&nbsp;</div>
		<div class="field"><div id="message2Div" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>

<hr/>
<a href="javascript:toggleDisplay('systemSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="systemSection_img">Manage System Permissions</a>
						<div id="systemSection_div" style="display:none;">
						
<h2>System Permissions</h2>
<a href="javascript:loadModifyIntoDiv('/cat/auth/modifySystem/systemPermissions.jsp','modifyDiv');">
				<img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit"/>
				System Permissions
</a>
</div>
<hr/>
<a href="javascript:toggleDisplay('importSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="importSection_img">Course Import</a>
						<div id="importSection_div" style="display:none;">
						
<h2>Importing Course Offerings</h2>
<a href="importCourses.jsp" target="_blank">Course Import</a>
</div>