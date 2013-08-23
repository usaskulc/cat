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


<%@ page import="java.util.*,java.net.*,org.apache.log4j.Logger,ca.usask.gmcte.util.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.xml.*,ca.usask.gmcte.currimap.action.*"%>
<%! Logger logger = Logger.getLogger("importCoursesForTerm.jsp"); %>
<h1>DO NOT CLOSE THIS PAGE UNTIL YOU SEE "Completely done"</h1>
<pre>
<%
String term = request.getParameter("term");
out.println("Processing data for "+term+"<br><br>");
DataImporter di = new DataImporter();
DataUpdater du = new DataUpdater();

long start = System.currentTimeMillis(); 
long processStart = start;
List<String> orgs = di.retrieveOrganizations();

out.println("<br>Number of organizations to process: "+orgs.size());
out.flush();

long now = System.currentTimeMillis();

logger.error("It took "+(now-start)+" to retrieve all depts");
start=now;
out.println("<br>update organizations result:"+du.updateOrganizations(orgs));
now = System.currentTimeMillis();
response.flushBuffer();
out.flush();

logger.error("It took "+(now-start)+" to update all depts");
start=now;

for(String dept:orgs)
{
	out.println("<br>Now processing: "+dept);
	out.flush();
	response.flushBuffer();
	List<Course> courses  = di.retrieveCoursesForDepartment(dept,term);
	now = System.currentTimeMillis();
	
	logger.error("It took "+(now-start)+" to retrieve courses for dept " +dept);
	start=now;
	if(courses!=null)
	{
		out.println("<br>Found "+courses.size()+" sections to process...");
		out.flush();
		response.flushBuffer();
		String updateResult = du.updateCourses(courses,dept);
		//System.out.println("Updating courses:"+ updateResult);
		now = System.currentTimeMillis();
		logger.error("It took "+(now-start)+" to update courses for dept " +dept);
		start=now;
		out.println(" done processing.");
		out.flush();
		response.flushBuffer();
	}
	else
	{
		out.println(" No courses found!");
		out.flush();
		response.flushBuffer();
}


now = System.currentTimeMillis();


start=now;
}
logger.error("It took "+(now-processStart)+" to process everything!");
out.println("<br>Completely done !!! ");
out.flush();
response.flushBuffer();

%>
</pre>
