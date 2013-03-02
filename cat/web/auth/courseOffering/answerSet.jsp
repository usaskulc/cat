<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
int answerSetId = HTMLTools.getInt(request.getParameter("answer_set_id"));
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
int questionId = HTMLTools.getInt(request.getParameter("question_id"));
int programId = HTMLTools.getInt(request.getParameter("program_id"));

String questionType = request.getParameter("question_type");
@SuppressWarnings("unchecked")
List<QuestionResponse> responses = (List<QuestionResponse>) session.getAttribute("programQuestionResponses");
String answer = responseValue(responses, questionId);
QuestionManager qm = QuestionManager.instance();

AnswerSet set = qm.getAnswerSetById(answerSetId);
	
	
Set<AnswerOption> list = set.getAnswerOptions();
for(AnswerOption option : list)
{
		
	%>
	<input type="<%=questionType %>" name="<%=programId%>_<%=courseOfferingId%>_<%=questionId%>"  value="<%=option.getValue()%>"   <%=answerIndicator(answer,option.getValue()) %> /><%=option.getDisplay()%><br/>
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

public String answerIndicator(String answerValue, String optionValue)
{
	if(answerValue == null)
		return "";

	if(answerValue.trim().equals(optionValue))
	{
		return "checked=\"checked\"";
	}
	return "";
}

%>
