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
String answer = responseValue(responses, questionId);
%>
<%=q.getDisplay()%>
<%

if(questionType.equals("select"))
{
	List<AnswerOption> options = new ArrayList<AnswerOption>();
	options.addAll(q.getAnswerSet().getAnswerOptions());
	
	out.println(HTMLTools.createSelect(programId + "_" + courseOfferingId + "_" + questionId , options, "value", "display", answer, ""));
}
else if(questionType.equals("textarea"))
{
	%>
	<textarea id="<%=programId%>_<%=courseOfferingId%>_<%=questionId%>" name="<%=programId%>_<%=courseOfferingId%>_<%=questionId%>" cols="40" rows="6"><%=answer%></textarea>
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
public String responseValue(List<QuestionResponse> responses , int questionId)
{
	for(QuestionResponse response : responses)
	{
		if(response.getQuestion().getId().intValue() == questionId)
		{
			return response.getResponse();
		}
	}
	return "";
}
%>