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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,org.hibernate.validator.Length"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
String organizationId = request.getParameter("organization_id");

int outcomeId = HTMLTools.getInt(request.getParameter("outcome_id"));
OutcomeManager om = OutcomeManager.instance();


CourseOffering courseOffering = CourseManager.instance().getCourseOfferingById(Integer.parseInt(courseOfferingId));
Organization organization = OrganizationManager.instance().getOrganizationById(Integer.parseInt(organizationId));

String organizationName = "";
String outcomeParameter = request.getParameter("outcome");
CourseOutcome outcome = null;
boolean editing = false;
if(outcomeId >= 0)
{
	outcome = om.getOutcomeById(outcomeId);
	editing = true;
}
else if(HTMLTools.isValid(outcomeParameter))
{
	outcome = om.getCourseOutcomeByName(outcomeParameter);
}
int maxFieldSize= (CourseOutcome.class.getMethod("getName")).getAnnotation(Length.class).max();
%>
<hr/>
<p>
Type in one course learning outcome then click save. Return to this add outcome window to enter additional outcomes. Each entry may contain no more than <%=maxFieldSize%> characters (less than 10 outcomes recommended).
</p>
<form name="newCourseOfferingOutcomeForm" id="newCourseOfferingOutcomeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="CourseOfferingOutcome"/>
	<input type="hidden" name="course_offering_id" id="course_offering_id" value="<%=courseOfferingId%>"/>
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
	<div class="formElement">
		<div class="label">Outcome:<br/>By the end of this course, students are expected to:</div>
		<div class="field"><textarea cols="60" rows="5" id="outcomeToAdd" name="outcomeToAdd" ><%=editing?outcome.getName():""%></textarea></div>
		<div class="error" id="outcomeToAddMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<%if(editing){
	%>
	<input type="hidden" name="outcome_id" id="outcome_id" value="<%=outcomeId%>"/>
	
	<%}
	
	String parameterString = "";
	List<CharacteristicType> charTypes = organization.getCharacteristicTypes();
	List<Characteristic> outcomeCharacteristics = new ArrayList<Characteristic>();
	if(editing)
	{
		outcomeCharacteristics = om.getCharacteristicsForCourseOfferingOutcome(courseOffering,outcome, organization);
	}
	for(int i=0; i< charTypes.size() ; i++)
	{
		CharacteristicType temp = charTypes.get(i);
		int selectedId = -1;
		for(Characteristic charac: outcomeCharacteristics)
		{
			if(charac.getCharacteristicType().getId() == temp.getId())
				selectedId = charac.getId();
		}
		
		%>
			<jsp:include page="/auth/courseOffering/characteristicType.jsp">
				<jsp:param name="selectedId" value="<%=selectedId%>" />
				<jsp:param name="charTypeId" value="<%=temp.getId()%>"/>
				<jsp:param name="index" value="<%=i%>"/>
			</jsp:include>
		<% 
		parameterString += ",'characteristic_"+i+"','characteristic_type_"+i+"'";
	}
	%>
	
	<input type="hidden" name="char_count" id="char_count" value="<%=charTypes.size()%>"/>
		<div class="formElement">
		<div class="label">
			<input type="button" 
				   name="saveCourseOfferingOutcomeButton" 
				   id="saveCourseOfferingOutcomeButton" 
				   value="Save" 
				   onclick="saveOffering(new Array('outcomeToAdd'),
				   				new Array('outcomeToAdd'<%=parameterString%>,'organization_id','course_offering_id','char_count','outcome_id'),'CourseOfferingOutcome');" />
		</div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>
