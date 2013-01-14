<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("courseOffering_id");
String programId = request.getParameter("program_id");
String characteristicId = request.getParameter("char_id");
OutcomeManager om = OutcomeManager.instance();
Characteristic characteristic = om.getCharacteristicById(Integer.parseInt(characteristicId));

CourseOffering courseOffering = CourseManager.instance().getCourseOfferingById(Integer.parseInt(courseOfferingId));
Program program = ProgramManager.instance().getProgramById(Integer.parseInt(programId));

String programName = "";
%>
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
  	var oSuggest = $("#Outcome")[0].autocompleter;
    oSuggest.findValue();
  	return false;
  }
$(document).ready(function() 
{
	$(".error").hide();
    $("#Outcome").autocomplete(
    	      "getOutcomeAutocomplete.jsp?program_id=<%=programId%>",
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
<h2>Adding an outcome for <%=courseOffering.getSubject()%> <%=courseOffering.getCourseOfferingNumber()%> </h2>
Main characteristic : <%=characteristic.getName()%> (<%=characteristic.getDescription()%>)
<hr/>
<form name="newCourseOfferingOutcomeForm" id="newCourseOfferingOutcomeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="CourseOfferingOutcome"/>
	<input type="hidden" name="courseOffering_id" id="courseOffering_id" value="<%=courseOfferingId%>"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<input type="hidden" name="char_id" id="char_id" value="<%=characteristicId%>"/>
	<input type="hidden" name="char_type" id="char_type" value="<%=characteristic.getCharacteristicType().getId()%>"/>
	<div class="formElement">
		<div class="label">Outcome:</div>
		<div class="field"> <input type="text" style="width: 200px;" value="" id="Outcome" class="ac_input"/> 
		<a href="javascript:loadModifyIntoDiv('/cat/auth/organization/newOutcome.jsp?program_id=<%=programId%>','newOutcomeDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add an outcome (the one I need doesn't show up) 
			</a>
		<div id="newOutcomeDiv" class="fake-input" style="display:none;"></div> </div>
		
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<%
	String parameterString = "";
	List<CharacteristicType> charTypes = program.getCharacteristicTypes();
	for(int i=1; i< charTypes.size() ; i++)
	{
		CharacteristicType temp = charTypes.get(i);
		%>
			<jsp:include page="/auth/organization/characteristicType.jsp">
				<jsp:param name="charTypeId" value="<%=temp.getId()%>"/>
				<jsp:param name="index" value="<%=i%>"/>
			</jsp:include>
		<% 
		parameterString += ",'characteristic_"+i+"','characteristic_type_"+i+"'";
	}
	%>
	<input type="hidden" name="char_count" id="char_count" value="<%=charTypes.size()%>"/>
		<div class="formElement">
		<div class="label"><input type="button" name="saveCourseOfferingOutcomeButton" id="saveCourseOfferingOutcomeButton" value="Add CourseOffering Outcome" onclick="saveProgram(new Array('Outcome'),new Array('Outcome'<%=parameterString%>,'program_id','courseOffering_id','char_id','char_type','char_count'),'CourseOfferingOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		