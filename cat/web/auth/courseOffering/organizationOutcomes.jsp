<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
OrganizationManager dm = OrganizationManager.instance();
Organization o = new Organization();
String id = request.getParameter("organization_id");
if(id != null  && id.trim().length() > 0)
{
	o = dm.getOrganizationById(Integer.parseInt(id));
}
List<CourseOutcome> allOutcomes = dm.getCourseOutcomesForOrganization(o);
List<String> idsInUse = dm.getUsedCourseOutcomeIdsForOrganization(o);


%>

	<h4>Organization specific Outcomes for <%=o.getName()%></h4>
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
			<a href="javascript:loadModify('/cat/auth/courseOffering/editOutcome.jsp?id=<%=outcome.getId()%>&organization_id=<%=id%>');" class="smaller">Edit</a>
			<%
		  }
		%>
		 </li> 
	<%
		prevGroup = group;
	}
	%>
	
	</ul>

		
