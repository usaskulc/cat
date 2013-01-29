<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int organizationId = HTMLTools.getInt(request.getParameter("organization_id")) ;

Organization o = new Organization();
boolean editing = false;
if(organizationId > 0)
{
	o  = OrganizationManager.instance().getOrganizationById(organizationId);
	editing = true;
}
String parentId = request.getParameter("parent_organization_id");
boolean hasParent = false;
if(HTMLTools.isValid(parentId))
{
	hasParent = true;
}
%>
<p>
A organization can have 2 different names. The system-name is used for association of courses with organizations dynamically. 
 If data is loaded from an external system, this is the alternate name that can be used to identify the organization.
</p>
<form name="newCourseForm" id="newCourseForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Organization"/>
	<% if(editing)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<%
		}
	if(hasParent)
	{
		%><input type="hidden" name="parent_organization_id" id="parent_organization_id" value="<%=parentId%>"/>
		<%
	}
		%>
	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="40" maxlength="100" name="name" id="name" value="<%=editing?o.getName():""%>" /></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	
	
	<br/>
	<div class="formElement">
		<div class="label">System Name:</div>
		<div class="field"> <input type="text" size="50" name="system_name" id="system_name" value="<%=o.getSystemName()==null?"":o.getSystemName()%>"/></div>
		<div class="error" id="system_nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	
		<div class="formElement">
		<div class="label">Active:</div>
		<div class="field">	<input type="radio" name="active"   <%=o.getActive() == null || o.getActive().equals("Y")?"checked=\"checked\"":""%> value="Y"/> Yes<br>
							<input type="radio" name="active"   <%=o.getActive()!= null && o.getActive().equals("N")?"checked=\"checked\"":""%> value="N"/> No<br>
		</div>
		<div class="error" id="activeMessage"></div>
		<div class="spacer"> </div>
	</div>
	
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save Organization" onclick="saveSystem(new Array('name'),new Array('name','system_name','active','parent_organization_id'));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

<% if(editing)
{
	%>
	<p>Choose a subject for which you want to add/remove the home-organization.
	</p>
	<div id="assignCoursesDiv">
	<jsp:include page="existingCourseSelector.jsp">
		<jsp:param name="organization_id" value="<%=organizationId%>" />
	</jsp:include>
	
	</div>
	
		<%
}
		%>		