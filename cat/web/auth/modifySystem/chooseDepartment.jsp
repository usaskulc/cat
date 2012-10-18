<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger"%>
<%!private static Logger logger = Logger.getLogger("/auth/courseOffering/index.jsp");%>
<%
Department department = new Department();
String departmentName = request.getParameter("departmentName");
boolean departmentKnown = false;
if(HTMLTools.isValid(departmentName))
{
	department = DepartmentManager.instance().getDepartmentByName(departmentName);	
	departmentKnown = true;
}

List<Department> options = DepartmentManager.instance().getAllDepartments();
List<String> ids = new ArrayList<String>();
List<String> values = new ArrayList<String>();
for(Department d: options)
{
	ids.add(""+d.getId());
	values.add(d.getName());
	
}
out.println(HTMLTools.createSelect("department", ids, values, departmentKnown?""+department.getId():null, null));
%>