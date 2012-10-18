<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String charId = request.getParameter("charId");
String departmentId = request.getParameter("department_id");

if(!DepartmentManager.instance().addCharacteristicToDepartment(Integer.parseInt(charId), Integer.parseInt(departmentId)))
{
	out.println("ERROR: Unable to add Characteristic");
}

%>
		