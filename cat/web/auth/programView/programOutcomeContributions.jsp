<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseId = request.getParameter("course_id");
String programId = request.getParameter("program_id");
CourseManager cm = CourseManager.instance();
Course course = cm.getCourseById(Integer.parseInt(courseId));

List<CourseOffering> offerings = (List<CourseOffering>)cm.getCourseOfferingsForCourse(course);
List<String> terms = cm.getAvailableTermsForCourse(course);

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

OutcomeManager om = OutcomeManager.instance();
ProgramManager pm = ProgramManager.instance();

Program program = pm.getProgramById(Integer.parseInt(programId));
List<ProgramOutcomeGroup> groups = pm.getProgramOutcomeGroupsProgram(program);
List<ContributionOptionValue> optionValues = pm.getContributionOptions();
List<MasteryOptionValue> masteryValues = pm.getMasteryOptions();

if(groups.isEmpty())
{
	out.println("No Program Outcomes found");
	return;
}
%>
<hr/>
<strong>The contributions listed below represent the extent of which this course contributes to the corresponding Program Outcome.</strong>
<br/>
<%
boolean firstOption = true;
for( ContributionOptionValue optionValue : optionValues)
{
	if(firstOption)
		firstOption = false;
	else
		out.println(", ");
	out.println(optionValue.getCalculationValue() +"="+ optionValue.getName());
}

%>
<br/>
<strong>The Mastery Depth levels listed below represent the extent of which this course contributes to the corresponding Program Outcome.</strong>
<br/>
<%
for( MasteryOptionValue optionValue : masteryValues)
{
	if(firstOption)
		firstOption = false;
	else
		out.println(", ");
	out.println(optionValue.getCalculationValue() +"="+ optionValue.getName());
}

%>
<br/>
<table>
	<tr>
		<th>Category</th>
		<th>Program Outcome</th>
		<th>Extent of<br/>Exposure</th>
		<th>Depth of<br/>Mastery</th>
	</tr>
	
<%
	String prevGroup = "";
	for(ProgramOutcomeGroup group : groups)
	{
		List<LinkProgramProgramOutcome> programOutcomes = pm.getProgramOutcomeForGroupAndProgram(program,group );
		boolean first = true;
		%>
	<tr>
			<td rowspan="<%=programOutcomes.size()%>"><%=group.getName()%></td>
		<%
		for(LinkProgramProgramOutcome programOutcomeLink: programOutcomes)
		{
			ProgramOutcome programOutcome = programOutcomeLink.getProgramOutcome();
			if(!first)
				out.println("<tr>");
			else
				first = false;
			%>
			<td><span title="<%=HTMLTools.isValid(programOutcome.getDescription())?programOutcome.getDescription():"No description"%>"><%=programOutcome.getName()%></span>
			</td>
			<td id="table_cell_<%=programOutcomeLink.getId()%>">
			
			<%
			LinkCourseContributionProgramOutcome contributionLink = pm.getCourseContributionLinksForProgramOutcome(course, programOutcomeLink);
			if(contributionLink == null)
			{
				pm.saveCourseContributionLinksForProgramOutcome(course.getId(), programOutcomeLink.getId(), optionValues.get(0).getId(),masteryValues.get(0).getId());
				contributionLink = pm.getCourseContributionLinksForProgramOutcome(course, programOutcomeLink);
			}
			if(access)
			{
				%>
				<%=HTMLTools.createSelect("contribution"+programOutcomeLink.getId(), optionValues, "Id", "Name", ""+contributionLink.getContribution().getId(), "saveContribution("+programOutcomeLink.getId()+","+programId+","+courseId+");")%>
				</td>
				<td>
				<%=HTMLTools.createSelect("mastery"+programOutcomeLink.getId(), masteryValues, "Id", "Name", ""+contributionLink.getMastery().getId(), "saveContribution("+programOutcomeLink.getId()+","+programId+","+courseId+");")%>
				<%
				
			}
			else
			{
				out.println(contributionLink.getContribution().getCalculationValue());
				out.println("</td><td>"); 
				out.println(contributionLink.getMastery().getCalculationValue());
			}
			%>
			</td>
		</tr>
		<%
		}%>
	
	<%}%>
</table>
<hr/>