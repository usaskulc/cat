<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<script type="text/javascript">
function ldapUserSearch()
{
	var searchText = $("#ldapText").val();
	var programId = $("#program_id").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifyProgram/ldapNameSearch.jsp?program_id='+programId+'&name='+searchText,'#ldapSearchResults');
}
function addInstructor(nsid)
{
	var programId = $("#program_id").val();
	var courseId = $("#course_id").val();
	
	var courseOfferingId = $("#course_offering_id").val();
	var userid;
	if(nsid == null) //grab nsid from textbox, direct-add
	{
		userid = $("#nsid").val();	
	}
	else // nsid come from ldap search
	{
		userid = nsid;
	}
	editCourseOfferingInstructor('add',userid,programId,courseOfferingId,courseId);
	
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
String departmentParameter = "";
if(access)
{
%>
<div class="formElement">
	<div class="label">Full list Instructor(s):</div>
	<div class="field"><%=cm.getInstructorsString(courseOffering,access,programId)%>
	</div>
	<div class="spacer"> </div>
</div>
	
<div class="formElement">
	<div class="label">Editable Instructor(s):</div>
	<div class="field">
	<%for(LinkCourseOfferingInstructor link: instructorLinks)
	{
		Instructor inst = link.getInstructor();
		%>
		<%=inst.getInstructorDisplay()%> 
		
		<a href="javascript:editCourseOfferingInstructor('delete',<%=link.getId()%>,<%=programId%>,<%=courseOfferingId%>,<%=courseId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove" ></a><br>

	<%}
	%>
	</div>
	<div class="spacer">&nbsp; </div>
</div>
<div class="formElement">
			<div class="label">User-id (NSID):</div>
			<div class="field"> <input type="text" size="6" name="nsid" id="nsid" value=""/> <input type="button" name="savePermissionButton" id="savePermissionButton" value="Add" onclick="addInstructor();" />
			<br/>
			<br/>
			<br/>
			 <input type="text" size="30" name="ldapText" id="ldapText" value=""/> <input type="button" onClick="ldapUserSearch()" value="Last name search"/> 
			</div>
			<div class="error" id="nsidMessage"></div>
			<div class="spacer"> </div>
		</div>
	<div class="spacer"> </div>
	<div id="ldapSearchResults"></div>
	
	</div>
	<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
	<div class="spacer"> </div>
</div>
<%}%>

		