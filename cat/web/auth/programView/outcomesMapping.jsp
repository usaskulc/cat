<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<h3>Mapping of Program Outcomes to Organization Outcomes</h3>
<br/>
After entering in your program outcomes above using the Manage Program Outcomes link, 
indicate which of your program outcomes link to the organizational outcomes of your College or University. 
To indicate a link between an organization outcome and a program outcome, click "Add/delete link".
<br/>
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));

ProgramManager pm = ProgramManager.instance();
Program program = pm.getProgramById(programId);
OrganizationManager om = OrganizationManager.instance();
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
if(programId > -1)
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(""+programId);	
	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}
Organization organization = program.getOrganization();
if(organization.getParentOrganization() != null)
{
	organization = organization.getParentOrganization();
}


List<OrganizationOutcomeGroup> groups = OrganizationManager.instance().getOrganizationOutcomeGroupsOrganization(organization);
if(groups.isEmpty())
{
	out.println("No Organization Outcomes found");
	return;
}
%>
<table>
	<tr>
		<th>Category</th>
		<th>Organization Outcome</th>
		<th>Program Outcome</th>
	</tr>
	
<%
	String prevGroup = "";
	for(OrganizationOutcomeGroup group : groups)
	{
		List<LinkOrganizationOrganizationOutcome> organizationOutcomes = om.getOrganizationOutcomeForGroupAndOrganization(organization,group);
		boolean first = true;
		%>
	<tr>
			<td rowspan="<%=organizationOutcomes.size()%>"><%=group.getName()%></td>
		<%
		for(LinkOrganizationOrganizationOutcome organizationOutcomeLink: organizationOutcomes)
		{
			OrganizationOutcome organizationOutcome = organizationOutcomeLink.getOrganizationOutcome();
			if(!first)
				out.println("<tr>");
			else
				first = false;
			%>
			<td><span title="<%=HTMLTools.isValid(organizationOutcome.getDescription())?organizationOutcome.getDescription():"No description"%>"><%=organizationOutcome.getName()%></span>
			<a href="javascript:loadModify('/cat/auth/modifyProgram/editOutcomeMapping.jsp?program_id=<%=programId%>&organization_outcome_id=<%=organizationOutcome.getId()%>')" class="smaller">Add/delete link</a>
			</td>
			<%
			List<LinkProgramOutcomeOrganizationOutcome> links = om.getProgramOutcomeLinksForOrganizationOutcome(program, organizationOutcome);
			if(links.isEmpty())
			{
				out.println("<td colspan='2'>No Program Outcomes mapped</td>");
			}
			else
			{
				StringBuilder programOutcomes = new StringBuilder("<td><ul>");
				for(LinkProgramOutcomeOrganizationOutcome link: links)
				{
					ProgramOutcome pOutcome = link.getProgramOutcome();
					programOutcomes.append("<li>");
					programOutcomes.append(pOutcome.getName());
					programOutcomes.append("</li>\n");
					
				}
				programOutcomes.append("</ul></td>\n");
				out.println(programOutcomes.toString());
				
			}
			%>
			
			
		</tr>
		<%
		}%>
	
	<%}%>
</table>
<hr/>