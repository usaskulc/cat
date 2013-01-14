<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*, javax.naming.*"%>
<h3>Search Results:</h3>
<%
String group = request.getParameter("group_name");
int programId = HTMLTools.getInt( request.getParameter("program_id"));
int organizationId = HTMLTools.getInt( request.getParameter("organization_id"));

Collection<String> list = new ArrayList<String>();
try
{
	list = LdapConnection.instance().getOrganizationsContaining(group);
}
catch(SizeLimitExceededException sle)
{
	out.println("Too many search results.  Please enter a more specific Search term");
	return;
}
catch(Exception e)
{
	out.println("Something went REALLY wrong with the search! ["+e.toString()+"]");
	return;
}
%>
<ul>
<%
for(String name : list)
{
	
	
%>
	<li><%=name%>
	<% if(programId < 0 && organizationId < 0)
	{ %>
	
	 <a href="javascript:modifyPermission(<%=programId%>,<%=organizationId%>,'LDAP','<%=name.replaceAll("'","\\\\'")%>','add');" class="smaller">
				Add</a>
	<%}
	else
	{%>
	 <a href="javascript:modifyPermission(<%=programId%>,<%=organizationId%>,'LDAP','<%=name.replaceAll("'","\\\\'")%>','add');" class="smaller">
				Add</a> 
	
	<%
	}%>
	 | <a href="javascript:loadURLIntoId('/cat/auth/modifySystem/ldapGroupMembers.jsp?group_name='+escape('<%=name.replaceAll("'","\\\\'")%>'),'#membersDiv');" class="smaller">Show Members</a>
	
	</li>

<%

}%></ul>
<%
if(list.size() == 0)
{
	out.println("No groups found!");
}
%>
<div id="messageDiv" class="completeMessage"></div>
<br/>
<div id="membersDiv" ></div>
