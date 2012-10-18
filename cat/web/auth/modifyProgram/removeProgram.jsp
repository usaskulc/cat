<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
ProgramManager manager = ProgramManager.instance();

String programId = request.getParameter("program_id");
if(manager.removeProgram(Integer.parseInt(programId)))
{
	out.println("Progam removed");
}
else
{
	out.println("ERROR: removing program");
}
%>
		