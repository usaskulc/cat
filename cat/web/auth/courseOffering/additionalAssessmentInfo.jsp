<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>



	
<%
String courseOfferingId = request.getParameter("course_offering_id");
int linkId = HTMLTools.getInt(request.getParameter("link_id"));
LinkCourseOfferingAssessment o = new LinkCourseOfferingAssessment();
CourseManager cm = CourseManager.instance();
if(linkId > -1)
{
	o = cm.getLinkAssessmentById(linkId);
}
List<AssessmentFeedbackOptionType> questions = cm.getAssessmentFeedbackQuestions();
List<AssessmentFeedbackOption> selectedOptions = cm.getAssessmentOptionsSelectedForLinkOffering(linkId);

TreeMap<String ,AssessmentFeedbackOption> optionIdMapping = new TreeMap<String ,AssessmentFeedbackOption>();
for(AssessmentFeedbackOption selectedOption: selectedOptions )
{
	optionIdMapping.put(""+selectedOption.getId(),selectedOption);
}
%>

<a href="javascript:hideDiv('additionalAssessmentInfo_<%=linkId%>')" class="smaller">hide</a>

<table>
	<tr>
		<th>Question</th>
		<th>Answer</th>
	</tr>

<%
for(AssessmentFeedbackOptionType question: questions)
{
%>
	<tr>
		<td><%=question.getQuestion()%></td>
		<td>
				<%
				String questionType = question.getQuestionType();
				List<AssessmentFeedbackOption> options = cm.getAssessmentOptionsForQuestion(question.getId());
				for(AssessmentFeedbackOption option:options)
				{
					if(optionIdMapping.containsKey(""+option.getId()))
					{
						%>
						<%=optionIdMapping.get(""+option.getId()).getName() %>
						<br>
						<%
					}
				}
							
				%>
		</td>
	</tr>
<%
}
%>
</table>