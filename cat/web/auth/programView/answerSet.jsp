<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
int answerSetId = HTMLTools.getInt(request.getParameter("answer_set_id"));
String questionType = request.getParameter("question_type");
String inUseString = request.getParameter("inUse");
String programId = request.getParameter("program_id");
boolean editable = inUseString==null || inUseString.equals("false");
String editModeString = request.getParameter("editMode");
boolean editMode = editModeString!=null && editModeString.equals("true");
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
QuestionManager qm = QuestionManager.instance();

@SuppressWarnings("unchecked")
List<String> usedAnswerSetIds = (List<String>)session.getAttribute("usedAnswerSetIds");
boolean inUse = usedAnswerSetIds.contains(""+answerSetId);
editable = (!inUse && editable && editMode) || (sysadmin && editMode);
if(questionType.equals("textarea"))
{
	%>
	Open answer
	<%
}
else
{
	AnswerSet set = null;
	if (answerSetId < 0)
	{
		 set = qm.getAnswerSetByName(request.getParameter("answer_set_id"));
		 answerSetId = set.getId();
	}
    else
	  	 set = qm.getAnswerSetById(answerSetId);
	if(questionType.equals("select"))
	{ %>
		<div id="Question<%=answerSetId%>" style="border:1px solid grey; width:200px;">
	<%}	
	int count = 1;
	
	
	Set<AnswerOption> list = set.getAnswerOptions();
	int lastOne = list.size()-1;
	for(AnswerOption option : list)
	{
		
		if(editable)
		{
			if(count>1)
			{%>
			<a href="javascript:move(<%=programId %>,'answerOption',<%=option.getId()%>,'<%=questionType%>','up',<%=answerSetId%>);"><img src="/cat/images/up2.gif"  alt="move up" title="move up"/></a>
			<%}
			else
			{
				%>
				<img src="/cat/images/blankbox.gif"  style="width:10px; height:15px;" alt=" "/>
				<%
			}
			if(count <= lastOne)
			{%>
			<a href="javascript:move(<%=programId %>,'answerOption',<%=option.getId()%>,'<%=questionType%>','down',<%=answerSetId%>);"><img src="/cat/images/down2.gif"  alt="move down" title="move down"/></a>
			<%}
			else
			{
				%>
				<img src="/cat/images/blankbox.gif"  style="width:10px; height:15px;" alt=" "/>
				<%
			}
		}
	
		if(questionType.equals("radio"))
		{
			%>
			<input type="radio" name="Question_<%=answerSetId%>" disabled="disabled" value="<%=option.getValue()%>"><%=option.getDisplay()%> <span style="opacity:0.4;">(<%=option.getValue()%>)</span></input>
			<%
		}
		else if(questionType.equals("checkbox"))
		{
			%>
			<input type="checkbox" name="Question_<%=answerSetId +"_"+option.getId()%>" disabled="disabled" value="<%=option.getValue()%>"><%=option.getDisplay()%> <span style="opacity:0.4;">(<%=option.getValue()%>)</span></input>
			<%
		}
		else if(questionType.equals("select"))
		{
			%>
			<%=option.getDisplay()%> <span style="opacity:0.4;">(<%=option.getValue()%>)</span>
			<%
		} 
		if(editable)
		{
			%>
			<a href="javascript:editAnswerOption(<%=programId %>,<%=answerSetId%>,<%=option.getId() %>,'edit','<%=questionType%>');"><img src="/cat/images/edit_16.gif" alt="Edit answer option" title="Edit answer option"></a>
			<a href="javascript:editAnswerOption(<%=programId %>,<%=answerSetId%>,<%=option.getId() %>,'delete','<%=questionType%>');"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove answer option" title="Remove answer option"></a>
			<% 
		}
		out.println("<br/>");
		
		
		count++;
	}
	if(questionType.equals("select"))
	{ %>
		</div>
	<%}
	if(editable)
	{
	%>
	<a href="javascript:editAnswerOption(<%=programId%>,<%=answerSetId%>,-1,'edit','<%=questionType%>');"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add answer option" title="Add answer option"> Add answer option</a>

	<%}
}
%>
