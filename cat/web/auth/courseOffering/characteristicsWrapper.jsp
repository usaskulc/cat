<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int programId = HTMLTools.getInt((String)session.getAttribute("programId"));
String programLink = "";
if(programId >=0 )
{
	Program program = ProgramManager.instance().getProgramById(programId);
	programLink = "<a href=\"/cat/auth/programView/programWrapper.jsp?program_id="+programId+"\">"+program.getName()+"</a> &gt; ";
	String courseOfferingId = request.getParameter("course_offering_id");
	CourseManager cm = CourseManager.instance();
	CourseOffering offering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
	Course course = offering.getCourse();
	programLink += "<a href=\"/cat/auth/programView/courseCharacteristicsWrapper.jsp?program_id="+programId+"&course_id="+course.getId()+"\">"+course.getSubject()+" "+ course.getCourseNumber()+"</a> &gt; ";
}
else
{
	programLink = "<a href=\"/cat/auth/myCourses.jsp\">My Courses</a> &gt; ";
}


%>
<jsp:include page="/header.jsp"/>
<script type="text/javascript">
var graphsToDraw = new Array();
$("document").ready(function() {
	drawGraphs();
});
function drawGraphs()
{
	for(var i=0; i< graphsToDraw.length ; i++) 
	{
		eval(graphsToDraw[i]);
	}
}

</script>
		<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
					<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> &gt; 
						<a href="/cat">Curriculum Alignment Tool</a> &gt; <%=programLink%> CourseOffering characteristics</p></div>  
					<div id="CourseOfferingCharacteristicsDiv" class="module" style="overflow:auto;">
						<jsp:include page="characteristics.jsp"/>
					</div>
					<div id="modifyDiv" class="fake-input" style="display:none;"></div>
				</div>
			</div>
		</div>
<jsp:include page="/footer.jsp"/>	
