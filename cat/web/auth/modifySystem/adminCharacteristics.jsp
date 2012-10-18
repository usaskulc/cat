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


		