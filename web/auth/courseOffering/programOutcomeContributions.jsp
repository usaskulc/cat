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

<h2>My Course Within this Program</h2>
<p>
This section is used to "map" your course to the overall program outcomes 
in your academic unit (previously identified as part of the curriculum development process).
 The first column lists the program outcome category and the second column describes the program outcome.
  In the column titled "Emphasis", select the extent of instructional emphasis your course places
   on that program outcome. In the final "Depth" column, select from the pull down menu the level of
    depth at which your course addresses that program outcome. For example, an introductory course
     related to a program outcome may specify a low amount of emphasis at an introductory depth.
</p>
<%
String courseOfferingId = request.getParameter("course_offering_id");
CourseManager cm = CourseManager.instance();
OrganizationManager dm = OrganizationManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
String programId = (String)session.getAttribute("programId");
int programIdParameter = HTMLTools.getInt(request.getParameter("program_id"));
if(programIdParameter > -1)
{
	session.setAttribute("programId",""+programIdParameter);
	programId = ""+programIdParameter; 
}

out.println("Currently selected Program :");
List<Organization> organizations = cm.getOrganizationForCourseOffering(courseOffering);
List<Program> programs = new ArrayList<Program>();
Program bogus = new Program();
bogus.setId(-1);
bogus.setName("Please select a Program");
programs.add(bogus);
for(Organization dep : organizations)
{
	programs.addAll(dm.getProgramOrderedByNameForOrganization(dep));
}
out.println(HTMLTools.createSelect("programToSet", programs, "Id", "Name", programId, "setProgramContributionId("+courseOfferingId+")"));

if(!HTMLTools.isValid(programId))
{
	return;
}




OutcomeManager om = OutcomeManager.instance();
ProgramManager pm = ProgramManager.instance();

Program program = pm.getProgramById(Integer.parseInt(programId));
List<ProgramOutcomeGroup> groups = pm.getProgramOutcomeGroupsProgram(program);
List<ContributionOptionValue> optionValues = pm.getContributionOptions();
List<MasteryOptionValue> masteryOptionValues = pm.getMasteryOptions();

if(groups.isEmpty())
{
	out.println("No Propram Outcomes found");
	return;
}
%>
<hr/>
<strong>Indicate below what is the instructional emphasis and depth for each of these outcomes in your course on the following scales.</strong>
  You also have the option to add information to the comment section appearing below the table.
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

<br/>Depth: 
<%
for( MasteryOptionValue optionValue : masteryOptionValues)
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
		<th>Program Outcomes</th>
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
			LinkCourseOfferingContributionProgramOutcome contributionLink = pm.getCourseOfferingContributionLinksForProgramOutcome(courseOffering, programOutcomeLink);
			if(contributionLink == null)
			{
				pm.saveCourseOfferingContributionLinksForProgramOutcome(courseOffering.getId(), programOutcomeLink.getId(), optionValues.get(0).getId(), masteryOptionValues.get(0).getId());
				contributionLink = pm.getCourseOfferingContributionLinksForProgramOutcome(courseOffering, programOutcomeLink);
			}
			
			out.println(HTMLTools.createSelect("contribution"+programOutcomeLink.getId(), optionValues, "Id", "Name", ""+contributionLink.getContribution().getId(), "saveOfferingContribution("+programOutcomeLink.getId()+","+programId+","+courseOfferingId+");"));
			out.println("</td><td>");
			out.println(HTMLTools.createSelect("mastery"+programOutcomeLink.getId(), masteryOptionValues, "Id", "Name", ""+contributionLink.getMastery().getId(), "saveOfferingContribution("+programOutcomeLink.getId()+","+programId+","+courseOfferingId+");"));
			
			%>
			</td>
			
		</tr>
		<%
		}%>
	
	<%}%>
</table>
<hr/>
		<h3>Additional information:</h3>
		<br>
		<p>To add/edit additional information please click the edit icon below.
		</p>
	<div id="contributionComment">
		
	<%=!HTMLTools.isValid(courseOffering.getContributionComment())?"No additional information entered. Select edit icon below to add additional information.":courseOffering.getContributionComment() %>
	
</div>
<br/>
<a href="javascript:loadModify('/cat/auth/courseOffering/editComments.jsp?course_offering_id=<%=courseOfferingId%>&type=contributionComment','contributionComment');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit comments" title="Edit comments"></a>
