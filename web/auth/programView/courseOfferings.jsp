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
String courseId = request.getParameter("course_id");
String programId = request.getParameter("program_id");
session.setAttribute("programId",programId);
CourseManager cm = CourseManager.instance();
Course course = cm.getCourseById(Integer.parseInt(courseId));
@SuppressWarnings("unchecked")
HashMap<String,CourseOffering> userHasAccessToOfferings = (HashMap<String,CourseOffering>)session.getAttribute("userHasAccessToOfferings");

List<CourseOffering> offerings = (List<CourseOffering>)cm.getCourseOfferingsForCourse(course);
List<String> terms = cm.getAvailableTermsForCourse(course);

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
boolean hasInstructorAttributes = false;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	
	List<InstructorAttribute> attributes = OrganizationManager.instance().getInstructorAttributes(organization);
	hasInstructorAttributes = attributes != null && !attributes.isEmpty();

	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}

String regularTerm1 = "";
String regularTerm2 = "";

for(String term: terms)
{
	if(regularTerm1.length()==0 && term.endsWith("09"))
		regularTerm1 = term;
	if(regularTerm2.length() == 0 && term.endsWith("01"))
		regularTerm2 = term;
	%>
	<input type="checkbox" onchange="toggleTerms('<%=term%>');" id="<%=term%>checkbox" <%=(term.equals(regularTerm1)|| term.equals(regularTerm2))?"checked=\"checked\"":""%>  /> <%=term%> &nbsp; &nbsp; 
	<%
}
%>(You can hide offerings of a term by un-checking the corresponding checkbox)
<ul>
<%
for(CourseOffering offering : offerings)
{
	String hide = (offering.getTerm().equals(regularTerm1)|| offering.getTerm().equals(regularTerm2))?"":"style=\"display:none;\"";
	
	boolean accessToOffering = sysadmin || (userHasAccessToOfferings!=null && userHasAccessToOfferings.containsKey(""+offering.getId()));
	%>
	<li class="Term_<%=offering.getTerm()%>" <%=hide%> >
	 <%if(accessToOffering){%><a href="/cat/auth/courseOffering/characteristicsStart.jsp?course_offering_id=<%=offering.getId()%>"><%}%>section
	 		 <%=offering.getSectionNumber()%> in <%=offering.getTerm()%> ( <%=offering.getMedium() %> )<%if(accessToOffering){%></a><%}%>
	 		 <%=cm.getInstructorsString(offering,access,programId,hasInstructorAttributes)%> (<%=offering.getNumStudents()%> students)
	 <%if(access){%> <a href="javascript:loadModify('/cat/auth/modifyProgram/addCourseOfferingToCourse.jsp?program_id=<%=programId%>&course_id=<%=course.getId()%>&course_offering_id=<%=offering.getId()%>');"><img src="/cat/images/edit_16.gif" alt="Edit course offering details" title="Edit course offering details"></a><%}%>
	 <%if(access){%> <a href="javascript:removeOfferingFromCourse(<%=course.getId()%>,<%=offering.getId()%>,<%=programId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove course offering" title="Remove course offering" ></a><%} %>
	</li>
	<% 
}
if(offerings.isEmpty())
{
	out.println("No courses offerings in the system (yet).");
}
if(access)
{
%>
	<li>	<a href="javascript:loadModify('/cat/auth/modifyProgram/addCourseOfferingToCourse.jsp?course_id=<%=course.getId()%>&program_id=<%=programId%>');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add a course offering" title="Add a course offering"/>
				Add a course offering
			</a>
	</li>
<%} %>
</ul>
