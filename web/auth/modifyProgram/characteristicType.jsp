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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String charTypeId = request.getParameter("charTypeId");
String index = request.getParameter("index");
int selectedId = HTMLTools.getInt(request.getParameter("selectedId"));
Characteristic charac = new Characteristic();
OutcomeManager om = OutcomeManager.instance();
if(selectedId > -1)
{
	charac = om.getCharacteristicById(selectedId);
}

CharacteristicType ct = om.getCharacteristicTypeById(charTypeId);
%>
	<div class="formElement">
		<div class="label"><%=ct.getQuestionDisplay()%></div>
		<div class="field">
		<%
		String valueType = ct.getValueType();
		List<Characteristic> options =  om.getCharacteristicsForType(ct);
		if(valueType.equals("String"))
		{
			out.println(HTMLTools.createSelect("characteristic_"+index,options,"Id","Name", selectedId> -1?""+selectedId: null, null));
		}
		if(valueType.equals("Boolean"))
		{
			String checked = selectedId > -1 && charac.getName().equals("true")?"checked=\"checked\"":"";
			//Make it a checkbox
			%><input type="checkbox" name="characteristic_<%=index %>" id="characteristic_<%=index %>" <%=checked%>/>
			<% 
		}
		%>
			<input type="hidden" id="characteristic_type_<%=index%>" name="characteristic_type_<%=index%>" value="<%=ct.getId()%>"/>
		</div>
		<div class="error" id="characteristic_<%=index %>Message"></div>
		<div class="spacer"> </div>
	</div>
	<hr/>
		
