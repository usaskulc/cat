<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.*,java.text.NumberFormat"%>
<%
String programId = request.getParameter("program_id");
CourseManager cm = CourseManager.instance();
ProgramManager pm = ProgramManager.instance();

Program program = pm.getProgramById(Integer.parseInt(programId));
List<LinkCourseProgram> courseLinks = pm.getLinkCourseProgramForProgram(program);
TreeMap<String, Integer>  contributingCourses = pm.getCourseOfferingsContributingToProgram(program);

List<ProgramOutcomeGroup> groups = pm.getProgramOutcomeGroupsProgram(program);
List<ContributionOptionValue> optionValues = pm.getContributionOptions();
List<MasteryOptionValue> masteryValues = pm.getMasteryOptions();

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
<strong>Indicated below are the instructional emphasis and depth for each of these outcomes in your course on the following scales</strong>
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
					<% List<CourseOfferingContribution> contributions = pm.getContributionForProgramOutcome(programOutcome,program);
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