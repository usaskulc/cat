<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
CourseManager manager = CourseManager.instance();
String programId = request.getParameter("program_id");

int instructorAttributeValueId = HTMLTools.getInt(request.getParameter("attribute_value_id"));
int instructorAttributeId = HTMLTools.getInt(request.getParameter("attribute_id"));
int courseId = HTMLTools.getInt(request.getParameter("course_id"));

String userid = request.getParameter("userid");
boolean editing = instructorAttributeValueId > -1;
InstructorAttributeValue value = new InstructorAttributeValue();
InstructorAttribute attribute = new InstructorAttribute();
if(editing)
{
	value = manager.getInstructorAttributeValueById(instructorAttributeValueId);
	attribute = value.getAttribute();
}
else
{
	attribute = manager.getInstructorAttributeById(instructorAttributeId);
}

%>
<form name="newCourseOfferingOutcomeForm" id="newCourseOfferingOutcomeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="InstructorAttributeValue"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<input type="hidden" name="course_id" id="course_id" value="<%=courseId%>"/>
	<input type="hidden" name="attribute_id" id="attribute_id" value="<%=attribute.getId()%>"/>
	<%if(editing){%>
		<input type="hidden" name="attribute_value_id" id="attribute_value_id" value="<%=value.getId()%>"/>
	<%}%>
	<input type="hidden" name="userid" id="userid" value="<%=userid%>"/>
	<div class="formElement">
		<div class="label"><%=attribute.getName()%> value:</div>
		<div class="field"> 
			<input type="text" value="<%=editing?value.getValue():""%>" id="value" name="value">
		</div>
		
		<div class="error" id="valueMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
		<div class="formElement">
		<div class="label">
			<input type="button" 
				   name="saveButton" 
				   id="saveButton" 
				   value="Save <%=attribute.getName()%>" 
				   onclick="saveProgram(new Array('value'),new Array('value', 'program_id','userid','attribute_id','attribute_value_id'),'InstructorAttributeValue');" />
		</div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>
