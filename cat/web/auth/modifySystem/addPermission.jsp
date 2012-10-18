<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));

PermissionsManager manager = PermissionsManager.instance();
%>
<script type="text/javascript">
function swapDivs()
{
	var ldapRadio = $("#radioLDAP");
	var useridRadio = $("#radioUserid");
	if(ldapRadio.is(":checked"))
	{
		$("#useridDiv").hide();
		$("#ldapSearchResults").html("");
		$("#ldapDiv").show();
	}
	if(useridRadio.is(":checked"))
	{
		$("#useridDiv").show();
		$("#ldapDiv").hide();
		$("#ldapSearchResults").html("");
		$("#ldapSearchResults").hide();
	}
}
function ldapSearch()
{
	var searchText = $("#ldapGroup").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifySystem/ldapGroupSearch.jsp?program_id=<%=programId%>&organization_id=<%=organizationId%>&group_name='+searchText,'#ldapSearchResults');
}
function ldapUserSearch()
{
	var searchText = $("#ldapText").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifySystem/ldapNameSearch.jsp?program_id=<%=programId%>&organization_id=<%=organizationId%>&name='+searchText,'#ldapSearchResults');
}
function addPermission()
{
	if(checkRequired(new Array('nsid')) )
	{
		var userid = $("#nsid").val();
		modifyPermission(<%=programId%>,<%=organizationId%>,'Userid',userid,'add');
	}
	
}
			</script>
<h2>Add Department or Person:</h2>

<form name="newCourseOfferingForm" id="newCourseOfferingForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="ProgramAdmin"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
	<div class="formElement">
		<div class="label">Type:</div>
		<div class="field"> <input type="radio" name="type" value="LDAP" id="radioLDAP" checked="checked" onClick="swapDivs();"/> Department name<br/> 
							<input type="radio" name="type" value="Userid" id="radioUserid" onClick="swapDivs();"/> Person (search by last-name or user-id (NSID) )</div>
		<div class="error" id="subjectMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div id="useridDiv" style="display:none;">
		
		<div class="formElement">
			<div class="label">User-id (NSID):</div>
			<div class="field"> <input type="text" size="6" name="nsid" id="nsid" value=""/> <input type="button" name="savePermissionButton" id="savePermissionButton" value="Add" onclick="addPermission();" />
			<br/>
			<br/>
			<br/>
			
			
			 <input type="text" size="30" name="ldapText" id="ldapText" value=""/> <input type="button" onClick="ldapUserSearch()" value="Last name search"/> 
			</div>
			<div class="error" id="nsidMessage"></div>
			<div class="spacer"> </div>
		</div>
	</div>
		
	<div class="formElement" id="ldapDiv">
		<div class="label">Search (part of dept. name):</div>
		<div class="field"> <input type="text" size="60" name="ldapGroup" id="ldapGroup" value=""/> <input type="button" onClick="ldapSearch()" value="Search"/> </div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
</form>

<div id="ldapSearchResults"></div>

