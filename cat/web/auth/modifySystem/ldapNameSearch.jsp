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
	if(1==2)
	*/
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
	 <a href="javascript:setValues('<%=result.get("givenName")%>','<%=result.get("sn")%>','<%=result.get("uid")%>');addPermission();" class="smaller">Add</a> 
	</li>

<%

}%></ul>
<%
if(results==null || results.size() == 0)
{
	out.println("No users found with \"" + text + "\" as part of their last name!");
}
%>
