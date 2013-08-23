<%-- 
    Copyright 2012, 2013 University of Saskatchewan

    This file is part of the Curriculum Alignment Tool (CAT).

    CAT is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    CAT is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with CAT.  If not, see <http://www.gnu.org/licenses/>.
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger, org.apache.log4j.Logger,org.hibernate.validator.Length"%>
<%!private static Logger logger = Logger.getLogger("/auth/organization/saveGenericField.jsp");%>
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

int fieldSize = 0;
if(HTMLTools.isValid(object) && HTMLTools.isValid(fieldName))
{
	if(object.equals("OrganizationOutcomeGroup"))
	{
		OrganizationOutcomeGroup group = new OrganizationOutcomeGroup(); 
		if( id > -1 )
			group = OrganizationManager.instance().getOrganizationOutcomeGroupById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (OrganizationOutcomeGroup.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}
	}
	else if(object.equals("OrganizationOutcome"))
	{
		OrganizationOutcome o =  new OrganizationOutcome();
		if(id > -1)
			o = OrganizationManager.instance().getOrganizationOutcomeById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (OrganizationOutcome.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else if(fieldName.equals("description"))
		{
			fieldSize= (OrganizationOutcome.class.getMethod("getDescription")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}

	}
	else if(object.equals("ProgramOutcomeGroup"))
	{
		ProgramOutcomeGroup group = new ProgramOutcomeGroup(); 
		if( id > -1 )
			group = ProgramManager.instance().getProgramOutcomeGroupById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (ProgramOutcomeGroup.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}
	}
	else if(object.equals("ProgramOutcome"))
	{
		ProgramOutcome o =  new ProgramOutcome();
		if(id > -1)
			o = ProgramManager.instance().getProgramOutcomeById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (ProgramOutcome.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else if(fieldName.equals("description"))
		{
			fieldSize= (ProgramOutcome.class.getMethod("getDescription")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}

	}
	else 
	{
		out.println("Unable to find object["+object+"]");
	}

}

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

if(newValue.length() > fieldSize)
{
	out.println("ERROR: You have entered ."+newValue.length()+" characters.  Only "+fieldSize+" characters are allowed");
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
