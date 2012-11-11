<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
Department dept = null;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	dept = organization.getDepartment();
	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}
List<CharacteristicType> characteristicTypes = dept.getCharacteristicTypes();
if(characteristicTypes == null  || characteristicTypes.isEmpty())
{
	%>
	<h1>No Characteristics associated with department <b><%=dept.getName()%></b> (yet)!  Add Characteristics first please!</h1>
	<%
	return;
}
ProgramManager pm = ProgramManager.instance();
OutcomeManager om =  OutcomeManager.instance();
Program program = pm.getProgramById(Integer.parseInt(programId));
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
	
	List<Characteristic> outcomeCharacteristics = om.getCharacteristicsForProgramOutcome(program,o, dept);
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
	 <a href="javascript:loadModify('/cat/auth/modifyProgram/editProgramOutcome.jsp?program_id=<%=program.getId()%>&department_id=<%=dept.getId()%>&link_id=<%=link.getId()%>');"><img src="/cat/images/edit_16.gif" style="height:10pt;" alt="Remove" ></a>
	 	<%} %>
	 <a href="javascript:removeProgramOutcome(<%=program.getId()%>,<%=link.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove" ></a>
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
	<li>	<a href="javascript:loadModify('/cat/auth/modifyProgram/programOutcome.jsp?program_id=<%=program.getId()%>&department_id=<%=dept.getId()%>');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add an outcome
			</a>
	</li>
<%} %>
</ul>
