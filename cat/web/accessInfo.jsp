<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<%
Boolean sessionInitialized = (Boolean)session.getAttribute("sessionInitialized");

if(sessionInitialized !=null && sessionInitialized)
{
	out.println("session initialized!");
	Boolean userIsSysadmin = (Boolean)		session.getAttribute("userIsSysadmin");
	if(userIsSysadmin!=null && userIsSysadmin)
	{
		out.println("SYSADMIN access to everything!");
	}
	else
	{
		
		HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
		if(userHasAccessToOrganizations==null)
		{
			out.println("userHasAccessToOrganizations NULL!!!");
		}
		else
		{
			out.println("<hr/>Organizations: <ul>");
			
			for(String key : userHasAccessToOrganizations.keySet())
			{
				out.println("<li>"+key+" "+userHasAccessToOrganizations.get(key).getName()+"</li>");
			}
			out.println("</ul>");
		}
		HashMap<String,CourseOffering>  userHasAccessToOfferings = (HashMap<String,CourseOffering> )session.getAttribute("userHasAccessToOfferings");
		
		if(userHasAccessToOfferings==null)
		{
			out.println("userHasAccessToOfferings NULL!!!");
		}
		else
		{
			
			out.println("<hr/>Offerings: <ul>");
			for(String key : userHasAccessToOfferings.keySet())
			{
				CourseOffering o = userHasAccessToOfferings.get(key);
				out.println("<li>"+key+" "+o.getCourse().getSubject() +" "+o.getCourse().getCourseNumber()+ " "+ o.getSectionNumber()+ " "+ o.getTerm()+"</li>");
			}
			out.println("</ul>");
		}
	}
}
else
{
	out.println("session not yet initialized");
}
%>
