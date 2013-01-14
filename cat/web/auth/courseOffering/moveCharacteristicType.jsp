<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String charTypeId = request.getParameter("charTypeId");
String organizationId = request.getParameter("organization_id");
String direction = request.getParameter("direction");

if(!OrganizationManager.instance().moveCharacteristicType(Integer.parseInt(organizationId), Integer.parseInt(charTypeId),direction))
{
	out.println("ERROR: Unable to move Characteristic Type "+direction);
}

%>
		