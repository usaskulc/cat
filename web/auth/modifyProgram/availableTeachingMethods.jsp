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
String programId = request.getParameter("program_id");
String courseOfferingId = request.getParameter("courseOffering_id");
String teachingMethodLinkId = request.getParameter("id");
LinkCourseOfferingTeachingMethod o = new LinkCourseOfferingTeachingMethod();
CourseOffering courseOffering = new CourseOffering();
String name = request.getParameter("name");
TeachingMethod createdTeachingMethod = null;
CourseOfferingManager cm = CourseOfferingManager.instance();
if(name!=null)
{
	createdTeachingMethod = cm.getTeachingMethodByName(name);
}
boolean linkLoaded = false;
if(teachingMethodLinkId != null && teachingMethodLinkId.trim().length() > 0)
{
	o = cm.getLinkTeachingMethodById(Integer.parseInt(teachingMethodLinkId));
	linkLoaded = true;
	courseOffering = o.getCourseOffering();
	courseOfferingId = ""+courseOffering.getId();
}
else 
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}

List<TeachingMethod> notUsed = cm.getTeachingMethodsNotUsed(courseOffering);
List<String> ids = new ArrayList<String>();
List<String> names = new ArrayList<String>();
for(TeachingMethod tm :notUsed)
{
	ids.add(""+tm.getId());
	names.add(tm.getName());
}
out.println(HTMLTools.createSelect("teachingMethod",ids, names, createdTeachingMethod!=null ?""+createdTeachingMethod.getId():null, null));
%>
<a href="javascript:openDiv('newTeachingMethodDiv');"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"  class="smaller">Add a teaching method</a>




