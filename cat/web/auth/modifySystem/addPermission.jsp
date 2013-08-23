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


<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
int programId = HTMLTools.getInt(request.getParameter("program_id"));
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));

PermissionsManager manager = PermissionsManager.instance();
boolean includeLdap = PermissionsManager.ldapEnabled;
%>
<script type="text/javascript">
<%if(includeLdap)
{%>
function ldapSearch()
{
	var searchText = $("#ldapGroup").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifySystem/ldapGroupSearch.jsp?program_id=<%=programId%>&organization_id=<%=organizationId%>&group_name='+searchText,'#ldapSearchResults');
}
function ldapUserSearch()
{
	var searchText = $("#ldapText").val();
	var programId = $("#program_id").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifySystem/ldapNameSearch.jsp?name='+searchText,'#ldapSearchResults');
}
function setValues(first,last,userid)
{
	$("#first_name").val(first);
	$("#last_name").val(last);
	$("#userid").val(userid);
}

function ldapUserLookup()
{
	var searchText = $("#userid").val();
	var programId = $("#program_id").val();
	$('#useridMessage').show();
	loadURLIntoId('/cat/auth/modifySystem/ldapUseridSearch.jsp?userid='+searchText,'#useridMessage');
}
<%}%>
function addPermission()
{
	if(checkRequired(new Array('userid')) )
	{
		var userid = $("#userid").val();
		var first = $("#first_name").val();
		var last = $("#last_name").val();
		modifyPermission(<%=programId%>,<%=organizationId%>,'Userid',userid,first,last,'add');
	}
	
}
			</script>
<h2>Add a Person:</h2>

<form name="newCourseOfferingForm" id="newCourseOfferingForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="ProgramAdmin"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
	<input type="hidden" name="type" value="Userid"/>
	<br/>

    <div class="formElement">
		<div class="label">Userid:</div>
		<div class="field"> <input type="text" size="40" name="userid" id="userid" value=""/> 
		<%if(PermissionsManager.ldapEnabled){ %><input type="button" value="Look up First and Last name" onClick="ldapUserLookup();"/>
	<%}%> </div>
		<div class="error" id="useridMessage"></div>
		<div class="spacer"> </div>
	</div>
			
			
	<div class="formElement">
		<div class="label">first name:</div>
		<div class="field"> <input type="text" size="50" name="first_name" id="first_name" value=""/></div>
		<div class="error" id="system_nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<div class="formElement">
		<div class="label">last name:</div>
		<div class="field"> <input type="text" size="50" name="last_name" id="last_name" value=""/></div>
		<div class="error" id="system_nameMessage"></div>
		<div class="spacer"> </div>
	</div>
			<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="savePermissionButton" id="savePermissionButton" value="Add" onclick="addPermission();" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
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
		</div>
	</div>
		
</form>

<div id="ldapSearchResults"></div>

