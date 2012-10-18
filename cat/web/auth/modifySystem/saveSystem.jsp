<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger"%>
<%!private static Logger logger = Logger.getLogger("/auth/courseOffering/index.jsp");%>
<%
Enumeration e = request.getParameterNames();
while(e.hasMoreElements())
{
	String pName = (String)e.nextElement();
	String value = request.getParameter(pName);
	logger.error("("+pName + ") = ("+value+")");
}


String object = request.getParameter("object");
if(object == null)
{
	out.println("ERROR: Unable to determine what to do (Object not found)");	
	return;
}
else if(object.equals("Organization"))
{
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String departmentId = request.getParameter("department");
	String parentId = request.getParameter("parent_organization_id");
	
	OrganizationManager manager = OrganizationManager.instance();
	if(id != null)
	{
		if(manager.update(id,name,Integer.parseInt(departmentId)))
		{
			out.println("Organization updated");
		}
		else
		{
			out.println("There was a problem updating the organization!");
		}
	}
	else if(manager.save(name,parentId, Integer.parseInt(departmentId)))
	{
		out.println("Organization created");
		//trigger re-init for reloading permissions
		session.removeAttribute("sessionInitialized");
	}
	else
	{
		out.println("There was a problem creating the organization!");
	}
	
	
}
else if(object.equals("Program"))
{
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String organizationId = request.getParameter("parentObjectId");
	String id = request.getParameter("id");
	
	ProgramManager manager = ProgramManager.instance();
	if(id != null)
	{
		if(manager.update(id,name,description))
		{
			out.println("Program updated");
		}
		else
		{
			out.println("There was a problem updating the program!");
		}
	}
	else if(manager.save(name,description,organizationId))
	{
		out.println("Program created");
	}
	else
	{
		out.println("There was a problem creating the program!");
	}
	
	
}
else if(object.equals("CharacteristicType"))
{//newOutcomeName','newOutcomeDescription','program_id','newOutcomeProgramSpecific'
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String questionDisplay = request.getParameter("questionDisplay");
	String valueType = request.getParameter("valueType");
	CharacteristicManager manager = CharacteristicManager.instance();
/*	if(HTMLTools.isValid(id))
	{
		//update
		/if(manager.updateCharacteristicType(id,name, questionDisplay,valueType))
		{
			out.println("Characteristic Type saved");
		}
		else
		{
			out.println("ERROR: Unable to save new outcome");
		}
	}
	else
	{
		if(manager.saveCharacteristicType(name, questionDisplay,valueType))
		{
			out.println("Characteristic Type saved");
		}
		else
		{
			out.println("ERROR: Unable to save new outcome");
		}
	}*/
}

else if(object.equals("Department"))
{
	String name = request.getParameter("name");
	if(DepartmentManager.instance().save(name))
	{
		out.println("Value Saved");
	}
	else
	{
		out.println("ERROR: Unable to save value");
	}
}
else
{
	out.println("ERROR: Unable to determine what to do (object ["+object+"] not recognized)");	
	return;
}

%>

<%!
public boolean isInt(String s)
{
	try
	{
		Integer.parseInt(s);
		return true;
	}
	catch(Exception e)
	{
	}
	return false;
}
%>