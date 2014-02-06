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
CharacteristicManager cm = CharacteristicManager.instance();
List<CharacteristicType> allTypes = cm.getAllCharacteristicTypes();
%>
<h2>Available characteristics:</h2>
<ul>
<%

for(CharacteristicType type : allTypes)
{
	%>
	
	<li><div id="characteristic_type_<%=type.getId()%>" >
		<jsp:include page="characteristicTypeEdit.jsp" >
			<jsp:param value="<%=type.getId()%>" name="type_id"/>
		</jsp:include>
		</div>
	</li>

	<%
}%>
				<li>
					<a href="javascript:editGenericSystemField('','CharacteristicType','name','adminCharacteristics','adminCharacteristics.jsp');">
					 	Create new characteristic
					</a>
				</li>
</ul>


		
