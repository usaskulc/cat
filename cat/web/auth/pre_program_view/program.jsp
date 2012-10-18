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
<h2><%=o.getName()%><%if(sysadmin){%> &nbsp; <a href="javascript:loadModify('/cat/auth/modifyProgram/program.jsp?organization_id=<%=organization.getId()%>&program_id=<%=o.getId()%>','characteristicsModifyDiv');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit"></a><%}%></h2>

<h3>Courses</h3>

<div id="programCoursesDiv">
	<jsp:include page="programCourses.jsp"/>
</div>
<div id="addCourseToProgram" class="fake-input" style="display:none;"></div>

<%
if(access)
{%>
<a href="javascript:toggleDisplay('manageProgramOutcomes',clientBrowser);"><img src="images/closed_folder_<%=clientBrowser%>.gif" id="manageProgramOutcomes_img">Manage Program Outcomes</a>
<div id="manageProgramOutcomes_div" style="display:none;">
	<h3>Manage Program Outcomes</h3>
	
	<div id="programOutcomesDiv">
		<jsp:include page="programOutcomes.jsp"/>
	</div>
	<div id="addOutcomeToProgram" class="fake-input" style="display:none;"></div>
</div>
<%} %>
<div id="summaryProgramOutcomesDiv">
	<jsp:include page="summaryProgramOutcomes.jsp"/>
</div>

<div id="outcomes"></div>
<hr/>
<div id="outcomesMappingDiv">
	<jsp:include page="outcomesMapping.jsp">
		<jsp:param value="<%=programId%>" name="program_id"/>	
	</jsp:include>
</div>

<div id="characteristicsModifyDiv" class="fake-input" style="display:none;">
</div>
<h3>Assessment Distribution and Instructional Strategies</h3>

<div id="programCourseAssessmentsDiv">
	<jsp:include page="programCourseAssessments.jsp"/>

</div>
<%
if(access)
{%>
<a href="/cat/auth/modifyProgram/programExport.jsp?program_id=<%=programId%>" class="smaller">Export to Excel (under construction)</a>
<%} %>
	