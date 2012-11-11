<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int departmentId = HTMLTools.getInt(request.getParameter("department_id")) ;

Department dept = new Department();
boolean editing = false;
if(departmentId > 0)
{
	dept  = DepartmentManager.instance().getDepartmentById(departmentId);
	editing = true;
}
%>
<p>
A department can have 2 different names. The system-name is used for dynamic lookup.  If data is loaded from an external system, this is the alternate name that can ube used to identify the department.
</p>
<form name="newCourseForm" id="newCourseForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Department"/>
	<% if(editing)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=dept.getId()%>"/>
			<%
		}
		%>
	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="40" maxlength="100" name="name" id="name" value="<%=editing?dept.getName():""%>" /></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label">System Name:</div>
		<div class="field"> <input type="text" size="40"  maxlength="100" name="system_name" id="system_name" value="<%=editing?dept.getLdapName():""%>"/></div>
		<div class="error" id="system_nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save Department" onclick="saveSystem(new Array('name'),new Array('name','system_name'));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

<% if(editing)
{
	%>
	<p>Choose a subject for which you want to add/remove the home-department for this department.
	</p>
	<div id="assignCoursesDiv">
	<jsp:include page="existingCourseSelector.jsp">
		<jsp:param name="department_id" value="<%=departmentId%>" />
	</jsp:include>
	
	</div>
	
		<%
}
		%>		