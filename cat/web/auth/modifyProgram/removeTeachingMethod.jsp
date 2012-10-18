<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
CourseOfferingManager manager = CourseOfferingManager.instance();
String linkId = request.getParameter("link_id");
if(manager.deleteTeachingMethod(Integer.parseInt(linkId)))
{
	out.println("Teaching Method removed");
}
else
{
	out.println("ERROR: removing teaching method");
}
%>
		