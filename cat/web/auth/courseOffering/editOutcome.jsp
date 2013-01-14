<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,org.hibernate.validator.Length"%>
<%
int id = HTMLTools.getInt(request.getParameter("id"));
String value = "";
String deptId = request.getParameter("organization_id");
if(id >= 0)
{
	CourseOutcome outcome = OrganizationManager.instance().getCourseOutcomeById(id);
	value = outcome.getName();
}
%>

<form name="genericFieldForm" id="genericFieldForm" method="post" action="" >
	<input type="hidden" name="organization_id" id="organization_id" value="<%=deptId%>" />
	<% if(id >= 0)
		{
			%><input type="hidden" name="id" id="id" value="<%=id%>"/>
			<%
		}
		%>
	<div class="formElement">
		<div class="label">Name :</div>
		<div class="field">
			 <input type="text" size="60" maxlength="100" name="value" id="value" value="<%=value%>"/>
		</div>
		<div class="error" id="valueMessage" style="padding-left:10px;"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveOffering(new Array('value'),new Array('value','id'),'EditCourseOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		
