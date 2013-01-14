<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
int outcomeId = HTMLTools.getInt(request.getParameter("outcome_id"));

int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
String direction = request.getParameter("direction");

if(!OutcomeManager.instance().moveLinkCourseOfferingOutcome(outcomeId, courseOfferingId,direction))
{
	out.println("ERROR: Unable to move outcome "+direction);
}

%>
		