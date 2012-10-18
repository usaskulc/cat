<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>



<%
String programId = (String)session.getAttribute("programId");
if(!HTMLTools.isValid(programId))
{
	%>
	<span class="smaller">Copy data to another section of this course: unable to determine what program this offering is a part of.</span>
	<%
	return;
}

String courseOfferingId = request.getParameter("course_offering_id");
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
List<LinkCourseOfferingTeachingMethod> tMethods = cm.getTeachingMethods(courseOffering);
if(tMethods.isEmpty())
{
	%>
	<span class="smaller">Copy data to another section of this course: no data to copy.</span>
	<%return;
}

Course course = courseOffering.getCourse();

@SuppressWarnings("unchecked")
HashMap<String,CourseOffering> userHasAccessToOfferings = (HashMap<String,CourseOffering>)session.getAttribute("userHasAccessToOfferings");

List<CourseOffering> offerings = (List<CourseOffering>)cm.getCourseOfferingsWithoutDataForCourse(course);
%>
<%
if(offerings.size() < 1)
{%>
   <span class="smaller">Copy data to another section of this course: no other sections to copy data to.</span>
	<%return;
}
%>
<a href="javascript:openDiv('exportDataPageDiv');" class="smaller">Copy data to another section of this course</a>
<div id="exportDataPageDiv" style="display:none;">
	<form>
		Copy data to : <%=HTMLTools.createSelect("exportOfferingId", offerings, "Id","Display", null,null)%>
		<div class="formElement">
			<div class="label"><input type="button" value="Copy now" id="exportButton" onclick="exportDataFrom(<%=courseOfferingId%>,<%=programId%>)"/></div>
			<div class="field">
				<div id="messageDiv" class="completeMessage"></div>
			</div>
		</div>
	</form>
	<hr/>
</div>