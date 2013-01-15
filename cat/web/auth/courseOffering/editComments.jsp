<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id") ;

@SuppressWarnings("unchecked")
HashMap<String,CourseOffering> userHasAccessToOfferings = (HashMap<String,CourseOffering>)session.getAttribute("userHasAccessToOfferings");

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin || (userHasAccessToOfferings!=null && userHasAccessToOfferings.containsKey(courseOfferingId));
CourseOffering courseOffering = new CourseOffering();
CourseManager cm = CourseManager.instance();
OrganizationManager dm = OrganizationManager.instance();
OutcomeManager om = OutcomeManager.instance();
String type = request.getParameter("type");
if(type!=null && type.equals("teachingMethodComment"))
{
		type="teaching_comment";
}
else
{
		type="offering_comment";
}
String value = "";
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
	if (type.equals("teaching_comment"))
	{
		value = courseOffering.getTeachingComment();
	}
	else
	{
		value = courseOffering.getComments();
	}
}

%>
<form>
	<input type="hidden" name="course_offering_id" id="course_offering_id" value="<%=courseOfferingId%>"/>
	<input type="hidden" name="commentType" id="commentType" value="<%=type%>"/>
	<div class="formElement">
		<div class="label">Additional Information:</div>
		<div class="field"> <textarea name="comments" id="comments" cols="40" rows="6"><%=value==null?"":value%></textarea></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveOffering(new Array(),new Array('comments','course_offering_id','commentType'),'CourseOfferingComments');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		