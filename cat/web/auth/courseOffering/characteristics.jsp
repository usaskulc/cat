<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<script src="/cat/js/bluff/js-class.js" type="text/javascript"></script>
<script src="/cat/js/bluff/bluff-min.js" type="text/javascript"></script>
<!--[if IE]>	<script src="/cat/js/bluff/excanvas.js" type="text/javascript"></script><![endif]-->

<%
String courseOfferingId = request.getParameter("course_offering_id");
CourseManager cm = CourseManager.instance();


CourseOffering offering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
%>
<a href="/cat/auth/courseOffering/characteristicsStart.jsp?course_offering_id=<%=courseOfferingId%>">Start page</a>
<h2>Summary of course offering <%=offering.getCourse().getSubject()%> 
<%=offering.getCourse().getCourseNumber()%> section 
<%=offering.getSectionNumber()%> 
 (<%=offering.getTerm()%>) <%=offering.getNumStudents()%> students</h2>
<div id="exportDataDiv">
	<jsp:include page="exportOfferingData.jsp">
		<jsp:param value="<%=offering.getId()%>" name="course_offering_id"/>	
	</jsp:include>
</div>
 
 <%
List<Feature> featureList = cm.getFeatures();
for(Feature f: featureList)
{%> 
 <div id="<%=f.getFileName()%>Div">
	<jsp:include page='<%=f.getFileName()+".jsp"%>'>
		<jsp:param value="<%=offering.getId()%>" name="course_offering_id"/>	
	</jsp:include>
</div>
<hr/>
<%
}%>
<div id="courseOfferingCommentsDiv">
	<jsp:include page="comments.jsp">
		<jsp:param value="<%=offering.getId()%>" name="course_offering_id"/>	
	</jsp:include>
</div>




