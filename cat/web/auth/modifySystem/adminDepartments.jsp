<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
Department department = new Department();
String departmentName = request.getParameter("departmentName");
boolean departmentKnown = false;
if(HTMLTools.isValid(departmentName))
{
	department = DepartmentManager.instance().getDepartmentByName(departmentName);	
	departmentKnown = true;
}
List<Department> departments =  DepartmentManager.instance().getAllDepartments();
Department choose = new Department();
choose.setName("Please select a department to edit");
choose.setId(0);
departments.add(0,choose);
%>
Select a department from the list below (to edit a department) (or click "create new" to create a new department)


<form name="genericFieldForm" id="genericFieldForm" method="post" action="" >
	
	<div class="formElement">
		<div class="label">Department:</div>
		<div class="field">
			<%=HTMLTools.createSelect("department", departments, "id", "name", departmentKnown?""+department.getId():null, "editDepartment('department');")%>
		</div>
		<div class="error" id="new_valueMessage" style="padding-left:10px;"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button"
		           value="Create new" 
				   onclick="editDepartment();" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	
	</form>

