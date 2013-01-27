<%@ page import="java.util.*,java.net.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*, javax.naming.*"%><%
String text = request.getParameter("userid");
if(!HTMLTools.isValid(text))
{
	out.println("Please enter an id to search for");
	return;
}
int programId = HTMLTools.getInt( request.getParameter("program_id"));

TreeMap<String,String>  results = new TreeMap<String,String>();
try
{
	/*results= new TreeMap<String,String>();
	results.put("givenName","Fred");
	results.put("sn","Flintstone");
	if(1 ==2)*/
	results = LdapConnection.instance().getUserData(text);	
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
if(results == null)
{
	out.println("No results found");
}
else
{
	%>
	<script type="text/javascript">
	$('#first_name').val("<%=results.get("givenName")%>");
	$('#last_name').val("<%=results.get("sn")%>");
	
	</script>
	Lookup Completed<%
	
}%>