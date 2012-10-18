<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
CharacteristicManager cm = CharacteristicManager.instance();
String typeId = request.getParameter("type_id");
CharacteristicType type = cm.getCharacteristicTypeById(typeId); 
%>
	<%=type.getName()%>  
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','name','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit Name" alt="Edit Name"/></a>
	Short Display:<%=type.getShortDisplay()%>  
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','shortDisplay','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit Short Display" alt="Edit Short Dsiplay"/></a>
	Question: <%=type.getQuestionDisplay()%> 
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','question','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit Question" alt="Edit Question"/></a>
				 	
	<a href="javascript:editCharacteristic(<%=type.getId()%>,<%=type.getId()%>,'deleteType','characteristic_type_<%=type.getId()%>');"><img src="/cat/images/deletes.gif" title="Delete Characteristic type" alt="Delete"/></a>
		<%if(type.getValueType().equals("NOT SET"))
			{
			%>
			<br/>
			<a href="javascript:editGenericSystemField(<%=type.getId()%>,'CharacteristicType','AnswerType','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');" class="smaller">
				 Set answer Type
		    </a>
		    "boolean" for yes or no questions, "text" for all others
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
				<li><span title="<%=ch.getDescription()%>"><%=ch.getName()%></span> <a href="javascript:editGenericSystemField(<%=ch.getId()%>,'Characteristic','name','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit Name" alt="Edit Name"/></a>
				<%
				if(i>0)
				{%>
					<a href="javascript:editCharacteristic(<%=ch.getId()%>,<%=type.getId()%>,'up','#characteristic_type_<%=type.getId()%>');"><img src="/cat/images/up2.gif"  alt="Move Up"/></a><%
				}
				if(i < characteristics.size()-1)
				{%>
					<a href="javascript:editCharacteristic(<%=ch.getId()%>,<%=type.getId()%>,'down','#characteristic_type_<%=type.getId()%>');"><img src="/cat/images/down2.gif"  alt="Move Down"/></a><%
				}%>
					 <a href="javascript:editGenericSystemField(<%=ch.getId()%>,'Characteristic','description','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>');" class="smaller"><img src="/cat/images/edit_16.gif"  title="Edit Description" alt="Edit Description"/>edit description</a>
				
					<a href="javascript:editCharacteristic(<%=ch.getId()%>,<%=type.getId()%>,'delete','#characteristic_type_<%=type.getId()%>');"><img src="/cat/images/deletes.gif"  alt="Delete"/></a>
					
				</li><%
			}
			if(!type.getValueType().equals("Boolean"))
			{%>
				<li>
					<a href="javascript:editGenericSystemField('','Characteristic','name','characteristic_type_<%=type.getId()%>','characteristicTypeEdit.jsp?type_id=<%=type.getId()%>','part_of_id=<%=type.getId()%>');" class="smaller">
					 	<img src="/cat/images/add_24.gif"  height="10px;" title="Add Characteristic" alt="Add"/> Add option
					</a>
				</li>
				<%}
			%>
			</ul>
			<%
			
			
			}
			%>
			
		


		