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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
OrganizationManager dm = OrganizationManager.instance();
Organization o = new Organization();
boolean organizationLoaded = false;
String id = request.getParameter("id");
if(HTMLTools.isValid(id))
{
	o = dm.getOrganizationById(Integer.parseInt(id));
	organizationLoaded = true;
}

List<CharacteristicType> types = dm.getOrganizationCharacteristicTypes(o);
List<Integer> alreadyUsed = new ArrayList<Integer>();
int maxDisplayIndex = 0;
for(CharacteristicType type: types)
{
	alreadyUsed.add(type.getId());
}

types = dm.getCandidateCharacteristicTypes(alreadyUsed);


for(CharacteristicType type: types)
{

		%><ul><h5><%=type.getName()%> (Associated question:<%=type.getQuestionDisplay()%>)<a href="javascript:addCharacteristicToOrganization(<%=type.getId()%>,<%=o.getId()%>);" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add to organization" title="Add to organization"/>
				Add to organization
			</a> </h5> 
			<%
			for(Characteristic c : dm.getCharacteristicsForType(type))
			{
				%>
				<li><%=c.getName()%>(<%=c.getDescription()%>)</li>
				<%
			}
			%>
			</ul>
		<%

	
}
if(types.isEmpty())
{
	out.println("No more characteristic types to add");
}
%>
		
