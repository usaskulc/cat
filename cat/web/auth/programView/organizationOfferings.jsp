<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.model.to.ObjectPair,ca.usask.gmcte.util.*"%> 
<%
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
String id  = request.getParameter("organization_id");
OrganizationManager manager = OrganizationManager.instance();
Organization o = manager.getOrganizationById(Integer.parseInt(id));

List<InstructorAttribute> attributes = OrganizationManager.instance().getInstructorAttributes(o);
boolean hasInstructorAttributes = attributes != null && !attributes.isEmpty();

Organization parent = o.getParentOrganization();
@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(id);

boolean hasParent = parent != null;

%>
<h1><%=o.getName()%></h1>
Completion of data:  (red indicates incomplete)
<br><table>
	<tr><td style="background-color:#33FF00;">&nbsp;</td><td colspan="6">means: some data has been entered.</td></tr>
	<tr><td style="background-color:#CC1111;">&nbsp;</td><td colspan="6">means: NO data has been entered.</td></tr>
	<tr><td colspan="7">&nbsp;</td></tr>
	
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
	%><tr  style="cellpadding:2px; cellspacing:2px;"><td><%=section%> <%=CourseManager.instance().getInstructorsString(offering, false, "-1",hasInstructorAttributes)%></td>
	<%
	for(Boolean b : completion)
	{%>
	<td style="background-color:<%=b?"#33FF00":"#CC1111"%>;">&nbsp;</td>
	<%
	}
	%></tr>
	<%
}
	%>
</table>			