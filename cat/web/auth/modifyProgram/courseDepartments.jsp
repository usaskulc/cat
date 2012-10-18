<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int courseId = HTMLTools.getInt(request.getParameter("course_id")) ;
String programId = request.getParameter("program_id") ;
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean editing = false;
Course course = CourseManager.instance().getCourseById(courseId);

//only show this if the user is a sysadmin, or the home dept is null (new course)
List<LinkCourseDepartment> homeDepartments = CourseManager.instance().getDepartmentLinksForCourse(course);
String departmentParameter = "";
if(sysadmin || homeDepartments == null || homeDepartments.isEmpty())
{
	List<Department> list = OrganizationManager.instance().getAllDepartments();
%>
<div class="formElement">
	<div class="label">Home department(s):</div>
	<div class="field">
	<%for(LinkCourseDepartment deptLink: homeDepartments)
	{
		%><%=deptLink.getDepartment().getName()+ (!deptLink.getDepartment().getName().equals(deptLink.getDepartment().getLdapName())?"(Ldap name:"+deptLink.getDepartment().getLdapName()+")":"")  %> <a href="javascript:removeDepartmentFromCourse(<%=deptLink.getId()%>,<%=programId%>,<%=courseId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove" ></a><br>

	<%}
	%>
	</div>
	<div class="spacer"> </div>
</div>
<div class="formElement">
	<div class="label">&nbsp;</div><div class="field"> <%=HTMLTools.createSelect("department", list, "id", "name", null, "") %><input type="button" value="add" id="addDeptButton"  onclick="saveProgram(new Array('department'),new Array('department','program_id'),'LinkCourseDepartment');" /></div>
	<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
	<div class="spacer"> </div>
</div>
<%}%>

		