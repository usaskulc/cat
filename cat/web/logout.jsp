<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*"%> 
<%
session.removeAttribute("edu.yale.its.tp.cas.client.filter.user");

session.removeAttribute("userIsSysadmin");
session.removeAttribute("userHasAccessToOfferings");
session.removeAttribute("userHasAccessToPrograms");
session.removeAttribute("userHasAccessToOrganizations");

session.removeAttribute("sessionInitialized");
session.removeAttribute("JSESSIONID");
//session.invalidate();


%>
<script  type="text/javascript">
//setTimeout("window.opener.parent.updateLoginStatusAfterlogout();",2000);
window.opener.parent.updateLoginStatusAfterlogout();
document.location="https://cas.usask.ca/cas/logout;"
</script>
