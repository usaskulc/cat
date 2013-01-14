<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
Organization organization = new Organization();
String organizationName = request.getParameter("organizationName");
boolean organizationKnown = false;
if(HTMLTools.isValid(organizationName))
{
	organization = OrganizationManager.instance().getOrganizationByName(organizationName);	
	organizationKnown = true;
}
List<Organization> organizations =  OrganizationManager.instance().getAllOrganizations(false);
Organization choose = new Organization();
choose.setName("Please select a organization to edit");
choose.setId(0);
organizations.add(0,choose);
%>
Select a organization from the list below (to edit a organization) (or click "create new" to create a new organization)


<form name="genericFieldForm" id="genericFieldForm" method="post" action="" >
	
	<div class="formElement">
		<div class="label">Organization:</div>
		<div class="field">
			<%=HTMLTools.createSelect("organization", organizations, "id", "name", organizationKnown?""+organization.getId():null, "editOrganization('organization');")%>
		</div>
		<div class="error" id="new_valueMessage" style="padding-left:10px;"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button"
		           value="Create new" 
				   onclick="editOrganization();" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	
	</form>

