<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String charId = request.getParameter("charId");
String programId = request.getParameter("program_id");

if(!ProgramManager.instance().addCharacteristicToProgram(Integer.parseInt(charId), Integer.parseInt(programId)))
{
	out.println("ERROR: Unable to add Characteristic");
}

%>
		