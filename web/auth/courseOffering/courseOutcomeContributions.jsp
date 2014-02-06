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
CourseOffering courseOffering = (CourseOffering) session.getAttribute("courseOffering");
int programOutcomeId =  HTMLTools.getInt(request.getParameter("program_outcome_id"));


ProgramManager pm = ProgramManager.instance();
OutcomeManager om = OutcomeManager.instance();

List<CourseOutcome> outcomes = (List<CourseOutcome>) session.getAttribute("courseOutcomes");
if(outcomes.isEmpty() || !outcomes.get(0).getName().equals(OutcomeManager.noMatchName))
{
	CourseOutcome noMatch = om.getNoMatchOutcome();
	outcomes.add(0, noMatch);
}

List<LinkCourseOutcomeProgramOutcome> links = pm.getCourseOutcomeLinksForProgramOutcome(courseOffering, programOutcomeId);
boolean noMatchSelected = false;			
for(LinkCourseOutcomeProgramOutcome linkedOutcome : links)
{
	if(linkedOutcome.getCourseOutcome().getName().equals(OutcomeManager.noMatchName))
		noMatchSelected = true;
	%>
	<tr>
	  <td style="border-bottom:0px; border-top:0px;">
	  <%=HTMLTools.createSelect("outcome_selected_" + linkedOutcome.getId(),outcomes,linkedOutcome.getCourseOutcome().getId(),  "processContributionChange(" + courseOffering.getId() + "," + programOutcomeId  + "," + linkedOutcome.getId() + ")",false).replaceAll("Please select an outcome to add","remove outcome") %>
	  </td>  
   </tr>
 <%}

if(!noMatchSelected)
{
   %>
	<tr>
	  <td style="border-bottom:0px; border-top:0px;">
		<%=HTMLTools.createSelect("outcome_selected_" + courseOffering.getId() +"_"+programOutcomeId,outcomes,-1,  "processContributionChange(" + courseOffering.getId() + "," + programOutcomeId  + ")",true)%>
	  </td>
   </tr>
<%}%>
