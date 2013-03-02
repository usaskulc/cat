<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>


<p>
<strong>Thank you for completing the sections</strong>
<br/>
<br/>
Some final questions:
</p>

<%
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(courseOfferingId);
int programId = HTMLTools.getInt((String)session.getAttribute("programId"));
%>
<form>

<jsp:include page="programQuestions.jsp" >
<jsp:param name="program_id" value="<%=programId%>"/>
<jsp:param name="course_offering_id" value="<%=courseOfferingId%>"/>
</jsp:include>

</form>