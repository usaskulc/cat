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
<script type="text/javascript">
function ldapUserSearch()
{
	var searchText = $("#ldapText").val();
	var programId = $("#program_id").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifyProgram/ldapNameSearch.jsp?program_id='+programId+'&name='+searchText,'#ldapSearchResults');
}

function ldapUserLookup()
{
	var searchText = $("#userid").val();
	var programId = $("#program_id").val();
	$('#useridMessage').show();
	loadURLIntoId('/cat/auth/modifyProgram/ldapUseridSearch.jsp?program_id='+programId+'&userid='+searchText,'#useridMessage');
}
function setFirst(value)
{
	$("#first_name").val(value);
}
function setLast(value)
{
	$("#last_name").val(value);
}
function addInstructor(nsid)
{
	var programId = $("#program_id").val();
	var courseId = $("#course_id").val();
	var first = $("#first_name").val();
	var last = $("#last_name").val();
	
	var courseOfferingId = $("#course_offering_id").val();
	var userid;
	if(nsid == null) //grab nsid from textbox, direct-add
	{
		userid = $("#userid").val();	
	}
	else // nsid come from ldap search
	{
		userid = nsid;
	}
	editCourseOfferingInstructor('add',userid,programId,courseOfferingId,courseId,first,last);
	
}
</script>

<%
int courseOfferingId = HTMLTools.getInt(request.getParameter("course_offering_id")) ;
int courseId = HTMLTools.getInt(request.getParameter("course_id"));
String programId = request.getParameter("program_id") ;
CourseManager cm = CourseManager.instance();

CourseOffering courseOffering = cm.getCourseOfferingById(courseOfferingId);

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin;
if(HTMLTools.isValid(programId))
{
	Organization organization = OrganizationManager.instance().getOrganizationByProgramId(programId);	

	@SuppressWarnings("unchecked")
	HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
	access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organization.getId());
}

//only show this if the user is a sysadmin, or the home dept is null (new course)
List<LinkCourseOfferingInstructor> instructorLinks = cm.getCourseOfferingInstructors(courseOfferingId);
String organizationParameter = "";
if(access)
{
%>
<div class="formElement">
	<div class="label">Editable Instructor(s):</div>
	<div class="field">
	<%for(LinkCourseOfferingInstructor link: instructorLinks)
	{
		Instructor inst = link.getInstructor();
		%>
		<%=inst.getInstructorDisplay()%> 
		
		<a href="javascript:editCourseOfferingInstructor('delete',<%=link.getId()%>,<%=programId%>,<%=courseOfferingId%>,<%=courseId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove Instructor" title="Remove Instructor"></a><br>

	<%}
	%>
	</div>
	<div class="spacer">&nbsp; </div>
</div>
<div class="formElement">
	<div class="label">Userid:</div>
	<div class="field"> <input type="text" size="10" name="userid" id="userid" value=""/>
	<%if(PermissionsManager.ldapEnabled){ %><input type="button" value="Look up First and Last name" onClick="ldapUserLookup();"/>
	<%}%> 
	
	</div>
	<div class="error" id="useridMessage"></div>
	<div class="spacer"> </div>
</div>
<div class="formElement">
	<div class="label">first name:</div>
	<div class="field"> <input type="text" size="50" name="first_name" id="first_name" value=""/></div>
	<div class="error" id="first_nameMessage"></div>
	<div class="spacer"> </div>
</div>
<div class="formElement">
	<div class="label">last name:</div>
	<div class="field"> <input type="text" size="50" name="last_name" id="last_name" value=""/></div>
	<div class="error" id="last_nameMessage"></div>
	<div class="spacer"> </div>
</div>
	
			
<div class="formElement">
		<div class="label">	
			<input type="button" name="savePermissionButton" id="savePermissionButton" value="Add" onclick="addInstructor();" />
		</div>
</div>

			<br/>
			<br/>
			<br/>
<div class="formElement">
	<div class="field">	
<%if(PermissionsManager.ldapEnabled){ %>		
	
			 <input type="text" size="30" name="ldapText" id="ldapText" value=""/> <input type="button" onClick="ldapUserSearch()" value="Last name search"/> 
			 
			 <%}%>
		 
	</div>
	<div class="error" id="nsidMessage"></div>
	<div class="spacer"> </div>
	<div id="ldapSearchResults"></div>
	
	<div class="spacer"> </div>
	<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
	<div class="spacer"> </div>
</div>
<%}%>

		
