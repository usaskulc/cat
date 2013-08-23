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
OutcomeManager manager = OutcomeManager.instance();
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
int linkId = HTMLTools.getInt(request.getParameter("assessment_link_id"));
int outcomeId = HTMLTools.getInt(request.getParameter("outcome_id"));
int linkToDelete = HTMLTools.getInt(request.getParameter("link_to_delete"));

String howLongId = request.getParameter("how_long_id");
if(linkId < 0 && outcomeId < 0 && linkToDelete > -1)
{
	if(manager.deleteOutcomeAssessmentLink(linkToDelete))
	{
		out.println("removed");
	}
	else
	{
		out.println("ERROR: Unable to remove linking between Assessment and Outcome!");
	}
}
else if( linkId > -1 && outcomeId > -1)
{
	if(manager.addOutcomeAssessmentLink(courseOfferingId, outcomeId, linkId) )
	{
		out.println("saved");
	}
	else
	{
		out.println("ERROR: Unable to link Assessment to outcome!");
	}
}
else
{
	out.println("ERROR: Don't know what to do! Don't have enough information. Did you select all the needed information?");
}

%>
		
