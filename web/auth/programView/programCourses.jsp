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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}

ProgramManager pm = ProgramManager.instance();

Program o = pm.getProgramById(Integer.parseInt(programId));
List<LinkCourseProgram> courseLinks = pm.getLinkCourseProgramForProgram(o);
CourseManager cm = CourseManager.instance();

%>
<ul>
<%
if(access)
{
%>
	<li>	<a href="javascript:loadModifyIntoDivWithReload('/cat/auth/modifyProgram/linkCourseProgram.jsp?program_id=<%=o.getId()%>','','programCoursesDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add a course" title="Add a course"/>
				Add a course
			</a>
	</li>
<%} 
String prevTime = "";
for(LinkCourseProgram link : courseLinks)
{
	Course c = cm.getCourseForLinkProgram(link.getId());
	String attributeString = cm.getCourseAttributesString(c, o.getId(),access);
	CourseClassification classification = link.getCourseClassification();
	Time time = link.getTime();
	List<Organization> depts = cm.getOrganizationForCourse(c);
	String deptString = "";
	boolean first = true;
	for(Organization dept:depts)
	{
		if(!first)
			deptString+=", ";
		else
			first = false;
		deptString+=dept.getName();
	}
	if(!prevTime.equals(time.getName()))
	{
		out.println("Courses taken by students "+time.getName()+":");
	}
	%>
	<li><a href="/cat/auth/programView/courseCharacteristicsWrapper.jsp?program_id=<%=programId%>&course_id=<%=c.getId()%>&link_id=<%=link.getId()%>" ><span title="Offered by <%=deptString%>"><%=c.getSubject()%> <%=c.getCourseNumber()%></span>
			 <%=c.getTitle()%> (<%=classification.getName()%>)</a> <%=attributeString%>
	 <%if(access){%><a href="javascript:removeProgramCourse(<%=o.getId()%>,<%=link.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove course" title="Remove course"></a><%} %>
	
	</li>
	<% 
	prevTime= time.getName();
}
if(courseLinks.isEmpty())
{
	out.println("No courses added (yet).");
}
%>
</ul>
