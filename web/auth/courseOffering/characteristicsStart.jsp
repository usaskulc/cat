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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*, java.text.NumberFormat"%>
<jsp:include page="/header.jsp"/>
<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
<%
CourseManager cm = CourseManager.instance();
String courseOfferingId = request.getParameter("course_offering_id") ;
CourseOffering courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
ProgramManager pm = ProgramManager.instance();
OrganizationManager dm = OrganizationManager.instance();
OutcomeManager om = OutcomeManager.instance();
String programId = (String)session.getAttribute("programId");
int programIdParameter = HTMLTools.getInt(request.getParameter("program_id"));
if(programIdParameter > -1)
{
	session.setAttribute("programId",""+programIdParameter);
	programId = ""+programIdParameter; 
}
if(!HTMLTools.isValid(programId))
{
	%>
<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> &gt; 
		<a href="/cat">Curriculum Mapping</a> &gt; <a href="/cat/auth/myCourses.jsp">My Courses</a> &gt; 
</div>  
<%
}
else
{
	Program program2 = pm.getProgramById(Integer.parseInt(programId));
	String programLink = "";
	programLink = "<a href=\"/cat/auth/programView/programWrapper.jsp?program_id="+programId+"\">"+program2.getName()+"</a> &gt; ";
	Course course = courseOffering.getCourse();
	programLink += "<a href=\"/cat/auth/programView/courseCharacteristicsWrapper.jsp?program_id="+programId+"&course_id="+course.getId()+"\">"+course.getSubject()+" "+ course.getCourseNumber()+"</a> &gt; ";
	%>

			
						<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> &gt; 
							<a href="/cat">Curriculum Alignment Tool</a> &gt; <%=programLink%> CourseOffering characteristics</p></div>  
						<div id="CourseOfferingCharacteristicsDiv" class="module" style="overflow:auto;">
	<%
	
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
out.println(HTMLTools.createSelect("programToSet", programs, "Id", "Name", programId, "setProgramStartId("+courseOfferingId+")"));

if(!HTMLTools.isValid(programId))
{
	return;
}
Program program = pm.getProgramById(Integer.parseInt(programId));


List<Feature> featureList = cm.getFeatures();
List<String> completion = new ArrayList<String>(featureList.size());
List<CourseOutcome> outcomeList = om.getOutcomesForCourseOffering(courseOffering);
List<LinkProgramProgramOutcome> programOutcomeLinklist = pm.getLinkProgramOutcomeForProgram(program);
for(Feature f: featureList)
{
	if(f.getFileName().equals("editableTeachingMethods"))
	{
		int count = 0;
		List<TeachingMethod> list = cm.getAllTeachingMethods();
		for(TeachingMethod tm : list)
		{
			if (cm.getLinkTeachingMethodByData(courseOffering, tm) != null)
				count++;
		}
		if(count == 0)
			completion.add(f.getDisplayIndex()-1,"No data entered");
		else
			completion.add(f.getDisplayIndex()-1, count +" out of " + list.size() + " Instructional Methods have a value entered");
	}
	else if(f.getFileName().equals("assessmentMethods"))
	{
		NumberFormat formatter = NumberFormat.getInstance();
		formatter.setMaximumFractionDigits(1);
		double total = 0.0;
		List<LinkCourseOfferingAssessment> list = cm.getAssessmentsForCourseOffering(courseOffering);
		for(LinkCourseOfferingAssessment l : list)	
		{
			total = total + l.getWeight();
		}
		if(list.size() == 0)
			completion.add(f.getDisplayIndex()-1,"No data entered");
		else
			completion.add(f.getDisplayIndex()-1, list.size() + " Assessment Methods have been entered, totalling " + formatter.format(total) +" %");
	}
	else if(f.getFileName().equals("outcomes"))
	{
		if(outcomeList.size() == 0)
			completion.add(f.getDisplayIndex()-1,"No data entered");
		else
	    	completion.add(f.getDisplayIndex()-1, outcomeList.size() + " Course Learning Outcomes have been added");
	}
	else if(f.getFileName().equals("outcomeAssessmentMapping"))
	{
		List<LinkAssessmentCourseOutcome> list = om.getLinkAssessmentCourseOutcomes(Integer.parseInt(courseOfferingId));
		if(list.size() == 0)
			completion.add(f.getDisplayIndex()-1,"No data entered");
		else
		    completion.add(f.getDisplayIndex()-1, list.size() + " links between Course Learning Outcomes and Assessment methods have been added");
	}
	else if(f.getFileName().equals("outcomesMapping"))
	{
		
		 int count = 0;
		 for(LinkProgramProgramOutcome l : programOutcomeLinklist)
		 {
			LinkCourseOfferingContributionProgramOutcome contributionLink = pm.getCourseOfferingContributionLinksForProgramOutcome(courseOffering, l);
			if(contributionLink != null)
			{
				count++;
			}
		 }
		 if(count == 0)
			completion.add(f.getDisplayIndex()-1,"No data entered");
		 else
		    completion.add(f.getDisplayIndex()-1, count+" out of "+ programOutcomeLinklist.size() + " program outcomes have a contribution assigned");
	}
	else if(f.getFileName().equals("programOutcomeContributions"))
	{
		 int count = 0;
		 for(LinkProgramProgramOutcome l : programOutcomeLinklist)
		 {
			List<LinkCourseOutcomeProgramOutcome> links = pm.getCourseOutcomeLinksForProgramOutcome(courseOffering, l.getProgramOutcome());
			count = count + links.size();
		 }
		 if(count == 0)
				completion.add(f.getDisplayIndex()-1,"No data entered");
		 else
		    completion.add(f.getDisplayIndex()-1, count+" links have been made between Course Learning outcomes and "+ programOutcomeLinklist.size() + " program outcomes");
	}
	else if(f.getFileName().equals("completionTime"))
	{
		List<Question> questionLinks = QuestionManager.instance().getAllQuestionsForProgram(program);
		List<Question> responses = QuestionManager.instance().getAllQuestionsWithResponsesForProgramAndOffering(program,courseOffering);
		completion.add(f.getDisplayIndex()-1, responses.size() +" out of "+questionLinks.size() +" questions have been answered");
	}
}

%>
					<h2>Characteristics of course offering <%=courseOffering.getCourse().getSubject()%> <%=courseOffering.getCourse().getCourseNumber()%> section 
							<%=courseOffering.getSectionNumber()%> 
					 (<%=courseOffering.getTerm()%>) <%=courseOffering.getNumStudents()%> students</h2>
					<table>
					<tr><th>Section</th><th>Data</th></tr>
					<%
					for(int i = 0; i< featureList.size(); i++)
					{
						Feature f = featureList.get(i);%>
					<tr><td><a href="/cat/auth/courseOffering/characteristicsWizzard.jsp?course_offering_id=<%=courseOfferingId%>&feature=<%=(i+1)%>"><%=f.getName()%></a></td><td><%=completion.get(i)%></td></tr>
					<%} %>
					
					</table>
					<a href="/cat/auth/courseOffering/characteristicsWrapper.jsp?course_offering_id=<%=courseOfferingId%>">Summary</a>
					</div>
					<div id="modifyDiv" class="fake-input" style="display:none;"></div>
				</div>
			</div>
		</div>
<jsp:include page="/footer.jsp"/>	
