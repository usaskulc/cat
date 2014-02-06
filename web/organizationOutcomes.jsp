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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;

@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(""+organizationId);

OrganizationManager om = OrganizationManager.instance();

Organization organization = om.getOrganizationById(organizationId);
List<LinkOrganizationOrganizationOutcome> links = om.getLinkOrganizationOrganizationOutcomeForOrg(organization);
%>
<h5>Organization Outcomes</h5>
<ul>
<%
String prevGroup = "";
boolean first = true;
for(LinkOrganizationOrganizationOutcome link : links)
{
	OrganizationOutcome o = link.getOrganizationOutcome();
	String groupName = o.getGroup().getName();
	if(!groupName.equals(prevGroup))
	{
		if(first)
		{
			first = false;
		}
		else
		{
			%>
				</ul>
			<%
		}
		%>
		<li><strong><%=groupName%></strong></li><ul style="padding-left:15px;line-height:1.0em;">
		<%
	}
	%>
	
	<li><%=o.getName()%> <%=HTMLTools.addBracketsIfNotNull(o.getDescription())%>
	 <%if(access){%><a href="javascript:removeOrganizationOutcome(<%=organization.getId()%>,<%=link.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove organization outcome" title="Remove organization outcome" ></a><%} %>
	</li>
	<% 
	prevGroup = groupName;
}


if(!links.isEmpty())
{
	%>
	</ul>
	<%
}
else
{
	out.println("No outcomes added (yet).");
}
if(access)
{
%>
	<li>	<a href="javascript:loadModify('/cat/auth/modifyProgram/organizationOutcome.jsp?organization_id=<%=organization.getId()%>');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add outcome" title="Add outcome"/>
				Add an outcome
			</a>
	</li>
<%} %>
</ul>
