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

		
