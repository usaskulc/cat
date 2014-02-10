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
<h2>My Course Outcomes in Relation to Program Outcomes</h2>
<p>
	<ul>
		<li>This section offers a more detailed view of your course in the context of program outcomes 
		by providing the opportunity to "map" your course learning outcomes to the overall program outcomes that have been 
		predetermined in the academic unit as part of the curriculum development process.
		 Each course learning outcomes will often align with at least one of the program outcomes, 
		 although a course may have an unique learning outcome that is not articulated as a program outcome.
		 Both aligned and distinct course learning outcomes are valuable for students, 
		 instructors, and the program's curriculum planning process. 
		</li> 
		<li>The first column lists the program outcome category, the second column the program outcome description.
		</li>
		 <li>To remove a learning outcome row, select "remove" in the outcome pull down menu.
		 </li>
	</ul>
</p>

<%
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(courseOfferingId);
OrganizationManager dm = OrganizationManager.instance();
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
out.println(HTMLTools.createSelect("programToSet", programs, "Id", "Name", programId, "setProgramId("+courseOfferingId+")"));

if(!HTMLTools.isValid(programId))
{
	return;
}

OutcomeManager om = OutcomeManager.instance();
List<CourseOutcome> outcomes = om.getOutcomesForCourseOffering(courseOffering);

boolean access = true;
ProgramManager pm = ProgramManager.instance();

Program program = pm.getProgramById(Integer.parseInt(programId));
List<ProgramOutcomeGroup> groups = pm.getProgramOutcomeGroupsProgram(program);
if(groups.isEmpty())
{
	out.println("No Propgram Outcomes found");
	return;
}
%>
<table>
	<tr>
		<th>Category</th>
		<th>Program Outcome</th>
		<th>Your Course Outcomes</th>
	</tr>
	
<%

session.setAttribute("courseOutcomes",outcomes);
session.setAttribute("courseOffering",courseOffering);
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
				<td>
			<%
			List<LinkCourseOutcomeProgramOutcome> links = pm.getCourseOutcomeLinksForProgramOutcome(courseOffering, programOutcome);
			StringBuilder alreadyLinked = new StringBuilder("-1");
			
			%>
			<table id="programOutcomeContributions_<%=courseOffering.getId()%>_<%=programOutcome.getId()%>" style="margin:0px;">
				<jsp:include page="courseOutcomeContributions.jsp">
					<jsp:param name="course_offering_id" value="<%=courseOffering.getId()%>" />
					<jsp:param name="program_outcome_id" value="<%=programOutcome.getId()%>" />
				</jsp:include>
			</table>
			
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
	<div id="outcomeComment">
		
	<%=!HTMLTools.isValid(courseOffering.getOutcomeComment())?"No additional information entered. Select edit icon below to add additional information.":courseOffering.getOutcomeComment() %>
	
</div>
<br/>
<a href="javascript:loadModify('/cat/auth/courseOffering/editComments.jsp?course_offering_id=<%=courseOfferingId%>&type=outcomeComment','outcomeComment');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit comments" title="Edit comments"></a>
