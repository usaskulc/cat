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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
OrganizationManager dm = OrganizationManager.instance();
Organization o = new Organization();
String id = request.getParameter("organization_id");
if(id != null  && id.trim().length() > 0)
{
	o = dm.getOrganizationById(Integer.parseInt(id));
}
%>

	<h4>Setting up Characteristics for <%=o.getName()%></h4>
	<hr/>
	<input type="hidden" name="objectClass" id="objectClass" value="ProgramCharacteristic"/>
	<div id="characteristicsList">
	<%
	List<CharacteristicType> types = dm.getOrganizationCharacteristicTypes(o);
	for(int i = 0 ; i < types.size() ; i++ )
	{
		if(i==0)
		{
			%><h3>Main characteristic:</h3> <%
		}
		else if(i==1)
		{
			%><h3>Additional characteristics:</h3> <%
		}
		CharacteristicType cType = types.get(i);
		%><ul><h5><%=cType.getName()%> (Associated question:<%=cType.getQuestionDisplay()%>)
		<%if(i>0)
		{%>
			<a href="javascript:moveCharacteristicType(<%=o.getId()%>,<%=cType.getId()%>,'up');">
				<img src="/cat/images/up2.gif"  alt="Move Up"/>
			</a>
		<%}
		if(i < types.size()-1)
		{%>
			<a href="javascript:moveCharacteristicType(<%=o.getId()%>,<%=cType.getId()%>,'down');">
				<img src="/cat/images/down2.gif"  alt="Move Down"/>
			</a>
		<%}
		%>
		<a href="javascript:moveCharacteristicType(<%=o.getId()%>,<%=cType.getId()%>,'delete');">
				<img src="/cat/images/del.gif"  alt="Move Up"/>
			</a>
		</h5> 
			<%
			for(Characteristic c : dm.getCharacteristicsForType(cType))
			{
				%>
				<li><%=c.getName()%> <%=(c.getDescription()!=null && c.getDescription().length()>0)?"("+c.getDescription()+")":""%></li>
				<%
			}
			%>
			</ul>
			<hr/>
		<%
	}
	%>
	<a href="javascript:loadModify('/cat/auth/courseOffering/addOrganizationCharacteristic.jsp?id=<%=o.getId()%>','addCharacteristicToOrganizationDiv','organizationCharacteristicsDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add a characteristic" title="Add a characteristic" />
				Add a Characteristic
			</a>
			<div id="addCharacteristicToOrganizationDiv">
			</div>
	</div>

		
