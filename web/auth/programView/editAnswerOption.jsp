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
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int answerSetId = HTMLTools.getInt(request.getParameter("answer_set_id"));
int optionId = HTMLTools.getInt(request.getParameter("option_id"));
String questionType = request.getParameter("question_type");

AnswerOption option = new AnswerOption();
QuestionManager qm = QuestionManager.instance();
%><b>Create/Edit answer Option:</b><br/>
<%
boolean editing = true;
if(optionId < 0)
	editing = false;
else
	option = qm.getAnswerOptionById(optionId);

%>
<br/>
<br/>
	<input type="hidden" name="as_answer_set_id" id="as_answer_set_id" value="<%=answerSetId%>" />
	<input type="hidden" name="as_option_id" id="as_option_id" value="<%=editing?option.getId():-1%>" />
	<input type="hidden" name="as_program_id" id="as_program_id" value="<%=programId%>" />
	<input type="hidden" name="as_question_type" id="as_question_type" value="<%=questionType%>" />
<%
String additionalValues="";
if(answerSetId == -1 && optionId == -1)
{
	int answerSetNameFieldSize= (AnswerSet.class.getMethod("getName")).getAnnotation(Length.class).max();
	%>
	<div class="formElement">
		<div class="label">New Answer Set name (<%=answerSetNameFieldSize%> characters max):</div>
		<div class="field"><input type="text" name="answer_set_name" id="answer_set_name" value="" maxlength="<%=answerSetNameFieldSize%> size="50" /></div>
		<div class="field"><div id="answer_set_nameMessage" class="completeMessage"></div></div>
		<div class="spacer"> </div>
		
	</div>
	<br/>
	<% 
	additionalValues=",'answer_set_name'";
}
int fieldSize= (AnswerOption.class.getMethod("getDisplay")).getAnnotation(Length.class).max();
%>
	<div class="formElement">
		<div class="label">Display (<%=fieldSize%> characters max):</div>
		<div class="field"><input type="text" name="as_display" id="as_display" value="<%=editing?option.getDisplay():""%>" maxlength="<%=fieldSize%>" size="80"/></div>
		<div class="field"><div id="as_displayMessage" class="completeMessage"></div></div>
		<div class="spacer"> </div>
		
	</div>
	<br/>
	
	<div class="formElement">
		<div class="label">Value:</div>
		<div class="field"><input type="text" name="calc_value" id="calc_value" value="<%=editing?option.getValue():"0"%>"/>
		</div>
		<div class="field"><div id="calc_valueMessage" class="completeMessage"></div></div>
		<div class="spacer"> </div>
		
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveOptionButton" id="saveOptionButton" value="Save Answer Option" onclick="saveProgram(new Array('as_answer_set_id','as_program_id','as_option_id','as_display','calc_value','as_question_type'<%=additionalValues%>),new Array('as_answer_set_id','as_program_id','as_option_id','as_display','calc_value','as_question_type'<%=additionalValues%>),'AnswerOption');" /></div>
		<div class="field"><div id="optionMessageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>

