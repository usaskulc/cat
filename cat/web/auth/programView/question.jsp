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
QuestionManager qm = QuestionManager.instance();
String editModeString = request.getParameter("editMode");
String inUseString = request.getParameter("questionInUse");
boolean editMode = editModeString!=null && request.getParameter("editMode").equals("true");
boolean inUse = inUseString!=null && request.getParameter("questionInUse").equals("true");
boolean inLibrary = request.getParameter("inLibrary") !=null && request.getParameter("inLibrary").equals("true");
Question q = qm.getQuestionById(questionId);
String questionType = q.getQuestionType().getName(); //select, radio, checkbox or textarea
LinkProgramQuestion link = qm.getLinkProgramQuestion(programId,questionId);
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
%>
<%=q.getDisplay()%>
 <%if(!inUse || sysadmin){%>
<a href="javascript:loadModify('/cat/auth/programView/editQuestion.jsp?program_id=<%=programId%>&question_id=<%=q.getId()%>');" ><img src="/cat/images/edit_16.gif" alt="Edit question" title="Edit question"></a>
<%
if(inLibrary)
{
	%><a href="javascript:deleteQuestion(<%=programId%>,<%=questionId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove question from library" title="Remove question from library"></a>
 
	<%
}
else
{
	 %>
     <a href="javascript:move(<%=programId%>,'question',<%=link!=null?questionId:-1%>,'','delete');"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove question" title="Remove question"></a>
    <%}
 }
 else {%><img src="/cat/images/deletes.gif" style="opacity:0.4; height:10pt;" alt="Question can't be removed. It has been responded to." title="Question can't be removed. It has been responded to.">
 <%} 
 String answerSetId=q.getAnswerSet()==null?"-1":""+q.getAnswerSet().getId();
	@SuppressWarnings("unchecked")
 List<String> usedAnswerSetIds = (List<String>)session.getAttribute("usedAnswerSetIds");
	inUse = inUse || usedAnswerSetIds.contains(""+answerSetId);

 %><br>
	<div style="padding-left:40px;" id="AnswerSetId_<%=answerSetId%>">
		<jsp:include page="answerSet.jsp">
			<jsp:param name="answer_set_id" value="<%=answerSetId%>"/>
			<jsp:param name="question_type" value="<%=questionType %>"/>
			<jsp:param name="inUse" value="<%=!editMode%>"/>
		</jsp:include>
	</div>
