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


<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
String group = request.getParameter("group_name");
List<String> list = LdapConnection.instance().getDirectDeptEmployees(group);
TreeMap<String,TreeMap<String,String>> dataList =  LdapConnection.instance().getUserData(list);
%>
<h3>Members of <%=group%></h3>
<ul>
<%
for(TreeMap<String,String> data:dataList.values())
{
%>
	<li><%=data.get("cn")%></li>

<%
}%></ul>
<%
if(list.size() == 0)
{
	out.println("No members found!");
}
%>
