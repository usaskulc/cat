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
<strong>Indicate below what is the instructional emphasis and depth for each of these outcomes in your course on the following scales.</strong>
<br/>Emphasis:
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
<br/>Depth: 
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
		<th>Emphasis</th>
		<th>Depth</th>
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
