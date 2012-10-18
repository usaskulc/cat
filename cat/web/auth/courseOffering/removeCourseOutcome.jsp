<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
OutcomeManager manager = OutcomeManager.instance();
String outcomeId = request.getParameter("outcome_id");
String courseOfferingId = request.getParameter("course_offering_id");
if(manager.deleteCourseOfferingOutcome(Integer.parseInt(outcomeId), Integer.parseInt(courseOfferingId)))
{
	out.println("CourseOffering Outcome removed");
}
else
{
	out.println("ERROR: removing courseOffering outcome");
}
%>
		