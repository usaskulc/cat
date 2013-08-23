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



<h2>Some final questions</h2>
<br>
Please complete the following questions and click the "save responses" button to save your answers.
<br/>
<%
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(courseOfferingId);
String programId = (String)session.getAttribute("programId");

OrganizationManager dm = OrganizationManager.instance();
int programIdParameter = HTMLTools.getInt(request.getParameter("program_id"));
if(programIdParameter > -1)
{
	session.setAttribute("programId",""+programIdParameter);
	programId = ""+programIdParameter; 
}

out.println("Currently selected Program :");
List<Organization> organizations = cm.getOrganizationForCourseOffering(courseOffering);
List<Program> programs = new ArrayList<Program>();
Program bogus = new Program();
bogus.setId(-1);
bogus.setName("Please select a Program");
programs.add(bogus);
for(Organization dep : organizations)
{
	programs.addAll(dm.getProgramOrderedByNameForOrganization(dep));
}
out.println(HTMLTools.createSelect("programToSet", programs, "Id", "Name", programId, "setProgramIdQuestions("+courseOfferingId+")"));

if(!HTMLTools.isValid(programId))
{
	return;
}

%>
<form>
		<input type="hidden" name="program_id" value="<%=programId%>" id="program_id" />
		<input type="hidden"  name="course_offering_id" value="<%=courseOfferingId%>" id="course_offering_id"/>	

<jsp:include page="programQuestions.jsp" >
<jsp:param name="program_id" value="<%=programId%>"/>
<jsp:param name="course_offering_id" value="<%=courseOfferingId%>"/>
</jsp:include>

</form>
