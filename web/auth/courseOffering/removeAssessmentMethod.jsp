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
		
