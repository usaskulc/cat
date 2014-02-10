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
CourseManager manager = CourseManager.instance();
String courseOfferingId = request.getParameter("course_offering_id");
String teachingMethodId = request.getParameter("teaching_method_id");

String howLongId = request.getParameter("how_long_id");
if(HTMLTools.isValid(howLongId))
{
	if(howLongId.equals("-1"))
	{
		if(manager.deleteTeachingMethod(Integer.parseInt(courseOfferingId), Integer.parseInt(teachingMethodId)))
		{
			out.println("removed");
		}
		else
		{
			out.println("ERROR: Unable to remove Teachingmethod!");
		}
	}
	else
	{
		if(manager.addTeachingMethod(Integer.parseInt(courseOfferingId), Integer.parseInt(teachingMethodId),Integer.parseInt(howLongId)))
		{
			out.println("saved");
		}
		else
		{
			out.println("ERROR: Unable to save Teachingmethod changes!");
		}
	}
}
else
{
	out.println("ERROR: don't know what to do. No time id.");
}
%>
		
