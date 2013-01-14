<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
CourseManager cm = CourseManager.instance();
CourseOffering 	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
List<Organization> organizations = cm.getOrganizationForCourseOffering(courseOffering);
if(organizations!= null && organizations.size() > 1)
{	
%>
<h1>Course offering appears to be associated with multiple organizations! </h1>
<%
	
}
Organization organization = organizations.get(0);
String courseOfferingField="";
String courseOfferingParam="";
if(HTMLTools.isValid(courseOfferingId))
{
	courseOfferingField="<input type=\"hidden\" name=\"course_offering_id\" id=\"course_offering_id\" value=\""+courseOfferingId+"\"/>";
	courseOfferingParam=",'course_offering_id'";
}

String charId = request.getParameter("char_id");
String charField="";
String charParam="";
if(HTMLTools.isValid(charId))
{
	charField="<input type=\"hidden\" name=\"char_id\" id=\"char_id\" value=\""+charId+"\"/>";
	charParam=",'char_id'";
}
%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>
<div id="newOutComeFormDiv">
<form name="newOutcomeForm" id="newOutcomeForm" method="post" action="" >
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organization.getId()%>"/>
	<%=courseOfferingField %>
	<%=charField%>
	<div class="formElement">
		<div class="label">Outcome (short):</div>
		<div class="field"> <input type="text" size="80" value="" id="newOutcomeName" /></div>
		<div class="error" id="newOutcomeNameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br>
	<div class="formElement">
		<div class="label">This outcome is specific to courses offered by <%=organization.getName()%>:</div>
		<div class="field"> <input type="checkbox"  value="true" id="newOutcomeOrganizationSpecific" /></div>
		<div class="error" id="newOutcomeOrganizationSpecificMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br>
	<div class="formElement">
		<div class="label"><input type="button" name="saveNewOutcomeButton" id="saveNewOutcomeButton" value="Add New Outcome" onclick="saveOffering(new Array('newOutcomeName'),new Array('newOutcomeName','organization_id','newOutcomeOrganizationSpecific'<%=courseOfferingParam%><%=charParam%>),'NewCourseOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>
</div>


		