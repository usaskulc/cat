<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.ObjectPair,ca.usask.gmcte.util.*"%> 
<%
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
String id  = request.getParameter("organization_id");
OrganizationManager manager = OrganizationManager.instance();
Organization o = manager.getOrganizationById(Integer.parseInt(id));
Organization parent = o.getParentOrganization();
@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(id);

boolean hasParent = parent != null;

%>
<h1><%=o.getName()%></h1>
Completion of data:  (red indicates incomplete)
<br>
<table>
	<tr><th>Section</th>
	<th>Instruction<br/>Methods</th>
	<th>Assessment<br/>Methods</th>
	<th>Learning<br/>Outcomes</th>
	<th>Assessment<br/>Links</th>
	<th>Contributions<br/>to Program Outcomes</th>
	<th>Outcome links<br/>to Program Outcomes</th>
	</tr>
	<%
TreeMap<String, ObjectPair> records = manager.getOrganizationOfferings(o);
for(String section : records.keySet())
{
	CourseOffering offering = (CourseOffering)records.get(section).getA();
	
	Boolean[] completion = (Boolean[])records.get(section).getB();
	%><tr><td><%=section%> <%=CourseManager.instance().getInstructorsString(offering, false, "-1")%></td>
	<%
	for(Boolean b : completion)
	{%>
	<td style="background-color:<%=b?"green":"red"%>;">&nbsp;</td>
	<%
	}
	%></tr>
	<%
}
	%>
</table>			