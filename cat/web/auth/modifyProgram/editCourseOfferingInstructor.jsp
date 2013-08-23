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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
CourseManager manager = CourseManager.instance();
String action = request.getParameter("action");


if(action.equals("delete"))
{
	int linkId = HTMLTools.getInt(request.getParameter("user_or_link"));
	
	if(manager.removeInstructorFromCourseOffering(linkId))
	{
		out.println("Instructor removed");
	}
	else
	{
		out.println("ERROR: removing Instructor");
	}
}
else if(action.equals("add"))
{
	int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
	String instructorUserid = request.getParameter("user_or_link");
	String first = request.getParameter("first");
	String last = request.getParameter("last");
	
	
	if(manager.addInstructorToCourseOffering(instructorUserid, courseOfferingId,first,last))
	{
		out.println("Instructor added");
	}
	else
	{
		out.println("ERROR: adding Instructor");
	}
}
else
{
	out.println("ERROR: don't know what to do, action ["+action+"] not recognized.");
}

%>
		
