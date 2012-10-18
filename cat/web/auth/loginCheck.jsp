<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*,org.apache.log4j.Logger"%> 
<%!Logger logger = Logger.getLogger("loginCheck.jsp"); %> 
<%
logger.debug("Loaded auth/loginCheck.jsp");
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
if (userid != null)
{
	%>
	<script  type="text/javascript">
	parent.updateLoginStatus();
	</script>
	<%
}

%>