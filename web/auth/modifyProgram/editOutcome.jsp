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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int objectId = HTMLTools.getInt( request.getParameter("id"));
String object = request.getParameter("object");
String command = request.getParameter("action");
OutcomeManager om = OutcomeManager.instance();
if(command.equals("delete"))
{
	if(om.deleteOutcomeObject(object, objectId))
	{
		out.println("deleted");
	}
	else
	{
		out.println("ERROR: Unable to delete the outcome");
	}
}

%>
		
