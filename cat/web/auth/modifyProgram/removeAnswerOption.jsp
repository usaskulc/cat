<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
QuestionManager manager = QuestionManager.instance();

int answerOptionId = HTMLTools.getInt(request.getParameter("answer_option_id"));
if(manager.moveAnswerOption(answerOptionId, "delete"))
{
	out.println("Option removed");
}
else
{
	out.println("ERROR: removing option");
}
%>
		