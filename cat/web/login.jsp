<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*, ca.usask.gmcte.util.*"%> 
<%
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
if (userid != null)
{
	%>You are logged in as <%=userid%>. <a href="javascript:logout();">Log out</a>
	<%
}
else
{
String url = request.getParameter("url");//RequestURI();
if(HTMLTools.isValid(url))
{
	url="?url="+	URLEncoder.encode(url,"UTF-8");
}
else
{
	url="";
}
	%>
	<a href="/cat/auth/login.jsp<%=url%>" target="blank">Log in</a>
<%}
%>