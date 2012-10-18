<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
String subjectParameter = request.getParameter("subjectParameter") ;
String courseNumberParameter = request.getParameter("courseNumberParameter") ;
String courseId = request.getParameter("courseId");
boolean courseLoaded = false;
CourseManager cm = CourseManager.instance();
Course course = new Course();
if(courseId != null  && courseId.trim().length() > 0)
{
	course = cm.getCourseById(Integer.parseInt(courseId));
	subjectParameter = course.getSubject();
	courseNumberParameter = ""+course.getCourseNumber();
	courseLoaded = true; 
}
else if(courseNumberParameter!=null && courseNumberParameter.length()>0 && subjectParameter!=null && subjectParameter.length()>0)
{
	course = cm.getCourseBySubjectAndNumber(subjectParameter,courseNumberParameter);
	courseLoaded = true;
}
if(courseLoaded)
{
	%><input type="hidden" name="courseId" id="courseId" value="<%=course.getId()%>"/>
	<%
}
List<String> subjects = cm.getCourseSubjects();
out.println(HTMLTools.createSelect("courseSubject",subjects, subjects, subjectParameter, "loadCourseNumbers('courseSubject',"+programId+")"));
if(!courseLoaded &&  (subjectParameter==null || subjectParameter.length()<1) && subjects.size()>0)
{
	subjectParameter = subjects.get(0);
}
List<String> courseNumbers = new ArrayList<String>();
if(subjectParameter != null)
{
	courseNumbers = cm.getCourseNumbersForSubject(subjectParameter);
	if((courseNumberParameter== null || courseNumberParameter.length()<1) &&  courseNumbers.size()>0)
	{
		courseNumberParameter = courseNumbers.get(0);
		course = cm.getCourseBySubjectAndNumber(subjectParameter,courseNumberParameter);
		courseLoaded = true;
	}
	
}
out.println(HTMLTools.createSelect("courseNumberParameter",courseNumbers, courseNumbers, courseNumberParameter, "loadCourseFromSubjectAndNumber('"+subjectParameter+"','courseNumberParameter',"+programId+")"));
if(courseLoaded)
{
	out.println(course.getTitle());
	{
		%>
		<script type="text/javascript">
			selectedCourseId = <%=course.getId()%>
		</script>
		<%
	}
	if(cm.isAlreadyPartOfProgram(Integer.parseInt(programId),course.getId()))
	{
		out.println("<span style='font-weight:boild;color:red;'> Already part of this program</span>");	
	}
	else
	{
		%>
		<a href="/cat/auth/programView/courseCharacteristicsWrapper.jsp?program_id=<%=programId%>&course_id=<%=course.getId()%>">Add this course</a>
		<%
	}
}
%>

