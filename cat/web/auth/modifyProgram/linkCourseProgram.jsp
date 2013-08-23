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
String linkId = request.getParameter("link_id") ;

CourseManager cm = CourseManager.instance();
LinkCourseProgram o = new LinkCourseProgram();
Course course = new Course();
String subject = null;
String courseNumber = null;
String courseTitle = null;
boolean courseLoaded = false;

if(linkId != null  && linkId.trim().length() > 0)
{
	o = cm.getLinkCourseProgramById(Integer.parseInt(linkId));
	course = o.getCourse();
	subject = course.getSubject();
	courseTitle = course.getTitle();
	courseNumber = ""+course.getCourseNumber();
	courseLoaded = true;
}

String courseId = courseLoaded ? ""+ course.getId() : request.getParameter("course_id");


if(!courseLoaded)
{
	if(courseId != null  && courseId.trim().length() > 0)
	{
		course = cm.getCourseById(Integer.parseInt(courseId));
		subject = course.getSubject();
		courseNumber = ""+course.getCourseNumber();
	}
}

%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>
<form name="newObjectForm" id="newObjectForm" method="post" action="" >
	<div id="courseInfoDiv">
		<jsp:include page="/auth/modifyProgram/chooseCourse.jsp" />
	</div>
	<div id="addCourseLinkDiv">
	<% 
	if(o.getId() > 0)
	{//Course is selected, show classification, start and end
		CourseClassification classification = o.getCourseClassification();
		List<CourseClassification> classifications = cm.getCourseClassifications();
		List<String> classifcationIds = new ArrayList<String>();
		List<String> classifcationNames = new ArrayList<String>();
		for(CourseClassification classif : classifications)
		{
			classifcationIds.add(""+classif.getId());
			classifcationNames.add(classif.getName());
		}
		out.println(HTMLTools.createSelect("courseClassifcation",classifcationIds, classifcationNames, ""+classification.getId(), null));
		Time time = o.getTime();
		
		List<Time> times = cm.getCourseTimes();
		out.println(HTMLTools.createSelect("time",times,"Id","Name", ""+time.getId(), null));
	}
	%>	<br/>
	</div>
</form>

