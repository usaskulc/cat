<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
DepartmentManager dm = DepartmentManager.instance();
Department o = new Department();
String id = request.getParameter("department_id");
if(id != null  && id.trim().length() > 0)
{
	o = dm.getDepartmentById(Integer.parseInt(id));
}
%>

	<h4>Setting up Characteristics for <%=o.getName()%></h4>
	<hr/>
	<input type="hidden" name="objectClass" id="objectClass" value="ProgramCharacteristic"/>
	<div id="characteristicsList">
	<%
	List<CharacteristicType> types = dm.getDepartmentCharacteristicTypes(o);
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
	<a href="javascript:loadModify('/cat/auth/courseOffering/addDepartmentCharacteristic.jsp?id=<%=o.getId()%>','addCharacteristicToDepartmentDiv','departmentCharacteristicsDiv');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add a Characteristic
			</a>
			<div id="addCharacteristicToDepartmentDiv">
			</div>
	</div>

		