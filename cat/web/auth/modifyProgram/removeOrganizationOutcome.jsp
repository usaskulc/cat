<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
OrganizationManager manager = OrganizationManager.instance();

String linkId = request.getParameter("link_id");
if(manager.removeOrganizationOutcome(Integer.parseInt(linkId)))
{
	out.println("Outcome removed");
}
else
{
	out.println("ERROR: removing outcome");
}
%>
		