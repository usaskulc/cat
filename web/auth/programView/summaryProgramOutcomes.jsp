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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.*,java.text.NumberFormat"%>
<%
String programId = request.getParameter("program_id");
String[] terms = request.getParameterValues("term");
List<String> termList = new ArrayList<String>();
if(terms!=null && terms.length > 0)
	termList = Arrays.asList(terms);
CourseManager cm = CourseManager.instance();
ProgramManager pm = ProgramManager.instance();

Program program = pm.getProgramById(Integer.parseInt(programId));
List<LinkCourseProgram> courseLinks = pm.getLinkCourseProgramForProgram(program);
TreeMap<String, Integer>  contributingCourses = pm.getCourseOfferingsContributingToProgram(program, termList);

List<ProgramOutcomeGroup> groups = pm.getProgramOutcomeGroupsProgram(program);
List<ContributionOptionValue> optionValues = pm.getContributionOptions();
List<MasteryOptionValue> masteryValues = pm.getMasteryOptions();

if(termList.isEmpty())
{
	out.println("No Term(s) selected");
	return;
}

if(groups.isEmpty())
{
	out.println("No Program Outcomes found");
	return;
}
if(courseLinks.isEmpty())
{
	out.println("No Courses linked to Program");
	return;
}
%>
<hr/>

<br>
<strong>Indicated below is the instructional emphasis and depth for each of these outcomes in your course on the following scales</strong>
<br/><b>Emphasis:</b>
<%
boolean firstOption = true;
for( ContributionOptionValue optionValue : optionValues)
{
	if(firstOption)
		firstOption = false;
	else
		out.println(", ");
	out.println(optionValue.getCalculationValue() +"="+ optionValue.getName());
}%>
<br/><b>Depth:</b>
<%
firstOption = true;
for(MasteryOptionValue optionValue : masteryValues)
{
	if(firstOption)
		firstOption = false;
	else
		out.println(", ");
	out.println(optionValue.getCalculationValue() +"="+ optionValue.getName());
}%>
<br/>

<table>
	<tr>
		<th>Category</th>
		<th>Program Outcome</th>
		<th style="width:100px;">Course</th>
		<th style="width:50px;">Emphasis</th>
		<th style="width:50px;">Depth</th>
	</tr>
	
<%
	NumberFormat formatter = NumberFormat.getInstance();
	formatter.setMaximumFractionDigits(2);
	String prevGroup = "";
	for(ProgramOutcomeGroup group : groups)
	{

		List<LinkProgramProgramOutcome> programOutcomes = pm.getProgramOutcomeForGroupAndProgram(program,group);
		boolean first = true;
		%>
		<tr>
			<td rowspan="<%=programOutcomes.size()%>"><%=group.getName()%></td>
		<%
		for(LinkProgramProgramOutcome programOutcomeLink: programOutcomes)
		{
			int programOutcomeTotal = 0;
			ProgramOutcome programOutcome = programOutcomeLink.getProgramOutcome();
			if(!first)
				out.println("<tr>");
			else
				first = false;
			%>
			<td><span title="<%=HTMLTools.isValid(programOutcome.getDescription())?programOutcome.getDescription():"No description"%>"><%=programOutcome.getName()%></span>
			</td>
			<td colspan="3">
				<table style="border-bottom:0px; border-top:0px; margin:0px;">
					<% List<CourseOfferingContribution> contributions = pm.getContributionForProgramOutcome(programOutcome,program,termList);
					
					   List<CourseOfferingContribution> serviceContributions = pm.getServiceCourseContributionForProgramOutomce(programOutcome, program);
					TreeMap<String, String> extentContributions =  new TreeMap<String,String>();
					TreeMap<String, String> masteryContributions =  new TreeMap<String,String>();
					List<String> masterCourseList = new ArrayList<String>();
					for(CourseOfferingContribution contribution: contributions)
					{
						CourseOffering offering = cm.getCourseOfferingById(contribution.getCourseOfferingId());
						Course course = offering.getCourse();
						String display = course.getSubject() + " " + course.getCourseNumber();
						if (!masterCourseList.contains(display))
						{
							masterCourseList.add(display);
						}
						String extentValue = extentContributions.get(display);
						if(!HTMLTools.isValid(extentValue))
						{
							extentValue = "" + contribution.getContribution();
						}
						else
						{
							extentValue = ""+ ( Integer.parseInt(extentValue) + contribution.getContribution());
						}
						extentContributions.put(display, extentValue);
						String masteryValue = masteryContributions.get(display);
						if(!HTMLTools.isValid(masteryValue))
						{
							masteryValue = ""+contribution.getMastery();
						}
						else
						{
							masteryValue = ""+ ( Integer.parseInt(masteryValue) + contribution.getMastery());
						}
						masteryContributions.put(display, masteryValue);
					}
					for(CourseOfferingContribution contribution: serviceContributions)
					{
						Course course = cm.getCourseById(contribution.getCourseOfferingId());
						String display = course.getSubject() + " " + course.getCourseNumber();
						if (!masterCourseList.contains(display))
						{
							masterCourseList.add(display);
						}
						String extentValue = extentContributions.get(display);
						if(!HTMLTools.isValid(extentValue))
						{
							extentValue = ""+contribution.getContribution();
						}
						else
						{
							extentValue = ""+ ( Integer.parseInt(extentValue) + contribution.getContribution());
						}
						extentContributions.put(display, extentValue);
						String masteryValue = masteryContributions.get(display);
						if(!HTMLTools.isValid(masteryValue))
						{
							masteryValue = ""+contribution.getMastery();
						}
						else
						{
							masteryValue = ""+ ( Integer.parseInt(masteryValue) + contribution.getMastery());
						}
						masteryContributions.put(display, masteryValue);
					}
					Arrays.sort(masterCourseList.toArray());
					
					for(String course : masterCourseList)
					{
						String extentDisplay = "";
						String masteryDisplay = "";
						String extentValue = extentContributions.get(course);
						String masteryValue = masteryContributions.get(course);
						Integer offeringCount = contributingCourses.get(course);
						if(offeringCount == null)
						{
							extentDisplay = extentValue==null?"0":extentValue;
							masteryDisplay = masteryValue==null?"0":masteryValue;	
						}
						else
						{
							extentDisplay = extentValue==null?"0": ""+ formatter.format(((0.0 +Integer.parseInt(extentValue))/offeringCount));
							masteryDisplay = masteryValue==null?"0": "" + formatter.format(((0.0 + Integer.parseInt(masteryValue))/offeringCount));	
						}
						%>
						<tr><td style="border-bottom:0px; border-top:0px;width:100px;"><%=course%></td> 
						    <td  style="border-bottom:0px; border-top:0px;width:50px;"><%=extentDisplay%></td>
						
						    <td style="border-bottom:0px; border-top:0px;width:50px;"> <%=masteryDisplay%> </td>
						</tr>
						<%
					}
					%>
				</table>
		</tr>
		<%
		}
	
	}%>
</table>
<hr/>
