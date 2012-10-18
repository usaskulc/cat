<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*, ca.usask.gmcte.util.HTMLTools"%>
<%
CourseManager manager = CourseManager.instance();
int linkId = HTMLTools.getInt(request.getParameter("link_id"));
int courseOffering = HTMLTools.getInt(request.getParameter("course_offering_id"));

List<LinkAssessmentCourseOutcome> existingLinks = OutcomeManager.instance().getLinkAssessmentCourseOutcomes(courseOffering);
boolean existing = false;
for(LinkAssessmentCourseOutcome link : existingLinks)
{
	if(link.getAssessmentLink().getId() == linkId)
	{
		existing = true;
	}
}
if(existing)
{
	out.println("ERROR: It appears that you have assigned a learning outcome to this assessment method. Please remove the Assessment Method from the Learning Outcome first.");
}
else
{
	if(manager.deleteAssessment(linkId))
	{
		out.println("Assessment Method removed");
	}
	else
	{
		out.println("ERROR: removing assessment method");
	}
}
%>
		