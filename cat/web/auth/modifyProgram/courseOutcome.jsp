<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
String departmentId = request.getParameter("department_id");
String characteristicId = request.getParameter("char_id");
OutcomeManager om = OutcomeManager.instance();
Characteristic characteristic = om.getCharacteristicById(Integer.parseInt(characteristicId));

CourseOffering courseOffering = CourseManager.instance().getCourseOfferingById(Integer.parseInt(courseOfferingId));
Department department = DepartmentManager.instance().getDepartmentById(Integer.parseInt(departmentId));

String programName = "";
String outcomeParameter = request.getParameter("outcome");
CourseOutcome outcome = null;
if(HTMLTools.isValid(outcomeParameter))
{
	outcome = om.getOutcomesByName(outcomeParameter);
}
%>
<script type="text/javascript">

$(document).ready(function() 
{
	$(".error").hide();    	  
});
</script>
Main characteristic : <%=characteristic.getName()%> (<%=characteristic.getDescription()%>)
<hr/>
<form name="newCourseOfferingOutcomeForm" id="newCourseOfferingOutcomeForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="CourseOfferingOutcome"/>
	<input type="hidden" name="course_offering_id" id="course_offering_id" value="<%=courseOfferingId%>"/>
	<input type="hidden" name="department_id" id="department_id" value="<%=departmentId%>"/>
	<input type="hidden" name="char_id" id="char_id" value="<%=characteristicId%>"/>
	<input type="hidden" name="char_type" id="char_type" value="<%=characteristic.getCharacteristicType().getId()%>"/>
	<div class="formElement">
		<div class="label">Outcome:</div>
		<div class="field"> 
		<%
 			List<CourseOutcome> list = om.getOutcomesForDepartment(department);
 				out.println(HTMLTools.createSelectOutcomes("outcomeToAdd", list, outcome!=null?""+outcome.getId():null));
 		%>
		<br>
		<a href="javascript:loadModifyIntoDiv('/cat/auth/department/newOutcome.jsp?department_id=<%=departmentId%>&course_offering_id=<%=courseOfferingId%>&char_id=<%=characteristicId%>','newOutcomeDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add an outcome (the one I need doesn't show up) 
			</a>
		<div id="newOutcomeDiv" class="fake-input" style="display:none;"></div> </div>
		
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
	<%
	String parameterString = "";
	List<CharacteristicType> charTypes = department.getCharacteristicTypes();
	for(int i=1; i< charTypes.size() ; i++)
	{
		CharacteristicType temp = charTypes.get(i);
		%>
			<jsp:include page="/auth/department/characteristicType.jsp">
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
				   value="Add CourseOffering Outcome" 
				   onclick="saveProgram(new Array('outcomeToAdd'),new Array('outcomeToAdd'<%=parameterString%>,'department_id','course_offering_id','char_id','char_type','char_count'),'CourseOfferingOutcome');" />
		</div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		