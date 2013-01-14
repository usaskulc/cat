<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger"%>
<%!private static Logger logger = Logger.getLogger("/auth/courseOffering/index.jsp");%>
<%
Organization organization = new Organization();
String organizationName = request.getParameter("organizationName");
boolean organizationKnown = false;
if(HTMLTools.isValid(organizationName))
{
	organization = OrganizationManager.instance().getOrganizationByName(organizationName);	
	organizationKnown = true;
}

List<Organization> options = OrganizationManager.instance().getAllOrganizations(false);
List<String> ids = new ArrayList<String>();
List<String> values = new ArrayList<String>();
for(Organization d: options)
{
	ids.add(""+d.getId());
	values.add(d.getName());
	
}
out.println(HTMLTools.createSelect("organization", ids, values, organizationKnown?""+organization.getId():null, null));
%>