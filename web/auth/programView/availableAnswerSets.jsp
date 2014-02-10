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
int answerSetId = HTMLTools.getInt(request.getParameter("answer_set_id"));
int programId = HTMLTools.getInt(request.getParameter("program_id"));
String questionType = request.getParameter("question_type");
String inUseString = request.getParameter("inUse");
boolean editable = false;

if(questionType.equals("textarea"))
{ 
	out.println("Open answer");
}	
else
{
	
	
	QuestionManager qm = QuestionManager.instance();
	List<AnswerSet> answerSets = qm.getAllAnswerSets();
	%>
	<table style="border:1px solid black;  border-spacing:0;  padding:5px;">
	<%
	for(AnswerSet set : answerSets)
	{	
		%>
		<tr>
		<td>
		 <input type="button" value="Select this set of answers" onClick="setAnswerSet(<%=programId%>,<%=set.getId()%>,'<%=questionType%>');">
		</td>
		<td>
		<em><%=set.getName()%></em>:<br>
		<%
		if(questionType.equals("select"))
		{ %>
			<div id="answer_set_<%=answerSetId%>" style="border:1px solid grey; width:200px;">
			Select-box containing the options:<br>
		<%}	
		int count = 1;
		
		
		Set<AnswerOption> list = set.getAnswerOptions();
		int lastOne = list.size()-1;
		for(AnswerOption option : list)
		{
			if(questionType.equals("radio"))
			{
				%>
				<input type="radio" name="Question_<%=answerSetId%>" disabled="disabled" value="<%=option.getValue()%>"><%=option.getDisplay()%></input>
				<%
			}
			else if(questionType.equals("checkbox"))
			{
				%>
				<input type="checkbox" name="Question_<%=answerSetId +"_"+option.getId()%>" disabled="disabled" value="<%=option.getValue()%>"><%=option.getDisplay()%></input>
				<%
			}
			else if(questionType.equals("select"))
			{
				%>
				<%=option.getDisplay()%>
				<%
			} 
		
			out.println("<br/>");
			
			
			count++;
		}
		if(questionType.equals("select"))
		{ %>
			</div>
		<%
		}
		%>
			<hr/>
			<td>
		</tr>
	
		<%
	}
	%>
	</table>
	<a href="javascript:editAnswerOption(<%=programId %>,-1,-1,'edit','<%=questionType%>');"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Create new answer set" title="Create new answer set"> Create new answer set</a>

	<%
}
%>
