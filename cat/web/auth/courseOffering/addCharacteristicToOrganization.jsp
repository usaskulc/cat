<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String charId = request.getParameter("charId");
String orgId = request.getParameter("organization_id");

if(!OrganizationManager.instance().addCharacteristicToOrganization(Integer.parseInt(charId), Integer.parseInt(orgId)))
{
	out.println("ERROR: Unable to add Characteristic");
}

%>
		