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
int questionId = HTMLTools.getInt(request.getParameter("question_id"));
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
QuestionManager qm = QuestionManager.instance();
Question q = qm.getQuestionById(questionId);
String questionType = q.getQuestionType().getName(); //select, radio, checkbox or textarea
@SuppressWarnings("unchecked")
List<QuestionResponse> responses = (List<QuestionResponse>) session.getAttribute("programQuestionResponses");
List<String> answers = responseValue(responses, questionId);
%>
<%=q.getDisplay()%>
<%
String answerText = "";
if(answers.size()>0)
	answerText = answers.get(0);
if(questionType.equals("select"))
{
	List<AnswerOption> options = new ArrayList<AnswerOption>();
	options.addAll(q.getAnswerSet().getAnswerOptions());
	
	out.println(HTMLTools.createSelect(programId + "_" + courseOfferingId + "_" + questionId , options, "value", "display", answerText, ""));
}
else if(questionType.equals("textarea"))
{
	
		
	%>
	<textarea id="<%=programId%>_<%=courseOfferingId%>_<%=questionId%>" name="<%=programId%>_<%=courseOfferingId%>_<%=questionId%>" cols="40" rows="6"><%=answerText%></textarea>
	<%
}
else
{
%>


	<div style="padding-left:40px;">
		<jsp:include page="answerSet.jsp">
			<jsp:param name="answer_set_id" value="<%=q.getAnswerSet().getId()%>"/>
			<jsp:param name="question_type" value="<%=questionType %>"/>
			<jsp:param name="question_id" value="<%=q.getId()%>"/>
			<jsp:param name="program_id" value="<%=programId%>"/>
			<jsp:param name="course_offering_id" value="<%=courseOfferingId%>"/>	
		</jsp:include>
	</div>
<%
}
%>
	
	<%!
public List<String> responseValue(List<QuestionResponse> responses , int questionId)
{
	List<String> responseValues = new ArrayList<String>();
	
	for(QuestionResponse response : responses)
	{
		if(response.getQuestion().getId().intValue() == questionId)
		{
			responseValues.add(response.getResponse());
		}
	}
	return responseValues;
}
%>
