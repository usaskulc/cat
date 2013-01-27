<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>

<%
String programId = request.getParameter("program_id") ;
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
@SuppressWarnings("unchecked")
HashMap<String,Program>  userHasAccessToPrograms = (HashMap<String,Program> )session.getAttribute("userHasAccessToPrograms");
boolean access = sysadmin || userHasAccessToPrograms!=null && userHasAccessToPrograms.containsKey(programId);

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
