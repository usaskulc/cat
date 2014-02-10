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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
Program o = new Program();
String id = request.getParameter("program_id");
String organizationId = request.getParameter("organization_id");
String organizationName="";
if(id != null  && id.trim().length() > 0)
{
	o = ProgramManager.instance().getProgramById(Integer.parseInt(id));
	organizationName = OrganizationManager.instance().getOrganizationByProgram(o).getName();
}
else if(organizationId != null  && organizationId.trim().length() > 0)
{
	Organization org = OrganizationManager.instance().getOrganizationById(Integer.parseInt(organizationId));
	organizationName = org.getName();	
}
%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>
<h4><%=o.getId() > 0?"Modify":"Create"%> a Program (part of <%=organizationName%>) Eg. B.Sc. (Four Year) in Biology</h4>
<hr/>
<form name="newObjectForm" id="newObjectForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Program"/>
	<% if(o.getId() > 0)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<%
		}
		else if(organizationId != null  && organizationId.trim().length() > 0)
		{
			%><input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
			<%
		}
		%>
	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="50" name="name" id="name" value="<%=o.getName()==null?"":o.getName()%>"/></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<!-- <div class="formElement">
		<div class="label">Description:</div>
		<div class="field"> <textarea name="description" id="description" cols="40" rows="6"><%=o.getDescription()==null?"":o.getDescription()%></textarea></div>
		<div class="spacer"> </div>
	</div> -->
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveProgram(new Array('name'),new Array('name','description','organization_id'),'Program');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		
