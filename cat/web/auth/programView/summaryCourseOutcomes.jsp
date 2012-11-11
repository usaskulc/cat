<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,java.text.NumberFormat"%>
<%
String courseId = request.getParameter("course_id");
String programId = request.getParameter("program_id");
CourseManager cm = CourseManager.instance();
Course course = cm.getCourseById(Integer.parseInt(courseId));
List<CourseOffering> offerings = (List<CourseOffering>)cm.getCourseOfferingsForCourse(course);
List<CourseOffering> offeringsWithData = cm.getCourseOfferingsForCourseWithProgramOutcomeData(course);
List<LinkCourseOfferingContributionProgramOutcome> contributionData = cm.getCourseOfferingsContributionsForCourse(course);

List<String> terms = cm.getAvailableTermsForCourse(course);

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");

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
if(offerings.isEmpty())
{
	out.println("No Course Offerings found");
	return;
}
if(offeringsWithData.isEmpty())
{
	out.println("No contribution data entered");
	return;
}

%>
<hr/>
<strong>The Emphasis and Depth value represent the data entered in the Course Offerings. (<%=offeringsWithData.size()%> out of <%=offerings.size()%> sections have mapping data entered)</strong>
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
<br/>Depth 
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
	NumberFormat formatter = NumberFormat.getInstance();
	formatter.setMaximumFractionDigits(1);
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
			int programOutcomeTotalContribution = 0;
			int programOutcomeTotalMastery = 0;
			
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
			boolean firstOffering = true;
			for(CourseOffering offering :offeringsWithData)
			{
				int totalContribution = 0;
				for (LinkCourseOfferingContributionProgramOutcome contribution: contributionData)
				{
						
					if(contribution.getCourseOffering().getId() == offering.getId())
					{
						if(contribution.getLinkProgramOutcome().getProgramOutcome().getId() == programOutcome.getId())
						{
							totalContribution += contribution.getContribution().getCalculationValue();
						}
					}
				}
				if(firstOffering)
					firstOffering = false;
				else
					out.println(",");
				out.println("<span title=\"section "+offering.getSectionNumber() + " ("+offering.getTerm()+")\">"+totalContribution+"</span>");
				programOutcomeTotalContribution += totalContribution;
				
			}
			%>
			(<%=formatter.format( (0.0 +programOutcomeTotalContribution)/offeringsWithData.size() )%>)
			</td>
			<td>
			<%
			firstOffering = true;
			for(CourseOffering offering :offeringsWithData)
			{
				int totalContribution = 0;
				int totalMastery = 0;
				for (LinkCourseOfferingContributionProgramOutcome contribution: contributionData)
				{
						
					if(contribution.getCourseOffering().getId() == offering.getId())
					{
						if(contribution.getLinkProgramOutcome().getProgramOutcome().getId() == programOutcome.getId())
						{
							totalMastery += contribution.getMastery().getCalculationValue();
						}
					}
				}
				if(firstOffering)
					firstOffering = false;
				else
					out.println(",");
				out.println("<span title=\"section "+offering.getSectionNumber() + " ("+offering.getTerm()+")\">"+ totalMastery+"</span>");
				programOutcomeTotalMastery += totalMastery;
				
			}
			%>
			(<%=formatter.format( (0.0 +programOutcomeTotalMastery)/offeringsWithData.size() )%>)
			</td>
		</tr>
		<%
		}
	
	}%>
</table>
<hr/>