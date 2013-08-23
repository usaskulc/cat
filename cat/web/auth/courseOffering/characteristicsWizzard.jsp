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
CourseManager cm = CourseManager.instance();
List<Feature> featureList = cm.getFeatures();

int featureId = HTMLTools.getInt(request.getParameter("feature"));
int nextFeature = 0;
int prevFeature = 0;
if(featureId <= 1)
{
	featureId = 1;
	prevFeature = -1;
	nextFeature = 2;
}
else if(featureId == featureList.size())
{
	prevFeature  = featureId - 1;
	nextFeature = -1;
}
else
{
	prevFeature = featureId - 1;
	nextFeature = featureId + 1;
}
Feature feature = featureList.get(featureId-1);
%>
<%

int programId = HTMLTools.getInt((String)session.getAttribute("programId"));
String programLink = "";
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));

if (courseOfferingId < 0)
{
	%><h1>NO COURSE OFFERING ID FOUND!!!</h1>
	<%
	return;
}
CourseOffering courseOffering = cm.getCourseOfferingById(courseOfferingId);
if(programId >=0 )
{
	Program program = ProgramManager.instance().getProgramById(programId);
	programLink = "<a href=\"/cat/auth/programView/programWrapper.jsp?program_id="+programId+"\">"+program.getName()+"</a> &gt; ";	
	Course course = courseOffering.getCourse();
	programLink += "<a href=\"/cat/auth/programView/courseCharacteristicsWrapper.jsp?program_id="+programId+"&course_id="+course.getId()+"\">"+course.getSubject()+" "+ course.getCourseNumber()+"</a> &gt; ";
}
else
{
	programLink = "<a href=\"/cat/auth/myCourses.jsp\">My Courses</a> &gt; ";
}


%>
<jsp:include page="/header.jsp"/>

		<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
					<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> &gt; 
						<a href="/cat">Curriculum Alignment Tool</a> &gt; <%=programLink%> CourseOffering characteristics</p></div>  
					<div id="characteristicsWizzardDiv" class="module" style="overflow:auto;">
					<form>
					<%if(prevFeature < 0){ %>
						<input type="button" onclick="document.location='characteristicsStart.jsp?course_offering_id=<%=courseOfferingId%>';" value="Start page">
					<% }
					else
					{%>	
					   <input type="button" onclick="document.location='characteristicsStart.jsp?course_offering_id=<%=courseOfferingId%>';" value="Start page">
					   <input type="button" onclick="document.location='characteristicsWizzard.jsp?feature=<%=prevFeature%>&course_offering_id=<%=courseOfferingId%>';" value="Previous">
					<%}
					
					%><img src="/cat/images/blankbox.gif" style="width:500px;height:10px;"/>
					<%
					if(nextFeature < 0){
					%>
						<input type="button" onclick="document.location='characteristicsWrapper.jsp?course_offering_id=<%=courseOfferingId%>';" value="Summary"/> 
					<%}
					else
					{%>
					<input type="button" onclick="document.location='characteristicsWizzard.jsp?feature=<%=nextFeature%>&course_offering_id=<%=courseOfferingId%>';" value="Next"/> 
					<input type="button" onclick="document.location='characteristicsWrapper.jsp?course_offering_id=<%=courseOfferingId%>';" value="Summary"/> 
				
					<%} %>
					</form>
					<h2>Characteristics of course offering <%=courseOffering.getCourse().getSubject()%> <%=courseOffering.getCourse().getCourseNumber()%> section 
							<%=courseOffering.getSectionNumber()%> 
					 (<%=courseOffering.getTerm()%>) <%=courseOffering.getNumStudents()%> students</h2>
				
						<div id="<%=feature.getFileName()%>Div" class="module" style="overflow:auto;">
					       <jsp:include page='<%=feature.getFileName()+".jsp"%>' >
					       		<jsp:param name="course_offering_id" value='<%=courseOfferingId%>'/>
					       </jsp:include>
					    </div>
					  <form>
					<%if(prevFeature < 0){ %>
						<input type="button" onclick="document.location='characteristicsStart.jsp?course_offering_id=<%=courseOfferingId%>';" value="Start page">
					<% }
					else
					{%> 
					   <input type="button" onclick="document.location='characteristicsWizzard.jsp?feature=<%=prevFeature%>&course_offering_id=<%=courseOfferingId%>';" value="Previous">
					<%}
					
					%><img src="/cat/images/blankbox.gif" style="width:500px;height:10px;"/>
					<%
					if(nextFeature < 0){
					%>
						<input type="button" onclick="document.location='characteristicsWrapper.jsp?course_offering_id=<%=courseOfferingId%>';" value="Summary"/> 
					<%}
					else
					{%>
					<input type="button" onclick="document.location='characteristicsWizzard.jsp?feature=<%=nextFeature%>&course_offering_id=<%=courseOfferingId%>';" value="Next"/> 
					<%} %>
					</form>
				     
					</div>
					<div id="modifyDiv" class="fake-input" style="display:none;"></div>
				</div>
			</div>
		</div>
<jsp:include page="/footer.jsp"/>	
