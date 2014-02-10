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
int programId = HTMLTools.getInt(request.getParameter("program_id"));
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
if(programId > -1)
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(""+programId);	
	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}
if(!access)
{
	out.println("You don't appear to have the proper access to manage questions for this program.");
	return;
}
QuestionManager qm = QuestionManager.instance();
List<String> usedAnswerSetIds = qm.getAllAnswerSetIdsWithResponses();
session.setAttribute("usedAnswerSetIds",usedAnswerSetIds);


Program o = ProgramManager.instance().getProgramById(programId);
List<Question> questionLinks = qm.getAllQuestionsForProgram(o);

%>
<ul>
	<li>	<a href="javascript:loadModify('/cat/auth/programView/editQuestion.jsp?program_id=<%=programId%>&question_id=-1');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add/create/edit a question" title="Add/create/edit a question"/>
				Add/create/edit a question
			</a>
	</li>
<%
int questionCount=1;
List<Question> withAnswers = qm.getAllQuestionsWithResponsesForProgram(o);
int lastQuestion = questionLinks.size() - 1;
for(Question q : questionLinks)
{
	%><li><%
	String questionType = q.getQuestionType().getName(); //select, radio, checkbox or textarea
	if(questionCount>1)
	{%>
	<a href="javascript:move(<%=programId%>,'question',<%=q.getId()%>,<%=o.getId()%>,'up');"><img src="/cat/images/up2.gif"  alt="move up" title="move up"/></a>
	<%}
	else
	{
		%>
		<img src="/cat/images/blankbox.gif"  style="width:10px; height:15px;" alt=" "/>
		<%
	}
	if(questionCount <= lastQuestion)
	{%>
	<a href="javascript:move(<%=programId %>,'question',<%=q.getId()%>,<%=o.getId()%>,'down');"><img src="/cat/images/down2.gif"  alt="move down" title="move down"/></a>
	<%}
	else
	{
		%>
		<img src="/cat/images/blankbox.gif"  style="width:10px; height:15px;" alt=" "/>
		<%
	}
	
	%>
	<jsp:include page="question.jsp">
			<jsp:param name="question_id" value="<%=q.getId()%>"/>
			<jsp:param name="questionInUse" value="<%=isUsed(withAnswers, q)%>"/>	
			<jsp:param name="editMode" value="false"/>
			<jsp:param name="program_id" value="<%=programId%>"/>
				
		</jsp:include>
	</li>
	<% 
	questionCount++;
}
if(questionLinks.isEmpty())
{
	out.println("No questions added (yet).");
}
%>
</ul>

<%!
public boolean isUsed(List<Question> list, Question q)
{
	for(Question inList: list)
	{
		if(inList.getId() == q.getId())
			return true;
	}
	return false;
}

%>
