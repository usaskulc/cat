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
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int organizationOutcomeId = HTMLTools.getInt(request.getParameter("organization_outcome_id"));

ProgramManager pm = ProgramManager.instance();
Program program = pm.getProgramById(programId);

OrganizationManager dm = OrganizationManager.instance();
OrganizationManager om = OrganizationManager.instance();
OutcomeManager ocm = OutcomeManager.instance();
boolean access = true;


OrganizationOutcome organizationOutcome = om.getOrganizationOutcomeById(organizationOutcomeId);
List<ProgramOutcome> associatedProgramOutcomes = ocm.getOutcomesForProgram(program);  

List<ProgramOutcome> notYetLinked = new ArrayList<ProgramOutcome>();
List<LinkProgramOutcomeOrganizationOutcome> links = om.getProgramOutcomeLinksForOrganizationOutcome(program, organizationOutcome);
%>
<h5>Mapping of Program Outcomes to Organization Outcome :<%=organizationOutcome.getGroup().getName()%> - <%=organizationOutcome.getName()%></h5>

<ul>
<%
for(ProgramOutcome candidateOutcome : associatedProgramOutcomes)
{
	boolean found = false;
	for (LinkProgramOutcomeOrganizationOutcome existingLink : links)
	{
		if(existingLink.getProgramOutcome().getId() == candidateOutcome.getId())
		{
			found = true;	
			%>
			<li><strong><%=organizationOutcome.getName()%></strong> is linked to <strong><%=candidateOutcome.getName()%></strong>
				<a href="javascript:deleteOrganizationOutcomeMapping(<%=programId%>, <%=organizationOutcomeId%>,<%=existingLink.getId()%>);" class="smaller"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Delete outcome link" title="Delete outcome link"/></a>
			</li>
			<%
		}
	}
	if(!found)
	{
		notYetLinked.add(candidateOutcome);
	}
}
%>
</ul>
<%
String select = HTMLTools.createSelect("outcome_selected",notYetLinked, "Id", "Name",null, null).replaceAll("<select ","<select size=\"10\" ");
%>
<form>
	<input type="hidden" name="organization_outcome_id" id="organization_outcome_id" value="<%=organizationOutcomeId%>"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<table>
		<tr>
			<td>Outcomes:</td>
			<td><%=select%></td>
		</tr>
		<tr>	<td colspan="2"><input type="button" 
				   name="saveButton" 
				   id="saveButton" 
				   value="Add Program Outcome link to Organization Outcome" 
				   onclick="saveProgram(new Array('outcome_selected'),new Array('outcome_selected','organization_outcome_id','program_id'),'ProgramOutcomeOrganizationOutcome');" />
			</td>
		</tr>
	</table>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>

</form>
