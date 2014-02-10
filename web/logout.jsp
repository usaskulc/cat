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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*"%> 
<%
session.removeAttribute("edu.yale.its.tp.cas.client.filter.user");

session.removeAttribute("userIsSysadmin");
session.removeAttribute("userHasAccessToOfferings");
session.removeAttribute("userHasAccessToOrganizations");
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
