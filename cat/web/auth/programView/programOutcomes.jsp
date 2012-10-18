<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}
ProgramManager pm = ProgramManager.instance();

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
	%>
	
	<li><%=o.getName()%> <%=HTMLTools.addBracketsIfNotNull(o.getDescription())%>
	 <%if(access){%><a href="javascript:removeProgramOutcome(<%=program.getId()%>,<%=link.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove" ></a><%} %>
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
	<li>	<a href="javascript:loadModify('/cat/auth/modifyProgram/programOutcome.jsp?program_id=<%=program.getId()%>');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add an outcome
			</a>
	</li>
<%} %>
</ul>
