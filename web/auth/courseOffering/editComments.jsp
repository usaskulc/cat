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

if(type!=null)
{
	if (type.equals("teachingMethodComment"))
		type="teaching_comment";
	else if (type.equals("contributionComment"))
		type="contribution_comment";
	else if (type.equals("outcomeComment"))
		type="outcome_comment";
	else
		type="offering_comment";

}
else
	type="offering_comment";

String value = "";
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
	if (type.equals("teaching_comment"))
	{
		value = courseOffering.getTeachingComment();
	}
	else if (type.equals("contribution_comment"))
	{
		value = courseOffering.getContributionComment();
	}
	else if (type.equals("outcome_comment"))
	{
		value = courseOffering.getOutcomeComment();
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

		
