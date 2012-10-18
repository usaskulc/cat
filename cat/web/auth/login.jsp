<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*"%> 
<%
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
String url = request.getParameter("url");
if(url==null || url.indexOf("null") > -1)
{
	url="/cat";
}
url="/cat/auth/myCourses.jsp";
if (userid != null)
{
	%>You are now logged in. You can close this window (if it doesn't automatically close for you).
	<script  type="text/javascript">
	function reloadAndClose()
	{
		var opener = window.opener;
		if(opener != null) //IE doesn't seem to like this
		{
			opener.parent.location="<%=url%>";
		}
		else
		{
			opener.opener.parent.location="<%=url%>";
		//	window.opener.parent.updateLoginStatus();
			
		}
		
//		window.opener.parent.updateLoginStatus();
		window.close();
	}
	setTimeout("reloadAndClose()",2000);
	//window.opener.parent.document.getElementById("loginStatus").innerHtml="Logged in";
	</script>
	
<iframe style="width:1px;height:1px" src="/cat/auth/department/loginCheck.jsp"></iframe>
	<%
}
else
{%>
	Well, I don't know how you did it.  You're seeing a protected page without proper credentials!
<%}
%>