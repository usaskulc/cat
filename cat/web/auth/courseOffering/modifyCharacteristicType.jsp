<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
CharacteristicManager cm = CharacteristicManager.instance();
CharacteristicType cType = new CharacteristicType();
List<Characteristic> characteristics = new ArrayList<Characteristic>(0);

boolean loaded = false;
String id = request.getParameter("characteristic_type_id");
if(id != null  && id.trim().length() > 0)
{
	cType = cm.getCharacteristicTypeById(id);
	characteristics = cm.getCharacteristicsForType(cType);
	loaded = true;
}
%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>
<form name="newCharacterTypeForm" id="newCharacterTypeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="CharacteristicType"/>
	<% if(loaded)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=cType.getId()%>"/>
			<%
		}
		%>
	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="80" name="name" id="name" value="<%=loaded?cType.getName():""%>"/></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">Value-Type: (Boolean for true/false, String otherwise)</div>
		<div class="field"> <input type="radio" name="valueType" id="valueType" value="Boolean" checked="<%=loaded?(cType.getValueType().equals("Boolean")?"CHECKED":""):""%>"/>Boolean &nbsp; &nbsp; 
							<input type="radio" name="valueType" id="valueType" value="String" checked="<%=loaded?(cType.getValueType().equals("String")?"CHECKED":""):""%>"/>String
		</div>
		<div class="error" id="valueTypeMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">Question Display:</div>
		<div class="field"> <input type="text" size="80" name="questionDisplay" id="questionDisplay" value="<%=loaded?cType.getQuestionDisplay():""%>"/></div>
		<div class="error" id="questionDisplayMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveCharacteristicTypeButton" id="saveCharacteristicTypeButton" value="Save Characteristic Type" onclick="saveOffering(new Array('name','valueType'),new Array('name','valueType','questionDisplay'),'CharacteristicType');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		