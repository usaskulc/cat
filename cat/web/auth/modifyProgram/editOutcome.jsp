<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int objectId = HTMLTools.getInt( request.getParameter("id"));
String object = request.getParameter("object");
String command = request.getParameter("action");
OutcomeManager om = OutcomeManager.instance();
if(command.equals("delete"))
{
	if(om.deleteOutcomeObject(object, objectId))
	{
		out.println("deleted");
	}
	else
	{
		out.println("ERROR: Unable to delete the outcome");
	}
}

%>
		