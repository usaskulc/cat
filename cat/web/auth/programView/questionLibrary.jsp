<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>

<table >
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
Program program = ProgramManager.instance().getProgramById(programId);
QuestionManager qm = QuestionManager.instance();
List<String> uneditableQuestions = qm.getAllQuestionIdsUsedInProgramsOtherThan(programId); 

List<Question> availableQuestions = qm.getAllQuestionsNotUsedByProgram(program);
for(Question question:availableQuestions)
{
	%>
		<tr>
			<td>
				<input type="button" name="addQuestion<%=question.getId()%>Button" id="addQuestion<%=question.getId()%>Button" value="Add this question" onclick="addQuestionToProgram(<%=question.getId()%>,<%=programId%>);" />
			</td>
			<td><%=uneditableQuestions.contains(""+question.getId())?"<span style=\"color:red;\">Question cannot be edited or removed, as it is in use by another program</span><br/>":"" %>
				<jsp:include page="question.jsp">
					<jsp:param name="question_id" value="<%=question.getId()%>"/>
					<jsp:param name="questionInUse" value="<%=uneditableQuestions.contains(String.valueOf(question.getId()))%>"/>	
					<jsp:param name="editMode" value="false"/>
					<jsp:param name="inLibrary" value="true"/>
					<jsp:param name="program_id" value="<%=programId%>"/>
				</jsp:include>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr/></td>
		</tr>
		<% 
}
%>
</table>
