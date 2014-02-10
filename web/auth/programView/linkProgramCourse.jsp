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
String programId = request.getParameter("program_id") ;
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
boolean access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());

CourseManager cm = CourseManager.instance();
LinkCourseProgram o = new LinkCourseProgram();
String courseId = request.getParameter("course_id") ;
Course course = new Course();
Program p = new Program();
course = cm.getCourseById(Integer.parseInt(courseId));
p = ProgramManager.instance().getProgramById(Integer.parseInt(programId));
LinkCourseProgram temp = cm.getLinkCourseProgramByCourseAndProgram(p.getId(),course.getId());
boolean linkExists = false;
if(temp != null)
{
	linkExists = true;
	o = temp;
}
%>
<div id="editProgramCourseLinkDiv"></div>
<%if( linkExists)
{ %>
<div id="programCourseLinkDiv">
	Course is <%=o.getCourseClassification().getName()%> and is typically taken <%=o.getTime().getName()%>. 
	<%if(access){%><a href="javascript:hideDiv('programCourseLinkDiv');loadURLIntoId('/cat/auth/modifyProgram/editProgramCourseLink.jsp?course_id=<%=courseId%>&program_id=<%=programId%>','#editProgramCourseLinkDiv');"><img src="/cat/images/edit_16.gif" alt="Edit course classification" title="Edit course classification"></a> <%} %>
</div>
<%
}
else
{
%>
<script type="text/javascript">
loadURLIntoId('/cat/auth/modifyProgram/editProgramCourseLink.jsp?course_id=<%=courseId%>&program_id=<%=programId%>','#editProgramCourseLinkDiv');
</script>
<%}%>
