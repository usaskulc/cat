<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
OrganizationManager manager = OrganizationManager.instance();
int  linkId = HTMLTools.getInt(request.getParameter("link_id"));
String action = request.getParameter("action");

if(HTMLTools.isValid(action))
{
	if(action.equals("deleteLink"))
	{
		if(manager.removeLinkProgramOutcomeOrganizationOutcome(linkId))
		{
			out.println("removed");
		}
		else
		{
			out.println("ERROR: Unable to remove Program Outcome!");
		}
	}
	//program_id="+programId+"&action=saveCourseContribution&link_id="+linkId+"&contribution_id="+ontributionId
	else if(action.equals("saveCourseContribution"))
	{
		int courseId = HTMLTools.getInt(request.getParameter("course_id"));
		int contributionId = HTMLTools.getInt(request.getParameter("contribution_id"));
		int masteryId = HTMLTools.getInt(request.getParameter("mastery_id"));

		ProgramManager pm = ProgramManager.instance();
		if(pm.saveCourseContributionLinksForProgramOutcome(courseId, linkId, contributionId,masteryId))
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
		