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
