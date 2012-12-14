<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger"%>
<%!private static Logger logger = Logger.getLogger("/auth/modifySystem/saveSystem.jsp");%>
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
	String action = request.getParameter("action");
	OrganizationManager manager = OrganizationManager.instance();
	if(id != null)
	{
		if(action!=null && action.equals("delete"))
		{
			Organization org = manager.getOrganizationById(Integer.parseInt(id));
			List<OrganizationOutcomeGroup> groups = manager.getOrganizationOutcomeGroupsForOrg(org);
			if(groups!=null && !groups.isEmpty())
			{
				out.println("ERROR: Organization still has outcome groups associated with it");
				return;
			}
			List<OrganizationAdmin> admins = PermissionsManager.instance().getAdminsForOrganization(id);
			if(admins!=null && !admins.isEmpty())
			{
				out.println("ERROR: Organization still has admins associated with it");
				return;
			}
			List<Organization> children = manager.getChildOrganizationsOrderedByName(org);
			if(children!=null && !children.isEmpty())
			{
				out.println("ERROR: Organization still has child-organizations");
				return;
			}
			List<LinkOrganizationOrganizationOutcome> linkedOutcomes = manager.getLinkOrganizationOrganizationOutcomeForOrg(org);
			if(linkedOutcomes!=null && !linkedOutcomes.isEmpty())
			{
				out.println("ERROR: Organization still has outcomes linked to it");
				return;
			}
					
			if(manager.deleteOrganization(id))
			{
				out.println("Organization deleted");
			}
			else
			{
				out.println("ERROR: Unable to delete Organization");
			}
		}
		else
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
	String systemName = request.getParameter("system_name");
	int id = HTMLTools.getInt(request.getParameter("id"));
	if(id < 0)
	{
		if(DepartmentManager.instance().save(name, systemName))
		{
			out.println("Values Saved");
		}
		else
		{
			out.println("ERROR: Unable to save values");
		}
	}
	else
	{
		if(DepartmentManager.instance().update(id,name,systemName))
		{
			out.println("Values Saved");
		}
		else
		{
			out.println("ERROR: Unable to save values");
		}
	}
}
else if(object.equals("DepartmentCourses"))
{
	/* possibilities:
		Course included when it wasn't before : add
		Course included when it already was before: no nothing
		Course not included when it was before : delete
		Course not inluded when it wasn't before either : do nothing
		*/
	
	int departmentId = HTMLTools.getInt(request.getParameter("department_id"));
	String subject = request.getParameter("courseSubject");
	
	List<String> courseNumbers = CourseManager.instance().getCourseNumbersForSubject(subject);
	logger.error("CourseNumbers found"+courseNumbers.size());
	
	List<String> alreadyHasAsHomedepartment = CourseManager.instance().getCourseNumbersForSubjectAndDepartment(subject,departmentId);
	int deleted = 0;
	int failed = 0;
	int added = 0;
	int stayed = 0;
	logger.error("already has "+alreadyHasAsHomedepartment.size());
	for(String courseNumber : courseNumbers)
	{
		String param = request.getParameter("course_number_checkbox_"+courseNumber);
		if(param==null) // course not included
		{
			if(alreadyHasAsHomedepartment.contains(courseNumber)) // it was before
			{
				if(DepartmentManager.instance().removeCourseFromDepartment(subject, courseNumber, departmentId))
				{
					deleted++;
				}
				else
				{
					failed++;
				}
			}
			else
				stayed++;
		}
		else 
		{
			if(!alreadyHasAsHomedepartment.contains(courseNumber)) // it was before ans still is
			{
				if(DepartmentManager.instance().addCourseToDepartment(subject, courseNumber, departmentId))
				{
					added++;
				}
				else
				{
					failed++;
				}
			}
			else
				stayed++;
	
		}
	}
	if(failed > 0)
	{
		out.println("ERROR: "+failed+" changes failed. You could try it again.  If it keeps failing, please contact an administrator");
	}
	else
	{
		out.println("Changes saved (deleted:"+deleted+" added:"+added+" the same:"+stayed+")");
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