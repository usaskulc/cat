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
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));

QuestionManager qm = QuestionManager.instance();

Program o = ProgramManager.instance().getProgramById(programId);
CourseOffering offering = CourseManager.instance().getCourseOfferingById(courseOfferingId);
List<QuestionResponse> responses = qm.getAllQuestionResponsesForProgramAndOffering(o,offering);

session.setAttribute("programQuestionResponses", responses);



List<Question> questionLinks = qm.getAllQuestionsForProgram(o);

%>
<ol>
<%
StringBuilder clearItems = new StringBuilder();
int questionCount=1;
for(Question q : questionLinks)
{
	%><li id="area_<%=programId%>_<%=courseOfferingId%>_<%=q.getId()%>"><%
	String questionType = q.getQuestionType().getName(); //select, radio, checkbox or textarea
	%>
	<jsp:include page="question.jsp">
			<jsp:param name="question_id" value="<%=q.getId()%>"/>
			<jsp:param name="program_id" value="<%=programId%>"/>
			<jsp:param name="course_offering_id" value="<%=courseOfferingId%>"/>	
		</jsp:include>
	</li>
	<%
	clearItems.append("$(\"#area_");
	clearItems.append(programId);
	clearItems.append("_");
	clearItems.append(courseOfferingId);
	clearItems.append("_");
	clearItems.append(q.getId());
	clearItems.append("\").removeClass(\"completeMessage\");");
	
}
%>
</ol>
<%if(!questionLinks.isEmpty())
	{%>
	<script type="text/javascript">
	function clearItems()
	{
		<%=clearItems.toString()%>
	}
	</script>

		<div class="formElement">
			<div class="label">
			<input type="button" 
				   name="saveCustomQuestionsButton" 
				   id="saveCustomQuestionsButton" 
				   value="Save responses" 
				   onclick="clearItems();saveOffering(new Array('program_id','course_offering_id'),
				   				new Array('course_offering_id','program_id'),'Questions');" />
		</div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	
	<%} %>

