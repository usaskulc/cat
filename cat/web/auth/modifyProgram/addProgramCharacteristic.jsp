<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
ProgramManager pm = ProgramManager.instance();
Program o = new Program();
boolean programLoaded = false;
String id = request.getParameter("id");
if(id != null  && id.trim().length() > 0)
{
	o = pm.getProgramById(Integer.parseInt(id));
	programLoaded = true;
}

List<CharacteristicType> types = pm.getProgramCharacteristicTypes(o);
List<Integer> alreadyUsed = new ArrayList<Integer>();
int maxDisplayIndex = 0;
for(CharacteristicType type: types)
{
	alreadyUsed.add(type.getId());
}

types = pm.getCandidateCharacteristicTypes(alreadyUsed);


for(CharacteristicType type: types)
{

		%><ul><h5><%=type.getName()%> (Associated question:<%=type.getQuestionDisplay()%>)<a href="javascript:addCharacteristicToProgram(<%=type.getId()%>,<%=o.getId()%>);" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add to Program
			</a> </h5> 
			<%
			for(Characteristic c : pm.getCharacteristicsForType(type))
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
		