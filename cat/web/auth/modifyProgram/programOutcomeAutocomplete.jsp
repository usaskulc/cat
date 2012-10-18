<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
OutcomeManager om = OutcomeManager.instance();
Program program = ProgramManager.instance().getProgramById(Integer.parseInt(programId));

String programName = "";
%>
<link href="/cat/included/jquery.autocomplete.css" rel="stylesheet" type="text/css"/>
<script src="/cat/included/jquery.autocomplete.js" type="text/javascript"></script>
<script type="text/javascript">
function findValue(li) {
  	if( li == null ) return alert("No match!");

  	// if coming from an AJAX call, let's use the CityId as the value
  	if( !!li.extra ) var sValue = li.extra[0];

  	// otherwise, let's just display the value in the text box
  	else var sValue = li.selectValue;

  	//alert("The value you selected was: " + sValue);
  }

  function selectItem(li) {
    	findValue(li);
  }

  function formatItem(row) {
    	return row[0] ;//+ " (id: " + row[1] + ")";
  }

  function lookupAjax(){
  	var oSuggest = $("#outcomeToAdd")[0].autocompleter;
    oSuggest.findValue();
  	return false;
  }

$(document).ready(function() 
{

    $("#outcomeToAdd").autocomplete(
    	      "/cat/getOutcomeAutocomplete.jsp?program_id=<%=programId%>",
    	      {
    	  			delay:10,
    	  			minChars:3,
    	  			matchSubset:1,
    	  			matchContains:1,
    	  			cacheLength:10,
    	  			onItemSelect:selectItem,
    	  			onFindValue:findValue,
    	  			formatItem:formatItem,
    	  			autoFill:true
    	  		}
    	    );
    	  
});
</script>
<h2>Adding an outcome</h2>
<form name="newProgramOutcomeForm" id="newProgramOutcomeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="ProgramOutcome"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<div class="formElement">
		<div class="label">Outcome:</div>
		<div class="field"> <input type="text" style="width: 300px;" value="" id="outcomeToAdd" class="ac_input"/> 
		<a href="javascript:loadModifyIntoDiv('/cat/auth/department/newOutcome.jsp?program_id=<%=programId%>','newOutcomeDiv');">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add an outcome (the one I need doesn't show up) 
			</a>
		<div id="newOutcomeDiv" class="fake-input" style="display:none;"></div> </div>
		
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveProgramOutcomeButton" id="saveProgramOutcomeButton" value="Add Program Outcome" onclick="saveProgram(new Array('outcomeToAdd'),new Array('outcomeToAdd','program_id'),'ProgramOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		