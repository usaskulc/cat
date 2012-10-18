<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
Organization organization = OrganizationManager.instance().getOrganizationById(organizationId);
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
String outcomeParameter = request.getParameter("outcome");
OutcomeManager om = OutcomeManager.instance();
OrganizationOutcome outcome = null;
if(HTMLTools.isValid(outcomeParameter))
{
	outcome = OutcomeManager.instance().getOrganizationOutcomeByName(outcomeParameter);
}

String programName = "";
%>
<script type="text/javascript">
	$(document).ready(function() 
		{
			$(".error").hide();
		});
</script>
<form name="newProgramOutcomeForm" id="newProgramOutcomeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="ProgramOutcome"/>
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
	<div class="formElement">
		<div class="label">Outcome:</div>
		<div class="field"> 
		<%
 			List<OrganizationOutcome> list = OrganizationManager.instance().getOrganizationOutcomesForOrg(organization);
 				out.println(HTMLTools.createSelectOrganizationOutcomes("outcomeToAdd", list, null));
 		%>
 		<br/>
 		<%if(sysadmin){ %>
 		<a href="javascript:loadModify('/cat/auth/modifyProgram/editOrganizationOutcomes.jsp?organization_id=<%=organizationId%>');" class="smaller">Edit outcomes</a>
		<%} %>
		</div>
		
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<div class="formElement">
		<div class="label">
			<input type="button" name="saveButton" id="saveButton" value="Add Organization Outcome" 
						onclick="saveProgram(new Array('outcomeToAdd'),new Array('outcomeToAdd','organization_id'),'OrganizationOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<div id="newOutcomeDiv" class="fake-input" style="display:none;"></div> 
</form>

		