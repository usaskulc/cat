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
<form>
<input type="button" value="Select All Courses" onClick="selectCourses('all');"> &nbsp; <input type="button" value="De-select All Courses" onClick="selectCourses('none');"><br/>

<%
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
String subjectParameter = request.getParameter("subjectParameter") ;
CourseManager cm = CourseManager.instance();
Course course = new Course();
List<String> subjects = cm.getCourseSubjects();
out.println(HTMLTools.createSelect("courseSubject",subjects, subjects, subjectParameter, "loadDeptCourseNumbers('courseSubject',"+organizationId+")"));
if(!HTMLTools.isValid(subjectParameter) && subjects.size()>0)
{
	subjectParameter = subjects.get(0);
}
List<String> courseNumbers = new ArrayList<String>();
List<String> alreadyHasAsHomeorganization = new ArrayList<String>();
if(subjectParameter != null)
{
	courseNumbers = cm.getCourseNumbersForSubject(subjectParameter);
	alreadyHasAsHomeorganization = cm.getCourseNumbersForSubjectAndOrganization(subjectParameter,organizationId);
}

%>
<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>" />
<br/>
<% 
for(String courseNum : courseNumbers)
{
	String selected = "";
	if(alreadyHasAsHomeorganization.contains(courseNum))
		selected="checked=\"checked\"";

	%>
	<input type="checkbox" name="course_number_checkbox_<%=courseNum%>"  id="course_number_checkbox_<%=courseNum%>" <%=selected%> value="<%=courseNum%>"/><%=courseNum%><br/>
	<%
}
%>
<div class="formElement">
		<div class="label"><input type="button" name="saveCoursesButton" id="saveCoursesButton" value="Save Courses for Organization" onclick="saveSystem(new Array('organization_id'),new Array('organization_id','courseSubject'),'OrganizationCourses');" /></div>
		<div class="field"><div id="message2Div" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>


</form>


