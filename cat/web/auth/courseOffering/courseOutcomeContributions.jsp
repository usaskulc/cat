<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
CourseOffering courseOffering = (CourseOffering) session.getAttribute("courseOffering");
int programOutcomeId =  HTMLTools.getInt(request.getParameter("program_outcome_id"));


ProgramManager pm = ProgramManager.instance();
OutcomeManager om = OutcomeManager.instance();

List<CourseOutcome> outcomes = (List<CourseOutcome>) session.getAttribute("courseOutcomes");
if(outcomes.isEmpty() || !outcomes.get(0).getName().equals(OutcomeManager.noMatchName))
{
	CourseOutcome noMatch = om.getNoMatchOutcome();
	outcomes.add(0, noMatch);
}

List<LinkCourseOutcomeProgramOutcome> links = pm.getCourseOutcomeLinksForProgramOutcome(courseOffering, programOutcomeId);
boolean noMatchSelected = false;			
for(LinkCourseOutcomeProgramOutcome linkedOutcome : links)
{
	if(linkedOutcome.getCourseOutcome().getName().equals(OutcomeManager.noMatchName))
		noMatchSelected = true;
	%>
	<tr>
	  <td style="border-bottom:0px; border-top:0px;">
	  <%=HTMLTools.createSelect("outcome_selected_" + linkedOutcome.getId(),outcomes,linkedOutcome.getCourseOutcome().getId(),  "processContributionChange(" + courseOffering.getId() + "," + programOutcomeId  + "," + linkedOutcome.getId() + ")",false).replaceAll("Please select an outcome to add","remove outcome") %>
	  </td>  
   </tr>
 <%}

if(!noMatchSelected)
{
   %>
	<tr>
	  <td style="border-bottom:0px; border-top:0px;">
		<%=HTMLTools.createSelect("outcome_selected_" + courseOffering.getId() +"_"+programOutcomeId,outcomes,-1,  "processContributionChange(" + courseOffering.getId() + "," + programOutcomeId  + ")",true)%>
	  </td>
   </tr>
<%}%>
