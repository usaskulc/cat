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
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
ProgramManager om = ProgramManager.instance();

Program program = om.getProgramById(programId);
%>
<h4>Edit Available Program Outcomes (First for <%=program.getName()%>, followed by the General Program outcomes)</h4>
<input type="hidden" id="program_id" value="<%=programId%>" />
<ul>
<%
List<ProgramOutcomeGroup> groups = om.getProgramOutcomeGroupsForProgram(program);
for(ProgramOutcomeGroup group: groups)
{
	String additionalInfo="";
	//sysadmins are the only ones that can edit general outcoomes
	if(group.getProgramId() > 0 || sysadmin){
		if(group.getProgramId()> -1)
			additionalInfo="&organization_id="+organizationId;
	
	%>
	<li><strong><%=group.getName()%></strong>	
	
		<a href="javascript:editGenericProgramField(<%=group.getId()%>,'ProgramOutcomeGroup','name','editDiv','/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>');" class="smaller"><img src="/cat/images/edit_16.gif"  title="Edit outcome category" alt="Edit outcome category"/></a>
		<a href="javascript:editOutcome('ProgramOutcomeGroup',<%=group.getId()%>,<%=programId%>,'delete');"><img src="/cat/images/deletes.gif" alt="Delete outcome category" title="Delete outcome category"/></a>
		
	</li>
	<li>
		<ul style="padding-left:15px;line-height:1.0em;">
		<%
	
		List<ProgramOutcome> outcomes = om.getProgramOutcomesForGroup(group);
		for(ProgramOutcome outcome: outcomes)
		{
			%>
			<li><%=outcome.getName()%>
			 <a href="javascript:editGenericProgramField(<%=outcome.getId()%>,'ProgramOutcome','name','editDiv','/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>');" class="smaller"><img src="/cat/images/edit_16.gif"  title="Edit outcome" alt="Edit outcome"/></a>
			 <a href="javascript:editGenericProgramField(<%=outcome.getId()%>,'ProgramOutcome','description','editDiv','/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>');" class="smaller"><img src="/cat/images/edit_16.gif"  title="Edit outcome description" alt="Edit outcome description"/></a>
			 <a href="javascript:editOutcome('ProgramOutcome',<%=outcome.getId()%>,<%=programId%>,'delete');"><img src="/cat/images/deletes.gif" alt="Delete program outcome" title="Delete program outcome"/></a>

			</li>
			
					
			<%
		}
        %>
			<li>
				<a href="javascript:editGenericProgramField(-1,'ProgramOutcome','name','editDiv','/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>','program_outcome_group_id=<%=group.getId()%><%=additionalInfo%>');" class="smaller"><img src="/cat/images/edit_16.gif"  title="Add program outcome to category" alt="Add program outcome to category"/>Add program outcome to category</a>
			</li>
		
		</ul>
	</li>
	<%
	}
}
%>
	<li>
		<a href="javascript:editGenericProgramField(-1,'ProgramOutcomeGroup','name','editDiv','/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>','program_id=<%=programId%>');" class="smaller">Create new Program Outcome category for <%=program.getName()%> (eg: Biology Program Outcomes, Math: Geometry)</a>
	</li>
	<%if(sysadmin)
		{%>
	<li>
		<a href="javascript:editGenericProgramField(-1,'ProgramOutcomeGroup','name','editDiv','/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id=<%=programId%>','program_id=-1');" class="smaller">Create new "General" category (eg: Research)</a>
	</li>
	<%}%>
	
</ul>

