<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<form>
<input type="button" value="Select All Courses" onClick="selectCourses('all');"> &nbsp; <input type="button" value="De-select All Courses" onClick="selectCourses('none');"><br/>

<%
int departmentId = HTMLTools.getInt(request.getParameter("department_id"));
String subjectParameter = request.getParameter("subjectParameter") ;
CourseManager cm = CourseManager.instance();
Course course = new Course();
List<String> subjects = cm.getCourseSubjects();
out.println(HTMLTools.createSelect("courseSubject",subjects, subjects, subjectParameter, "loadDeptCourseNumbers('courseSubject',"+departmentId+")"));
if(!HTMLTools.isValid(subjectParameter) && subjects.size()>0)
{
	subjectParameter = subjects.get(0);
}
List<String> courseNumbers = new ArrayList<String>();
List<String> alreadyHasAsHomedepartment = new ArrayList<String>();
if(subjectParameter != null)
{
	courseNumbers = cm.getCourseNumbersForSubject(subjectParameter);
	alreadyHasAsHomedepartment = cm.getCourseNumbersForSubjectAndDepartment(subjectParameter,departmentId);
}

%>
<input type="hidden" name="department_id" id="department_id" value="<%=departmentId%>" />
<br/>
<% 
for(String courseNum : courseNumbers)
{
	String selected = "";
	if(alreadyHasAsHomedepartment.contains(courseNum))
		selected="checked=\"checked\"";

	%>
	<input type="checkbox" name="course_number_checkbox_<%=courseNum%>"  id="course_number_checkbox_<%=courseNum%>" <%=selected%> value="<%=courseNum%>"/><%=courseNum%><br/>
	<%
}
%>
<div class="formElement">
		<div class="label"><input type="button" name="saveCoursesButton" id="saveCoursesButton" value="Save Courses for Department" onclick="saveSystem(new Array('department_id'),new Array('department_id','courseSubject'),'DepartmentCourses');" /></div>
		<div class="field"><div id="message2Div" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>


</form>


