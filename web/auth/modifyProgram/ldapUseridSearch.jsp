<%-- 
    Copyright 2012, 2013 University of Saskatchewan

    This file is part of the Curriculum Alignment Tool (CAT).

    CAT is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    CAT is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with CAT.  If not, see <http://www.gnu.org/licenses/>.
--%>


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
