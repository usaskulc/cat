<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*, javax.naming.*"%>
<h3 style="padding-top:10px; padding-bottom:10px;">Search Results:</h3>
<%
String text = request.getParameter("name");
int programId = HTMLTools.getInt( request.getParameter("program_id"));
List<TreeMap<String,String>> results = new ArrayList<TreeMap<String,String>>();
try
{
	/*TreeMap<String,String> result1= new TreeMap<String,String>();
	result1.put("givenName","Fred");
	result1.put("sn","Flintstone");
	result1.put("cn","Freddie Flints");
	result1.put("uid","abx123");
	results.add(result1);
	if(1==2)*/
		results = LdapConnection.instance().searchForUserWithSurname(text);
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
for(TreeMap<String,String> result : results)
{
	%>
	<li><%=result.get("cn")%>
	 <a href="javascript:setFirst('<%=result.get("givenName")%>');setLast('<%=result.get("sn")%>');addInstructor('<%=result.get("uid")%>');" class="smaller">Add</a> 
	</li>

<%

}%></ul>
<%
if(results==null || results.size() == 0)
{
	out.println("No users found with \"" + text + "\" as part of their last name!");
}
%>
