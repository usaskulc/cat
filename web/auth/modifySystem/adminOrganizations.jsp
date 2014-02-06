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

