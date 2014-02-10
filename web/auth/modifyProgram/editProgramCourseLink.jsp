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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>

<%
String programId = request.getParameter("program_id") ;

CourseManager cm = CourseManager.instance();
LinkCourseProgram o = new LinkCourseProgram();
String courseId = request.getParameter("course_id") ;
LinkCourseProgram temp = cm.getLinkCourseProgramByCourseAndProgram(Integer.parseInt(programId),Integer.parseInt(courseId));
boolean linkExists = false;
if(temp != null)
{
	linkExists = true;
	o = temp;
}
%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>
<form name="newObjectForm" id="newObjectForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="LinkCourseProgram"/>
	<input type="hidden" name="course_id" id="course_id" value="<%=courseId%>"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
		<% 
		if(linkExists)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<%
		}

		CourseClassification classification = linkExists ? o.getCourseClassification() : new CourseClassification();
		List<CourseClassification> classifications = cm.getCourseClassifications();
		List<String> classifcationIds = new ArrayList<String>();
		List<String> classifcationNames = new ArrayList<String>();
		for(CourseClassification classif : classifications)
		{
			classifcationIds.add(""+classif.getId());
			classifcationNames.add(classif.getName());
		}
		%>
		<div class="formElement">
			<div class="label">This class is :</div>
			<div class="field">
			<%
		out.println(HTMLTools.createSelect("courseClassifcation",classifcationIds, classifcationNames, linkExists ? ""+classification.getId() : null, null));
			%>
			</div>
		</div>
		<hr/>
		<%
		Time time = o.getTime();
		List<Time> times = cm.getCourseTimes();
		%>
		<div class="formElement">
			<div class="label">This class is typically taken :</div>
			<div class="field">
			<%
		out.println(HTMLTools.createSelect("time",times, "Id","Name", linkExists ? "" + time.getId() : null, null));
			%>
			</div>
		</div>
		<hr/>
		<br/>

		<div class="formElement">
			<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveProgram(new Array('courseClassifcation','time'),new Array('courseClassifcation','time','course_id','program_id'),'LinkCourseProgram');" /></div>
			<div class="field"><div id="messageDiv" class="error" style="display:none;"></div></div>
			<div class="spacer"> </div>
		</div>
</form>
