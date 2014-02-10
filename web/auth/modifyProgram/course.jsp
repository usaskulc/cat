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
String courseId = request.getParameter("course_id") ;
String programId = request.getParameter("program_id") ;
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean editing = false;
Course o = new Course();
if(courseId != null  && courseId.trim().length() > 0)
{
	o = CourseManager.instance().getCourseById(Integer.parseInt(courseId));
	editing = true;
}
%>
<form name="newCourseForm" id="newCourseForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Course"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<% if(o.getId() > 0)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<script type="text/javascript">
				selectedCourseId = <%=o.getId()%>
			</script>
			<%
		}
		%>
	<div class="formElement">
		<div class="label">Subject:</div>
		<div class="field"> <input type="text" size="6" name="subject" id="subject" value="<%=editing?o.getSubject():""%>"  <%=editing?"disabled=\"disabled\"":""%>/></div>
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">Course Number:</div>
		<div class="field"> <input type="text" size="6" name="courseNumber" id="courseNumber" value="<%=editing?o.getCourseNumber():""%>"  <%=editing?"disabled=\"disabled\"":""%>/></div>
		<div class="error" id="titleMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">Title:</div>
		<div class="field"> <input type="text" size="40" name="title" id="title" value="<%=editing?o.getTitle():""%>"/></div>
		<div class="error" id="titleMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">Description:</div>
		<div class="field"> <textarea name="description" id="description" cols="40" rows="6"><%=editing?o.getDescription():""%></textarea></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<%
	//only show this if the user is a sysadmin, or the home dept is null (new course)
	List<Organization> homeOrganizations = CourseManager.instance().getOrganizationForCourse(o);
	String organizationParameter = "";
	if(editing && (sysadmin || homeOrganizations == null || homeOrganizations.isEmpty()) )
	{
		organizationParameter = ",'organization'";
	%>
	<div id="courseOrganizationsDiv">
		<jsp:include page="courseOrganizations.jsp"/>
	</div>
	<%} %>
	To assign this course to your department, please contact a system administrator (e.g., gmcte@usask.ca).
	<br/>
	
	<div class="formElement">
		<div class="label"><input type="button" name="saveCourseButton" id="saveCourseButton" value="Save Course" onclick="saveProgram(new Array('subject','courseNumber','title'<%=organizationParameter%>),new Array('subject','courseNumber','title','description','organization','program_id'));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		
