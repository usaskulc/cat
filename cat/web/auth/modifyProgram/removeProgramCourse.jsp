<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
ProgramManager manager = ProgramManager.instance();

String linkId = request.getParameter("link_id");
if(manager.removeProgramCourse(Integer.parseInt(linkId)))
{
	out.println("CourseOffering removed");
}
else
{
	out.println("ERROR: removing courseOffering");
}
%>
		