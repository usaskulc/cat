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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,org.hibernate.validator.Length"%>
<form>
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
Program program = ProgramManager.instance().getProgramById(programId);
QuestionManager qm = QuestionManager.instance();
int questionId = HTMLTools.getInt(request.getParameter("question_id"));
int fieldSize= (Question.class.getMethod("getDisplay")).getAnnotation(Length.class).max();
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


	<input type="hidden" name="answer_set_id" id="answer_set_id" value="<%=(editing && q.getAnswerSet()!=null) ? ""+q.getAnswerSet().getId() : "-1"%>" />

	<input type="hidden" name="question_id" id="question_id" value="<%=editing?q.getId():"-1"%>" />
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>" />

	<div class="formElement">
		<div class="label">Question display (<%=fieldSize%> characters max):</div>
		<div class="field"><input type="text" name="display" id="display" size="80" maxlength="<%=fieldSize%>" value="<%=editing?q.getDisplay():""%>"/></div>
		<div class="field"><div id="displayMessage" class="completeMessage"></div></div>
		<div class="spacer"> </div>
		
	</div>
	<br/>
	
	<div class="formElement">
		<div class="label">Question type:</div>
		<div class="field"><%=HTMLTools.createSelect("question_type", types, "name", "description", editing?""+q.getQuestionType().getName():null, "setQuestionType("+programId+");")%>
		</div>
		<div class="field"><div id="question_typeMessage" class="completeMessage"></div></div>
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

