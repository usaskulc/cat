<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
OrganizationManager manager = OrganizationManager.instance();
int  linkId = HTMLTools.getInt(request.getParameter("link_id"));
String action = request.getParameter("action");

if(HTMLTools.isValid(action))
{
	if(action.equals("saveCourseOfferingContribution"))
	{
		int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
		int contributionId = HTMLTools.getInt(request.getParameter("contribution_id"));
		int masteryId = HTMLTools.getInt(request.getParameter("mastery_id"));
		
		
		ProgramManager pm = ProgramManager.instance();
		if(pm.saveCourseOfferingContributionLinksForProgramOutcome(courseOfferingId, linkId, contributionId,masteryId))
		{
			out.println("saved");
		}
		else
		{
			out.println("ERROR: Unable to save contribution!");
		}
	}
	else
	{
		out.println("ERROR: Don't know what to do \""+action+"\" not known");
		
	}
	
}
else
{
	out.println("ERROR: don't know what to do. No valid action found.");
}
%>
		