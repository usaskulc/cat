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
String id = request.getParameter("id");
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


if(object.equals("Characteristic"))
{
	if(fieldName.equals("name"))
	{
		if(HTMLTools.isValid(id))
		{
			if(CharacteristicManager.instance().saveCharacteristicNameById(newValue,id))
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
			//create a new Characteristic
			String charTypeId = request.getParameter("part_of_id");
			
			if(CharacteristicManager.instance().saveNewCharacteristicWithNameAndType(newValue,charTypeId))
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
		if(HTMLTools.isValid(id))
		{
			if(CharacteristicManager.instance().saveCharacteristicDescriptionById(newValue,id))
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
			
			out.println("Don't know what to do. No id found");
		}
	}
	else
	{
		out.println("Don't know what to do. Field not found!");
	}
}

else if(object.equals("CharacteristicType"))
{
	if(fieldName.equals("name"))
	{
		if(HTMLTools.isValid(id))
		{
			if(CharacteristicManager.instance().saveCharacteristicTypeNameById(newValue,id))
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
			//create a new Characteristic
			
			if(CharacteristicManager.instance().saveNewCharacteristicTypeName(newValue))
			{
				out.println("Created");
			}
			else
			{
				out.println("ERROR: Creation failed");
			}
		}
		
		
		
	}
	else if(fieldName.equals("question"))
	{
		if(HTMLTools.isValid(id))
		{
			if(CharacteristicManager.instance().saveCharacteristicTypeQuestionById(newValue,id))
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
	else if(fieldName.equals("shortDisplay"))
	{
		if(HTMLTools.isValid(id))
		{
			if(CharacteristicManager.instance().saveCharacteristicTypeShortDisplayById(newValue,id))
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
	else if(fieldName.equals("AnswerType"))
	{
		if(HTMLTools.isValid(id))
		{
			if(newValue.trim().equalsIgnoreCase("boolean"))
			{
				newValue = "Boolean";
			}
			else
			{
				newValue = "String";
			}
			
			if(CharacteristicManager.instance().saveCharacteristicTypeValueTypeById(newValue,id))
			{
				out.println("Value Saved");
			}
			else
			{
				out.println("ERROR: Unable to save value");
			}
		}
	}
	else
	{
		out.println("Don't know what to do. Field not found!");
	}

}
else if(object.equals("Assessment"))
{
	if(fieldName.equals("name"))
	{
		if(HTMLTools.isValid(id)) //save existing one
		{
			if(CourseManager.instance().saveAssessmentMethodName(Integer.parseInt(id), newValue))
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
			//create a new Assessment Method (and add it to the group)
			int groupId = HTMLTools.getInt(request.getParameter("part_of_id"));
			
			if(CourseManager.instance().addAssessmentMethodToGroup(groupId, newValue))
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
		if(HTMLTools.isValid(id))
		{
			if(CourseManager.instance().saveAssessmentDescriptionById(Integer.parseInt(id),newValue))
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
			
			out.println("Don't know what to do. No id found");
		}
	}
	else
	{
		out.println("Don't know what to do. Field not found!");
	}
}

else if(object.equals("AssessmentGroup"))
{
	if(fieldName.equals("name"))
	{
		if(HTMLTools.isValid(id)) //save existing one
		{
			if(CourseManager.instance().saveAssessmentGroupName(Integer.parseInt(id), newValue))
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
			//create a new Assessment Method Group 
			if(CourseManager.instance().createAssessmentGroup(newValue))
			{
				out.println("Created");
			}
			else
			{
				out.println("ERROR: Creation failed");
			}
		}
	}
	else if(fieldName.equals("short_name"))
	{
		if(HTMLTools.isValid(id))
		{
			if(CourseManager.instance().saveAssessmentGroupShortName(Integer.parseInt(id),newValue))
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
			
			out.println("Don't know what to do. No id found");
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