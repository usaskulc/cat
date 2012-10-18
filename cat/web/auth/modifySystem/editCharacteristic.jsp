<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String charTypeId = request.getParameter("charTypeId");
String charId = request.getParameter("char_id");
String command = request.getParameter("command");
CharacteristicManager manager = CharacteristicManager.instance();
if(command.equals("up") || command.equals("down") || command.equals("delete"))
{
	if(!manager.moveCharacteristic(Integer.parseInt(charId), Integer.parseInt(charTypeId),command) )
	{
		if(command.equals("edit"))
			out.println("ERROR: Unable to edit Characteristic");
		else
			out.println("ERROR: Unable to move Characteristic option "+command);
	}
}

else if(command.equals("deleteType"))
{
	if(manager.deleteCharacteristicsType(charTypeId))
	{
		out.println("Deleted");
	}
	else
	{
		out.println("Unable to delete Characteristic Type");
	}
}

%>
		