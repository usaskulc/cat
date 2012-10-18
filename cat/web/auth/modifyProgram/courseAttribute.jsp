<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String organizationId = request.getParameter("organization_id");
Organization organization = OrganizationManager.instance().getOrganizationById(Integer.parseInt(organizationId));
%>

<form name="newForm" id="newForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="CourseAttribute"/>
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
	<div class="formElement">
		<div class="label">Attribute name:</div>
		<div class="field">
			 <input type="text" size="60" maxlength="100" name="name" id="name" value=""/>
		</div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Add Course Attribute" 
			onclick="saveProgram(new Array('name'),new Array('name','organization_id'),'CourseAttribute');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
</form>

		