<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
Department o = new Department();
String id = request.getParameter("department_id");
if(HTMLTools.isValid(id))
{
	o = DepartmentManager.instance().getDepartmentById(Integer.parseInt(id));
}
%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>
<h4><%=o.getId() > 0?"Modify":"Create"%> a Department</h4>
<hr/>
<form name="newObjectForm" id="newObjectForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Program"/>
	<% if(o.getId() > 0)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<%
		}%>
	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="50" name="name" id="name" value="<%=o.getName()==null?"":o.getName()%>"/></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveOffering(new Array('name'),new Array('name'),'Department');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	<div id="departmentCharacteristicsDiv">
		<jsp:include page="departmentCharacteristics.jsp"/>
	</div>
	
	
</form>

		