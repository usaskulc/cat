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
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"/>
				Add to Organization
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
		