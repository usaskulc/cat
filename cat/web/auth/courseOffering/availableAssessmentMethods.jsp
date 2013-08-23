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
String organizationId = request.getParameter("organization_id");
String courseOfferingId = request.getParameter("course_offering_id");
String name = request.getParameter("name");

Assessment createdAssessment = null;
CourseManager cm = CourseManager.instance();
if(name!=null)
{
	createdAssessment = cm.getAssessmentByName(name);
}
int assessmentMethodLinkId = HTMLTools.getInt(request.getParameter("assessment_link_id"));
LinkCourseOfferingAssessment o = new LinkCourseOfferingAssessment();
CourseOffering courseOffering = new CourseOffering();

boolean linkLoaded = false;
String assessmentId = null;
if(assessmentMethodLinkId > -1)
{
	o = cm.getLinkAssessmentById(assessmentMethodLinkId);
	linkLoaded = true;
	courseOffering = o.getCourseOffering();
	courseOfferingId = ""+courseOffering.getId();
	assessmentId = ""+ o.getAssessment().getId();
}
else 
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}
out.println(HTMLTools.createSelectAssessmentMethods("assessmentMethod", cm.getAssessments(),assessmentId));
	
%>
		
	


