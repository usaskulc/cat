<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>

	<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<jsp:include page="/header.jsp"/>
		<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
					<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> 
						&gt; <a href="/cat">Curriculum Alignment Tool</a> &gt; My Courses </p></div>  
	
					
					<div id="administration" class="module" style="overflow:auto;">
					
					
<br/>
Welcome to the Gwenna Moss Centre for Teaching Effectiveness course information tool designed to assist academic units 
at the University of Saskatchewan with curriculum mapping and, ultimately, with curriculum innovation processes.

<h4><i>What is curriculum mapping?</i></h4>
Curriculum mapping refers to a process in a broader curriculum development 
initiative in which an academic unit seeks to understand what is currently 
offered to students in the curriculum and how what is offered meets established or renewed program goals.  
The information entered in this tool makes a vital contribution to curriculum mapping. 
<h4><i>Why me?</i></h4>
You are someone who teaches in a program that is undertaking a curriculum development, renewal, or innovation process.   Courses you have taught in the past 24 months are highlighted below.  When you click on a course, you will enter the Course Information Page where you can input information about the course.
<h4><i>How will this be used?</i></h4>
A curriculum planning initiative will use this course inventory to be able to conveniently view the outcomes across the entire current curriculum and, then, begin to assess how well these match with the desired program outcomes.  This is the information that allows such a group to discuss what adjustments and alignments are necessary.  
<h4><i>What do I need to do?</i></h4>
A system administrator has set the tool for your academic unit's use. When you sign in, you will see the courses you have taught recently.   If you have taught several, your local leader will advise you which courses you are asked to enter.   
<h4><i>What will I need to complete the tool?</i></h4>
<ul>
	<li>Your syllabus from your course, and other course materials for identifying your teaching methods, assessments and course learning outcomes.</li>
</ul>

You may find that completing this tool helps you think about some aspects of your teaching in a fresh or new way...
					
					<h3>Courses I taught</h3>
<ul>
	<%
	CourseManager cm = CourseManager.instance();
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
List<CourseOffering> sections = CourseManager.instance().getTeachingCourseOfferings(userid);
if(sections ==null || sections.isEmpty())
{
	out.println("You don't appear to have taught any sections recently");
	
}
else
{
	for(CourseOffering offering : sections)
	{
		
		
		%>
		<li><a href="/cat/auth/courseOffering/characteristicsStart.jsp?course_offering_id=<%=offering.getId()%>">
					<%=offering.getCourse().getSubject()%> <%=offering.getCourse().getCourseNumber()%> section <%=offering.getSectionNumber()%> (<%=offering.getTerm()%>)
				</a></li>
		<%
	}
}
%>
</ul>
				
					</div>
				</div>
			</div>
		</div>


<jsp:include page="/footer.jsp"/>		

