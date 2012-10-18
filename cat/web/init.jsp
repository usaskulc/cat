<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*"%> 
<%
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
if (userid != null)
{
	%>You are logged in as <%=userid%>. <a href="/cat/logout.jsp">Log out</a>
	<%
}
else
{%>
	<a href="/cat/login.jsp">Log in</a>
<%}
%>