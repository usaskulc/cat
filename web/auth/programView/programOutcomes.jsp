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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
Organization org = null;
ProgramManager pm = ProgramManager.instance();
OutcomeManager om =  OutcomeManager.instance();
Program program =null;
if(HTMLTools.isValid(programId))
{
	program =  pm.getProgramById(Integer.parseInt(programId));
	org =program.getOrganization();	
	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+org.getId());
}
else
{
	%><h1>No program parameter found!!!</h1><%
	return;
}
List<CharacteristicType> characteristicTypes = org.getCharacteristicTypes();
if(characteristicTypes == null  || characteristicTypes.isEmpty())
{
	%>
	<h1>No Characteristics associated with organization <b><%=org.getName()%></b> (yet)!  Add Characteristics first please!</h1>
	<%
	return;
}

List<LinkProgramProgramOutcome> outcomeLinks = pm.getLinkProgramOutcomeForProgram(program);
%>
<ul>
<%
String prevGroup = "";
boolean first = true;
for(LinkProgramProgramOutcome link : outcomeLinks)
{
	ProgramOutcome o = link.getProgramOutcome();
	String groupName = o.getGroup().getName();
	if(groupName.contains("Custom"))
	{
		groupName = "";
	}
	else 
	{
		groupName = groupName + " : ";
	}
	if(!groupName.equals(prevGroup))
	{
		if(first)
		{
			first = false;
		}
		else
		{
			%>
				</ul>
			<%
		}
		%>
		<li><%=groupName%></li><ul style="padding-left:15px;line-height:1.0em;">
		<%
	}
	
	List<Characteristic> outcomeCharacteristics = om.getCharacteristicsForProgramOutcome(program,o, org);
	StringBuilder charOutput = new StringBuilder();
	int charTypeIndex = 0;
	int colorIndex = 0;
	for(Characteristic charac: outcomeCharacteristics)
	{
		CharacteristicType cType = charac.getCharacteristicType();
		if(cType.getQuestionDisplay().length() > 0)
		{
			if(cType.getQuestionDisplay().length()>0)
			{
				charOutput.append(cType.getQuestionDisplay());	
			}
			charOutput.append(" ");
			charOutput.append(charac.getName());
			charOutput.append("      ");
		}
		
	}
	String charOutputDisplay = "";
	if(charOutput.length() > 0)
		charOutputDisplay = " title=\"" + charOutput.toString() +"\"";
	
	
	
	%>
	
	<li><span <%=charOutputDisplay%>><%=o.getName()%> <%=HTMLTools.addBracketsIfNotNull(o.getDescription())%></span>
	 <%if(access){
	 	if(o.getGroup().getProgramId() > 0 ){%>
	 <a href="javascript:loadModify('/cat/auth/modifyProgram/editProgramOutcome.jsp?program_id=<%=program.getId()%>&organization_id=<%=org.getId()%>&link_id=<%=link.getId()%>');"><img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Edit program outcome" title="Edit program outcome" ></a>
	 	<%} %>
	 <a href="javascript:removeProgramOutcome(<%=program.getId()%>,<%=link.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove program outcome" title="Remove program outcome" ></a>
	 <%} %>
	</li>
	<% 
	prevGroup = groupName;
}

if(outcomeLinks.isEmpty())
{
	out.println("No outcomes added (yet).");
}
else
{
	%>
	</ul>
	<%
}
if(access)
{
%>
	<li>	<a href="javascript:loadModify('/cat/auth/modifyProgram/programOutcome.jsp?program_id=<%=program.getId()%>&organization_id=<%=org.getId()%>');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add a program outcome" title="Add a program outcome"/>
				Add a program outcome
			</a>
	</li>
<%} %>
</ul>
