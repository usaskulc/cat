<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<form>
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
Program program = ProgramManager.instance().getProgramById(programId);
QuestionManager qm = QuestionManager.instance();
int questionId = HTMLTools.getInt(request.getParameter("question_id"));

if(questionId < 0)
{
	%>
	<div id="questionLibraryDiv">
		<jsp:include page="questionLibrary.jsp"/>
	</div>
	<input type="hidden" name="list_shown" id="list_shown" value="yes"/>
	<%
}

%><h3>Create/Edit question:</h3><br/>
<%
String inUseString = request.getParameter("inUse");
boolean inUse = inUseString!=null && request.getParameter("inUse").equals("true");
Question q = qm.getQuestionById(questionId);
boolean editing = true;
if(questionId < 0)
	editing = false;


List<QuestionType> types = qm.getQuestionTypes();
QuestionType noType = new QuestionType();
noType.setId(-1);
noType.setDescription("Please select a question type");
noType.setName("");
types.add(0,noType);

%>


	<input type="hidden" name="answer_set_id" id="answer_set_id" value="<%=editing?q.getAnswerSet().getId():"-1"%>" />

	<input type="hidden" name="question_id" id="question_id" value="<%=editing?q.getId():"-1"%>" />
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>" />

	<div class="formElement">
		<div class="label">Question display:</div>
		<div class="field"><input type="text" name="display" id="display" value="<%=editing?q.getDisplay():""%>"/></div>
		<div class="field"><div id="displayMessage" class="completeMessage"></div></div>
		<div class="spacer"> </div>
		
	</div>
	<br/>
	
	<div class="formElement">
		<div class="label">Question type:</div>
		<div class="field"><%=HTMLTools.createSelect("question_type", types, "name", "description", editing?""+q.getQuestionType().getId():null, "setQuestionType("+programId+");")%>
		</div>
		<div class="field"><div id="question_type_idMessage" class="completeMessage"></div></div>
		<div class="spacer"> </div>
		
	</div>
	<br/>
	
	<div class="formElement">
		<div class="label">Answer set:</div>
		<div class="field">
			<div id="AnswerSetDiv">
			<%if(editing)
			{%>
				<jsp:include page="answerSet.jsp">
					<jsp:param name="answer_set_id" value="<%=q.getAnswerSet()!=null?q.getAnswerSet().getId():-1%>"/>
					<jsp:param name="question_type" value="<%=q.getQuestionType().getName()%>"/>
					<jsp:param name="program_id" value="<%=programId%>"/>
					<jsp:param name="inUse" value="<%=inUse%>"/>
					<jsp:param name="editMode" value="true"/>
					
				</jsp:include>
			<%}
			else
			{
				out.println("Once you have selected a question-type, you will be able to determine what the available answers will be.");
			}
			%>
			<div class="field"><div id="answer_set_idMessage" class="completeMessage"></div></div>
			</div>
		</div>
		<div class="spacer"> </div>
	</div>
	
	
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveProgram(new Array('display','program_id','question_type','question_id'),new Array('display','program_id','question_type','answer_set_id','question_id'),'ProgramQuestion');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	
	<div class="field" id="EditAnswerSetDiv">
	</div>

	
</form>

