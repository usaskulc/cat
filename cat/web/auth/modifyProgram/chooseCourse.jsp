<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id") ;
%>
	<div id="existingCourseSelector">
		<jsp:include page="existingCourseSelector.jsp"/>
	</div>
<br>
	<a href="javascript:openDiv('addCourseDiv');" class="smaller"><img src="/cat/images/add_24.gif" style="height:14pt;" alt="Add" >Add a course (the one I am looking for isn't in the system yet)</a>
<br>
<div id="addCourseDiv" style="display:none;">
	<jsp:include page="/auth/modifyProgram/course.jsp"/>
</div>

		