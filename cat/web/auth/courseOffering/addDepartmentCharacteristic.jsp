<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
DepartmentManager dm = DepartmentManager.instance();
Department o = new Department();
boolean departmentLoaded = false;
String id = request.getParameter("id");
if(HTMLTools.isValid(id))
{
	o = dm.getDepartmentById(Integer.parseInt(id));
	departmentLoaded = true;
}

List<CharacteristicType> types = dm.getDepartmentCharacteristicTypes(o);
List<Integer> alreadyUsed = new ArrayList<Integer>();
int maxDisplayIndex = 0;
for(CharacteristicType type: types)
{
	alreadyUsed.add(type.getId());
}

types = dm.getCandidateCharacteristicTypes(alreadyUsed);


for(CharacteristicType type: types)
{

		%><ul><h5><%=type.getName()%> (Associated question:<%=type.getQuestionDisplay()%>)<a href="javascript:addCharacteristicToDepartment(<%=type.getId()%>,<%=o.getId()%>);" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add to Department
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
		