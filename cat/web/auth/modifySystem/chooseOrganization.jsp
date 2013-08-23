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
