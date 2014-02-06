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
