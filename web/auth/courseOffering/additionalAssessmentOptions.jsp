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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
int assessmentMethodLinkId = HTMLTools.getInt(request.getParameter("assessment_link_id"));
LinkCourseOfferingAssessment o = new LinkCourseOfferingAssessment();
CourseOffering courseOffering = new CourseOffering();
CourseManager cm = CourseManager.instance();
boolean editing = false;
if(assessmentMethodLinkId > -1)
{
	o = cm.getLinkAssessmentById(assessmentMethodLinkId);
	editing = true;
}

List<AssessmentFeedbackOptionType> questions = cm.getAssessmentFeedbackQuestions();
List<AssessmentFeedbackOption> selectedOptions = cm.getAssessmentOptionsSelectedForLinkOffering(assessmentMethodLinkId);

TreeMap<String ,AssessmentFeedbackOption> optionIdMapping = new TreeMap<String ,AssessmentFeedbackOption>();
for(AssessmentFeedbackOption selectedOption: selectedOptions )
{
	optionIdMapping.put(""+selectedOption.getId(),selectedOption);
}

for(AssessmentFeedbackOptionType question: questions)
{
%>
			<div class="formElement">
				<div class="label"><%=question.getQuestion()%></div>
				<div class="field">
				<%
				String questionType = question.getQuestionType();
				List<AssessmentFeedbackOption> options = cm.getAssessmentOptionsForQuestion(question.getId());
				if(questionType.equals("checkbox"))
				{
					for(AssessmentFeedbackOption option:options)
					{
						boolean thisOne = optionIdMapping.containsKey(""+option.getId());
						%>
							<input type="checkbox" name="additionalQuestions_<%=question.getId()%>"  id="additionalQuestions_<%=question.getId()%>" <%=thisOne?"checked=\"checked\"":""%> value="<%=option.getId()%>"/><%=option.getName()%><br>
						<%	
					}
				}
				else if(questionType.equals("select"))
				{
					String selected = null;
					for(AssessmentFeedbackOption option:options)
					{
						if( optionIdMapping.containsKey(""+option.getId()))
							selected = ""+option.getId();
					}
					out.println(HTMLTools.createSelect("additionalQuestions_"+question.getId(), options, "Id", "Name", selected, null));
					
				}
				else if(questionType.equals("radio"))
				{
					boolean first = true;
					for(AssessmentFeedbackOption option:options)
					{
						boolean thisOne = (!editing && first)?true:optionIdMapping.containsKey(""+option.getId());
						%>
							<input type="radio" name="additionalQuestions_<%=question.getId()%>"   <%=thisOne?"checked=\"checked\"":""%> value="<%=option.getId()%>"/><%=option.getName()%><br>
						<%	
						first = false;
					}
				}
				
				%>
				</div>
			</div>
			<hr/>
			<br/>
<%
}
%>
