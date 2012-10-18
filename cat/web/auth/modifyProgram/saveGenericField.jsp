<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger"%>
<%!private static Logger logger = Logger.getLogger("/auth/department/saveGenericField.jsp");%>
<%
Enumeration e = request.getParameterNames();
while(e.hasMoreElements())
{
	String pName = (String)e.nextElement();
	String value = request.getParameter(pName);
	logger.error("("+pName + ") = ("+value+")");
}

String object = request.getParameter("object");
String fieldName = request.getParameter("field_name");
int id = HTMLTools.getInt( request.getParameter("id"));
String newValue = request.getParameter("new_value");


if(!HTMLTools.isValid(object))
{
	out.println("ERROR: Unable to determine what to do (Object not found)");	
	return;
}

if(!HTMLTools.isValid(fieldName))
{
	out.println("ERROR: Unable to determine what to do (field not found)");	
	return;
}


if(object.equals("ProgramOutcomeGroup"))
{
	if(fieldName.equals("name"))
	{
		if(id > -1)
		{
			if(ProgramManager.instance().saveProgramOutcomeGroupNameById(newValue,id))
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
			//create a new ProgramOutcomeGroup
			int programId = HTMLTools.getInt(request.getParameter("program_id"));
			
			if(ProgramManager.instance().saveNewProgramOutcomeNameAndProgram(newValue,programId))
			{
				out.println("Created");
			}
			else
			{
				out.println("ERROR: Creation failed");
			}
		}
	}
	
	else
	{
		out.println("Don't know what to do. Field not found!");
	}
}

else if(object.equals("ProgramOutcome"))
{
	if(fieldName.equals("name"))
	{
		if(id > -1)
		{
			if(ProgramManager.instance().saveProgramOutcomeNameById(newValue,id))
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
			//create a new ProgramOutcome
			int programOutcomeGroupId = HTMLTools.getInt(request.getParameter("program_outcome_group_id"));
			if(ProgramManager.instance().saveNewProgramOutcomeNameAndGroup(newValue,programOutcomeGroupId))
			{
				out.println("Created");
			}
			else
			{
				out.println("ERROR: Creation failed");
			}			
		}
	}
	else if(fieldName.equals("description"))
	{
		if(id > -1)
		{
			if(ProgramManager.instance().saveProgramOutcomeDescriptionById(newValue,id))
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
			out.println("ERROR: Don't have the correct values!");
		}

	}
	else
	{
		out.println("Don't know what to do. Field not found!");
	}

}
else if(object.equals("OrganizationOutcomeGroup"))
{
	if(fieldName.equals("name"))
	{
		if(id > -1)
		{
			if(OrganizationManager.instance().saveOrganizationOutcomeGroupNameById(newValue,id))
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
			//create a new OrganizationOutcomeGroup
			int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
			
			if(OrganizationManager.instance().saveNewOrganizationOutcomeNameAndOrganization(newValue,organizationId))
			{
				out.println("Created");
			}
			else
			{
				out.println("ERROR: Creation failed");
			}
		}
	}
	
	else
	{
		out.println("Don't know what to do. Field not found!");
	}
}

else if(object.equals("OrganizationOutcome"))
{
	if(fieldName.equals("name"))
	{
		if(id > -1)
		{
			if(OrganizationManager.instance().saveOrganizationOutcomeNameById(newValue,id))
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
			//create a new organizationOutcome
			int organizationOutcomeGroupId = HTMLTools.getInt(request.getParameter("organization_outcome_group_id"));
			if(OrganizationManager.instance().saveNewOrganizationOutcomeNameAndGroup(newValue,organizationOutcomeGroupId))
			{
				out.println("Created");
			}
			else
			{
				out.println("ERROR: Creation failed");
			}			
		}
	}
	else if(fieldName.equals("description"))
	{
		if(id > -1)
		{
			if(OrganizationManager.instance().saveOrganizationOutcomeDescriptionById(newValue,id))
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
			out.println("ERROR: Don't have the correct values!");
		}

	}
	else
	{
		out.println("Don't know what to do. Field not found!");
	}

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