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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
session.setAttribute("programId",programId);

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;

boolean access = sysadmin;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}
ProgramManager pm = ProgramManager.instance();

Program o = pm.getProgramById(Integer.parseInt(programId));
Organization organization = o.getOrganization();
String clientBrowser=request.getHeader("User-Agent");
//simplify the client browser
if(clientBrowser.indexOf("Mac")>-1)
	clientBrowser="mac";
else if (clientBrowser.indexOf("Linux")>-1)
	clientBrowser="linux";
else
	clientBrowser="windows";
%>
<h2><%=o.getName()%><%if(sysadmin){%> &nbsp; <a href="javascript:loadModify('/cat/auth/modifyProgram/program.jsp?organization_id=<%=organization.getId()%>&program_id=<%=o.getId()%>','characteristicsModifyDiv');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit program details" title="Edit program details"></a><%}%></h2>
<a href="javascript:toggleDisplay('programQuestionEditSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="programQuestionEditSection_img">Manage Final Questions</a>
<div id="programQuestionEditSection_div" style="display:none;">
					
	<div id="programQuestionsDiv">
		<jsp:include page="programQuestions.jsp"/>
	</div>
</div>
<h3>Courses</h3>

<div id="programCoursesDiv">
	<jsp:include page="programCourses.jsp"/>
</div>
<div id="addCourseToProgram" class="fake-input" style="display:none;"></div>

<%
if(access)
{%>
<h3>Program Outcomes</h3>
<br><br>
<a href="javascript:toggleDisplay('manageProgramOutcomes',clientBrowser);"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="manageProgramOutcomes_img">Manage Program Outcomes</a>
<div id="manageProgramOutcomes_div" style="display:none;">
	
	
	<div id="programOutcomesDiv">
		<jsp:include page="programOutcomes.jsp"/>
	</div>
	<div id="addOutcomeToProgram" class="fake-input" style="display:none;"></div>
</div>
<div>



<%}
%>
<div id="outcomesMappingDiv">
	<jsp:include page="outcomesMapping.jsp">
		<jsp:param value="<%=programId%>" name="program_id"/>	
	</jsp:include>
</div>
<h3>Summary of Course Data</h3>
<p>
Summaries are presented for specific terms. Select the terms you would like to review (e.g., 201201 refers to Term 2 starting January 2012).
</p>
<form>
<input type="button" value="Select All Terms" onClick="selectTerms('all',<%=programId%>);"> &nbsp; <input type="button" value="De-select All Terms" onClick="selectTerms('none',<%=programId%>);">
<br/>
<%
List<String> availableTerms = pm.getAllAvailableTerms(o);
for(String term: availableTerms)
{
	%>
	<input class="termCheckbox" type="checkbox" id="termCB_<%=term%>" name="termCB_<%=term%>" value="<%=term%>" onClick="loadOutcomeMappings(<%=programId%>);"><%=term%> &nbsp; 
	<%
}
%>
</form>
</div>


<h3>Courses' Contribution to Program Outcomes</h3>
<div id="summaryProgramOutcomesDiv">
	<jsp:include page="summaryProgramOutcomes.jsp"/>
</div>

<div id="outcomes"></div>
<hr/>

<h3>Assessment Distribution and Instructional Strategies</h3>
<br>
Select the courses you would like view in the charts below.
<div id="programCourseAssessmentsDiv">
	<jsp:include page="/auth/programView/programCourseAssessments.jsp">
		<jsp:param value="<%=programId%>" name="program_id"/>	
	</jsp:include>

</div>

<%
if(false && access)
{%>
<a href="/cat/auth/modifyProgram/programExport.jsp?program_id=<%=programId%>" class="smaller">Export to Excel (under construction)</a>
<%} %>
	
