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
String typeId = request.getParameter("type_id");
CharacteristicType type = cm.getCharacteristicTypeById(typeId); 
%>
	<%=type.getName()%>  
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','name','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit characteristic type" alt="Edit characteristic type"/></a>
	Short Display:<%=type.getShortDisplay()%>  
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','shortDisplay','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit characteristic type (short version)" alt="Edit characteristic type (short version)"/></a>
	Question: <%=type.getQuestionDisplay()%> 
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','question','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit question" alt="Edit question"/></a>
				 	
	<a href="javascript:editCharacteristic(<%=type.getId()%>,<%=type.getId()%>,'deleteType','characteristic_type_<%=type.getId()%>');"><img src="/cat/images/deletes.gif" title="Delete Characteristic type" alt="Delete characteristic type" title="Delete characteristic type"/></a>
		<%if(type.getValueType().equals("NOT SET"))
			{
			%>
			<br/>
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','AnswerType','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');" class="smaller">
				 Set answer Type
		    </a>
		    "boolean" for <b>yes or no</b> questions, "text" for all others
			<%
			}
			else
			{
			%>			
					
					
		<ul>
			<%
			List<Characteristic> characteristics = cm.getCharacteristicsForType(type);
			for(int i = 0 ; i < characteristics.size() ; i++ )
			{
				Characteristic ch = characteristics.get(i);%>
				<li><span title="<%=ch.getDescription()%>"><%=ch.getName()%></span> <a href="javascript:editGenericSystemField(<%=ch.getId()%>,'Characteristic','name','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit characteristic value" alt="Edit characteristic value"/></a>
				<%
				if(i>0)
				{%>
					<a href="javascript:editCharacteristic(<%=ch.getId()%>,<%=type.getId()%>,'up','#characteristic_type_<%=type.getId()%>');"><img src="/cat/images/up2.gif"  alt="move up" title="move up"/></a><%
				}
				if(i < characteristics.size()-1)
				{%>
					<a href="javascript:editCharacteristic(<%=ch.getId()%>,<%=type.getId()%>,'down','#characteristic_type_<%=type.getId()%>');"><img src="/cat/images/down2.gif"  alt="move down" title="move down"/></a><%
				}%>
					 <a href="javascript:editGenericSystemField(<%=ch.getId()%>,'Characteristic','description','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');" class="smaller"><img src="/cat/images/edit_16.gif"  title="Edit Description" alt="Edit Description"/>Edit description</a>
				
					<a href="javascript:editCharacteristic(<%=ch.getId()%>,<%=type.getId()%>,'delete','#characteristic_type_<%=type.getId()%>');"><img src="/cat/images/deletes.gif"  alt="Delete characteristic" title="Delete characteristic"/></a>
					
				</li><%
			}
			if(!type.getValueType().equals("Boolean"))
			{%>
				<li>
					<a href="javascript:editGenericSystemField('','Characteristic','name','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>','part_of_id=<%=type.getId()%>');" class="smaller">
					 	<img src="/cat/images/add_24.gif"  height="10px;" title="Add Characteristic" alt="Add option" title="Add option"/> Add option
					</a>
				</li>
				<%}
			%>
			</ul>
			<%
			
			
			}
			%>
			
		


		
