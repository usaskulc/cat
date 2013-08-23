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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
OutcomeManager om = OutcomeManager.instance();
Program program = ProgramManager.instance().getProgramById(Integer.parseInt(programId));
String outcomeParameter = request.getParameter("outcome");
ProgramOutcome outcome = null;
if(HTMLTools.isValid(outcomeParameter))
{
	outcome = om.getProgramOutcomeByName(outcomeParameter);
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
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<div class="formElement">
		<div class="label">Outcome:</div>
		<div class="field"> 
		<%
 			List<ProgramOutcome> list = om.getProgramOutcomesForProgram(program);
 				out.println(HTMLTools.createSelectProgramOutcomes("outcomeToAdd", list, outcome!=null?""+outcome.getId():null));
 		%>
 		<br/>
 		<a href="javascript:loadModify('/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>&organization_id=<%=organizationId%>');" class="smaller">Create/Modify Program outcomes</a>
		</div>
		
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveProgramOutcomeButton" id="saveProgramOutcomeButton" value="Add Program Outcome" onclick="saveProgram(new Array('outcomeToAdd'),new Array('outcomeToAdd','program_id'),'ProgramOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<div id="newOutcomeDiv" class="fake-input" style="display:none;"></div> 
</form>

		
