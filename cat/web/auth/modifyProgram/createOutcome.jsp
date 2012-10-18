<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
ProgramManager manager = ProgramManager.instance();
Program 	program = manager.getProgramById(Integer.parseInt(programId));
%>
<div id="newOutComeFormDiv">
<form name="newOutcomeForm" id="newOutcomeForm" method="post" action="" >
	<input type="hidden" name="program_id" id="program_id" value="<%=program.getId()%>"/>
	<div class="formElement">
		<div class="label">Outcome (short):</div>
		<div class="field"> <input type="text" size="80" value="" id="newOutcomeName" /></div>
		<div class="error" id="newOutcomeNameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br>
	<div class="formElement">
		<div class="label">This outcome is specific to the program  <%=program.getName()%>:</div>
		<div class="field"> <input type="checkbox"  value="true" id="newOutcomeProgramSpecific" /></div>
		<div class="error" id="newOutcomeProgramSpecificMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br>
	<div class="formElement">
		<div class="label"><input type="button" name="saveNewOutcomeButton" id="saveNewOutcomeButton" value="Add New Outcome" onclick="saveProgram(new Array('newOutcomeName'),new Array('newOutcomeName','program_id','newOutcomeProgramSpecific'),'NewProgramOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>
</div>


		