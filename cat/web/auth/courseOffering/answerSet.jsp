<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
int answerSetId = HTMLTools.getInt(request.getParameter("answer_set_id"));
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
int questionId = HTMLTools.getInt(request.getParameter("question_id"));
int programId = HTMLTools.getInt(request.getParameter("program_id"));

String questionType = request.getParameter("question_type");
@SuppressWarnings("unchecked")
List<QuestionResponse> responses = (List<QuestionResponse>) session.getAttribute("programQuestionResponses");
List<String> answers = responseValue(responses, questionId);
QuestionManager qm = QuestionManager.instance();

AnswerSet set = qm.getAnswerSetById(answerSetId);
	
	
Set<AnswerOption> list = set.getAnswerOptions();
for(AnswerOption option : list)
{
		
	%>
	<input type="<%=questionType %>" name="<%=programId%>_<%=courseOfferingId%>_<%=questionId%>"  value="<%=option.getValue()%>"   <%=answerIndicator(answers,option.getValue()) %> /><%=option.getDisplay()%><br/>
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

public String answerIndicator(List<String> answerValues, String optionValue)
{
	if(answerValues == null || answerValues.isEmpty())
		return "";

	for(String answerValue:answerValues)
	{
		if(answerValue.trim().equals(optionValue)) 
		{
			return "checked=\"checked\"";
		}
	}
	return "";
}

%>
