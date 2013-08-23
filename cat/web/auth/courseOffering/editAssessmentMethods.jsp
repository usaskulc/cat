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
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
int linkId = HTMLTools.getInt(request.getParameter("assessment_link_id"));
boolean editing = false;
LinkCourseOfferingAssessment link = new LinkCourseOfferingAssessment();
String requiredParameters = "'assessmentMethod',";
if(linkId > -1)
{
	link = cm.getLinkCourseOfferingAssessmentById(linkId);
	editing = true;
	requiredParameters += "'assessment_link_id',";
}

%>
<div>
<div id="addAssessmentMethodDiv"  class="fake-input">
	<form name="addAssessmentMethodForm" id="assessmentMethodForm" method="post" action="" >
			<input type="hidden" name="objectClass" id="objectClass" value="LinkCourseOfferingAssessmentMethod"/>
			<input type="hidden" name="course_offering_id" id="course_offering_id" value="<%=courseOfferingId%>"/>
			<%if(editing){ %>
			<input type="hidden" name="assessment_link_id" id="assessment_link_id" value="<%=linkId%>"/>
			<%} %>
			
			<div class="formElement">
				<div class="label">Select the format that best describes your assessment method:</div>
				<div class="field">
					<div id="availableAssessmentMethods">
						<jsp:include page="/auth/courseOffering/availableAssessmentMethods.jsp">
							<jsp:param name="assessment_link_id" value="<%=linkId%>" />
						</jsp:include>
					</div>
				</div>
			</div>
			<hr/>
			<div class="formElement">
				<div class="label">Add any additional information<br/> about your assessment method here:</div>
				<div class="field"> <textarea name="additional_info" id="additional_info" cols="40" rows="2"><%=editing?(link.getAdditionalInfo()==null?"":link.getAdditionalInfo()):""%></textarea></div>
				<div class="spacer"> </div>
			</div>
			<hr/>
			<div class="formElement">
				<div class="label">% of total mark :</div>
				<div class="field">
					<input type="text" name="assessmentWeight" id="assessmentWeight" size="10" value="<%=editing?""+link.getWeight():"0.0"%>"/>
				</div>
			</div>
			<hr/>
			
			<div class="formElement">
				<div class="label">Due/occur:</div>
				<div class="field">
				<%=HTMLTools.createSelect( "when", cm.getAssessmentTimeOptions(), "Id", "Name", editing?""+link.getWhen().getId():null, null)%>
				</div>
			</div>
			
						<hr/>
			<jsp:include page="additionalAssessmentOptions.jsp">
				<jsp:param name="assessment_link_id" value="<%=linkId%>" />
			</jsp:include>
	
			<hr/>
		
		
		
		
		
		
		
			
			<div class="formElement">
			<p>If a specific mark is required on this assignment or students must complete this assignment to pass the course or continue in the program, then complete the following questions. If not, scroll down to press save, then close.</p>
				<div class="label">Students must meet a criterion on this course-work to pass or proceed in the program/course:</div>
				<div class="field">
						<input type="radio" name="criterion_exists" <%=editing?(link.getCriterionExists().equalsIgnoreCase("N")?"checked=\"checked\"":""):"checked=\"checked\"" %> value="N"> Not applicable<br/>
						<input type="radio" name="criterion_exists" <%=editing?(link.getCriterionExists().equalsIgnoreCase("Y")?"checked=\"checked\"":""):"" %> value="Y"> yes
				</div>
			</div>
			<hr/>
			
			<div class="formElement">
				<div class="label"> % Criterion that must be met (if applicable):</div>
				<div class="field">
					<input type="text" name="criterion_level" id="criterion_level" size="10" value="<%=editing?""+link.getCriterionLevel():"0.0"%>"/>
				</div>
			</div>
			<hr/>
				
				
			<div class="formElement">
				<div class="label">Students must submit/attempt this course-work to pass or proceed in the program/course:</div>
				<div class="field">
						<input type="radio" name="criterion_submitted" <%=editing?(link.getCriterionSubmitted().equalsIgnoreCase("N")?"checked=\"checked\"":""):"checked=\"checked\"" %> value="N"> No<br/>
						<input type="radio" name="criterion_submitted" <%=editing?(link.getCriterionCompleted().equalsIgnoreCase("Y")?"checked=\"checked\"":""):"" %> value="Y"> Yes
				</div>
			</div>
			<hr/>
			<div class="formElement">
			<div class="label">Students must complete this course-work to pass or proceed in the program/course:</div>
				<div class="field">
						<input type="radio" name="criterion_completed" <%=editing?(link.getCriterionCompleted().equalsIgnoreCase("N")?"checked=\"checked\"":""):"checked=\"checked\"" %> value="N"> No<br/>
						<input type="radio" name="criterion_completed" <%=editing?(link.getCriterionCompleted().equalsIgnoreCase("Y")?"checked=\"checked\"":""):"" %> value="Y"> Yes
				</div>
			</div>
			
			<hr/>
			<div class="formElement">
			<div class="label"><input type="button" name="saveLinkCourseOfferingAssessmentMethodButton" id="saveLinkCourseOfferingAssessmentMethodButton" value="Save" 
						onclick="saveOffering(new Array(<%=requiredParameters%>'assessmentWeight','when'),new Array(<%=requiredParameters%>'assessmentWeight','when','additional_info','course_offering_id','criterion_level'),'LinkCourseOfferingAssessmentMethod');" /></div>
			<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
			<div class="spacer"> </div>
		</div>
	</form>
</div>
</div>

