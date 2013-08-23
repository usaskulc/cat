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
	int courseId = HTMLTools.getInt(request.getParameter("course_id")) ;
String programId = request.getParameter("program_id") ;
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean editing = false;
Course course = CourseManager.instance().getCourseById(courseId);

//only show this if the user is a sysadmin, or the home dept is null (new course)
List<LinkCourseOrganization> homeOrganizations = CourseManager.instance().getOrganizationLinksForCourse(course);
String organizationParameter = "";
if(sysadmin || homeOrganizations == null || homeOrganizations.isEmpty())
{
	List<Organization> list = OrganizationManager.instance().getAllOrganizations(false);
%>
<div class="formElement">
	<div class="label">Home organization(s):</div>
	<div class="field">
	<%
		for(LinkCourseOrganization orgLink: homeOrganizations)
		{
	%><%=orgLink.getOrganization().getName()+ (!orgLink.getOrganization().getName().equals(orgLink.getOrganization().getSystemName())?"(system name:"+orgLink.getOrganization().getSystemName()+")":"")  %> <a href="javascript:removeOrganizationFromCourse(<%=orgLink.getId()%>,<%=programId%>,<%=courseId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove course from organization" title="Remove course from organization" ></a><br>

	<%}
	%>
	</div>
	<div class="spacer"> </div>
</div>
<div class="formElement">
	<div class="label">&nbsp;</div><div class="field"> <%=HTMLTools.createSelect("organization", list, "id", "name", null, "") %><input type="button" value="add" id="addDeptButton"  onclick="saveProgram(new Array('organization'),new Array('organization','program_id'),'LinkCourseOrganization');" /></div>
	<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
	<div class="spacer"> </div>
</div>
<%}%>

		
