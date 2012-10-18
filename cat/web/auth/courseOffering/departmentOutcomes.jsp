<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
DepartmentManager dm = DepartmentManager.instance();
Department o = new Department();
String id = request.getParameter("department_id");
if(id != null  && id.trim().length() > 0)
{
	o = dm.getDepartmentById(Integer.parseInt(id));
}
List<CourseOutcome> allOutcomes = dm.getCourseOutcomesForDepartment(o);
List<String> idsInUse = dm.getUsedCourseOutcomeIdsForDepartment(o);


%>

	<h4>Department specific Outcomes for <%=o.getName()%></h4>
	<hr/>
	<ul>
	<%
	String prevGroup = "";
	boolean first = true;
	for(CourseOutcome outcome : allOutcomes)
	{
		String group = outcome.getGroup().getName();
		
		if(!prevGroup.equals(group))
		{
			if(!first)
			{
				%></ul>
				<%
			}
			else
			{
				first = true;
			}
			%><li><%=group%></li>
				<ul>
		<%
		}
		%><li><%=outcome.getName()%>
		<% if(idsInUse.contains(""+outcome.getId()))
			out.println("(In Use)");
		  else
		  {
			%>
			<a href="javascript:loadModify('/cat/auth/courseOffering/editOutcome.jsp?id=<%=outcome.getId()%>&department_id=<%=id%>');" class="smaller">Edit</a>
			<%
		  }
		%>
		 </li> 
	<%
		prevGroup = group;
	}
	%>
	
	</ul>

		
