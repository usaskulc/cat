<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<h1 style="color:red;">CAUTION! This process puts a heavy load on several systems! Only import at the end of a term, and only do it once per term!</h1>
<%
CourseManager manager = CourseManager.instance();

List<String> options = new ArrayList<String>();
List<String> displayOptions = new ArrayList<String>();
String[] monthOptions = {"01","05","07","09"};
Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
for(int i=(year-3) ; i <= year; i++)
{
	for(String month : monthOptions)
	{
		String term = i+month;
		options.add(term);
		int existingCount = manager.getOfferingCountForTerm(term);
		String display = term;
		if(existingCount > 0)
		{
			display += " (" + existingCount+ " sections already exist)";
		}
		displayOptions.add(display);
		
	}
}
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");


%>
<form action="importCoursesForTerm.jsp" method="POST">
<%=HTMLTools.createSelect("term", options, displayOptions, null,null)%>
<br>
<input type="submit" value="Import Coures for selected term"/>
</form>