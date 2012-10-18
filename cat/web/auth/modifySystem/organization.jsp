<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
Organization o = new Organization();
OrganizationManager manager = OrganizationManager.instance();
String id = request.getParameter("organization_id");
String parentId = request.getParameter("parent_organization_id");
boolean hasParent = false;
boolean editing = false;
Department department = new Department();
if(id != null  && id.trim().length() > 0)
{
	o = manager.getOrganizationById(Integer.parseInt(id));
	department = o.getDepartment();
	editing = true;
}
if(HTMLTools.isValid(parentId))
{
	hasParent = true;
}
%>
<script type="text/javascript">
function ldapSearch()
{
	var searchText = $("#ldapGroup").val();
	$("#ldapSearchResults").show();
	loadURLIntoId('/cat/auth/modifySystem/ldapGroupSearch.jsp?organization_id=<%=id%>&group_name='+searchText,'#ldapSearchResults');
}

</script>
<h4><%=o.getId() > 0?"Modify":"Create"%> an Organization</h4>
<hr/>
<form name="newObjectForm" id="newObjectForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Organization"/>
	<% if(o.getId() > 0)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<%
		}%>
		<% if(hasParent)
		{
			%><input type="hidden" name="parent_organization_id" id="parent_organization_id" value="<%=parentId%>"/>
			<%
		}%>
	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="50" name="name" id="name" value="<%=o.getName()==null?"":o.getName()%>"/></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">Managing Department:</div>
		<div class="field"> 
		<div id="chooseDepartmentDiv">
			<jsp:include page="chooseDepartment.jsp">
				<jsp:param name="departmentName" value="<%=department.getName()%>" />
			</jsp:include>
		</div>
		<%
			
		
		%>
		</div>
		<div class="error" id="departmentMessage"></div>
		<div class="spacer"> </div>
	</div>
	
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveSystem(new Array('name','department'),new Array('name','department'<%=hasParent?",'parent_organization_id'":""%>),'Organization');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>
<br/>
<div id="addLdapGroupDiv" style="display:none;" class="fake-input">
	<form name="addLdapGroupForm" id="addLdapGroupForm" method="post" action="" >
	
		<div class="formElement" id="ldapDiv">
			<div class="label">Search term:</div>
			<div class="field"> <input type="text" size="60" name="ldapGroup" id="ldapGroup" value=""/> <input type="button" onClick="ldapSearch()" value="Search"/> </div>
			<div class="error" id="nameMessage"></div>
			<div class="spacer"> </div>
		</div>
	</form>
</div>
<div id="ldapSearchResults"></div>

		