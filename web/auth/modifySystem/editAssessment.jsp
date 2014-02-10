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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String groupId = request.getParameter("assessment_group_id");
String assessmentId = request.getParameter("assessment_id");
String command = request.getParameter("command");
CourseManager manager = CourseManager.instance();
if(command.equals("delete") || command.equals("up") || command.equals("down"))
{
	if (command.equals("delete"))
	{	
		List<LinkCourseOfferingAssessment> existing = manager.getAssessmentsUsed(Integer.parseInt(assessmentId));
		if(existing!=null && !existing.isEmpty())
		{
			out.println("ERROR: There are courses that use this Assessment Method!  It can't be deleted at this point.");
			return;
		}
	}
	
	if(manager.moveAssessmentMethod(Integer.parseInt(assessmentId),Integer.parseInt(groupId), command)) 
	{
		out.println("Assessment method processed");
	}
	else
	{
		out.println("ERROR: Unable to process the " + command);

	}
}
else if(command.equals("group_up") || command.equals("group_down") || command.equals("group_delete") )
{
	if (command.equals("group_delete"))
	{	
		AssessmentGroup group = manager.getAssessmentGroupById(Integer.parseInt(groupId));
		
		List<Assessment> children = manager.getAssessmentsForGroup(group);
		if(children != null && !children.isEmpty())
		{
			out.println("ERROR: There are Assessment methods that are part of this group!  It can't be deleted at this point.");
			return;
		}
	}
	
	if(manager.moveAssessmentMethodGroup(Integer.parseInt(groupId), command))
	{
		out.println("Assessment method group processed");
	}
	else
	{
		out.println("ERROR: Unable to process the " + command);

	}
}
else
{		
	out.println("Don't know what to do.  command \""+command+"\" not known");
}

%>
		
