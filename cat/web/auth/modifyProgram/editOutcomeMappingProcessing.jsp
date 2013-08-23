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
		
