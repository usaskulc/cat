<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>


<p>
<strong>Thank you for completing the sections</strong>
<br/>
<br/>
How long did it take to enter all the data?	
</p>

<%
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id"));
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(courseOfferingId);
List<TimeItTook> options = cm.getTimeItTookOptions();
TimeItTook currentValue = courseOffering.getTimeItTook();
String currentValueId = currentValue==null?"":""+currentValue.getId();

%>
<form>
<input type="hidden" name="objectClass" id="objectClass" value="TimeItTook"/>
	<input type="hidden" name="course_offering_id" id="course_offering_id" value="<%=courseOfferingId%>"/>

<%=HTMLTools.createSelect("timeItTookOptionId", options, "id", "name", currentValueId, "") %>

		<div class="formElement">
			<div class="label">
			<input type="button" 
				   name="saveCourseOfferingTimeItTookButton" 
				   id="saveCourseOfferingTimeItTookButton" 
				   value="Save" 
				   onclick="saveOffering(new Array('timeItTookOptionId'),
				   				new Array('timeItTookOptionId','course_offering_id'));" />
		</div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>
<hr/>