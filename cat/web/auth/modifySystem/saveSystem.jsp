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
	String organizationId = request.getParameter("organization");
	int parentId = HTMLTools.getInt(request.getParameter("parent_organization_id"));
	int oldParentId = HTMLTools.getInt(request.getParameter("old_parent_id"));
	String systemName = request.getParameter("system_name");
	String active = request.getParameter("active");
	String action = request.getParameter("action");
	OrganizationManager manager = OrganizationManager.instance();
	if(id != null)
	{
		if(action!=null && action.equals("delete"))
		{
			Organization org = manager.getOrganizationById(Integer.parseInt(id));
			List<OrganizationOutcomeGroup> groups = manager.getOrganizationOutcomeGroupsForOrgForDelete(org);
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
			List<Organization> children = manager.getChildOrganizationsOrderedByName(org,false);
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
			List<CharacteristicType> types = manager.getOrganizationCharacteristicTypes(org);
			if(types!=null && !types.isEmpty())
			{
				out.println("ERROR: Organization still characteristic(s) linked to it");
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
			if(manager.update(id,name,systemName,active,parentId,oldParentId))
			{
				out.println("Organization updated");
			}
			else
			{
				out.println("There was a problem updating the organization!");
			}
		}
	}
	else if(manager.save(name,parentId,systemName))
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
else if(object.equals("OrganizationCourses"))
{
	/* possibilities:
		Course included when it wasn't before : add
		Course included when it already was before: no nothing
		Course not included when it was before : delete
		Course not inluded when it wasn't before either : do nothing
		*/
	
	int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
	String subject = request.getParameter("courseSubject");
	
	List<String> courseNumbers = CourseManager.instance().getCourseNumbersForSubject(subject);
	logger.error("CourseNumbers found"+courseNumbers.size());
	
	List<String> alreadyHasAsHomeorganization = CourseManager.instance().getCourseNumbersForSubjectAndOrganization(subject,organizationId);
	int deleted = 0;
	int failed = 0;
	int added = 0;
	int stayed = 0;
	logger.error("already has "+alreadyHasAsHomeorganization.size());
	for(String courseNumber : courseNumbers)
	{
		String param = request.getParameter("course_number_checkbox_"+courseNumber);
		if(param==null) // course not included
		{
			if(alreadyHasAsHomeorganization.contains(courseNumber)) // it was before
			{
				if(OrganizationManager.instance().removeCourseFromOrganization(subject, courseNumber, organizationId))
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
			if(!alreadyHasAsHomeorganization.contains(courseNumber)) // it was before ans still is
			{
				if(OrganizationManager.instance().addCourseToOrganization(subject, courseNumber, organizationId))
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

else if(object.equals("Instructor"))
{
	String userid = request.getParameter("userid");
	String first = request.getParameter("first_name");
	String last = request.getParameter("last_name");
	int id = HTMLTools.getInt(request.getParameter("id"));
	
	PermissionsManager manager = PermissionsManager.instance();
	if(manager.saveInstructor(id,userid,first,last))
		out.println("Instructor saved");
	else
		out.println("There was a problem saving the Instructor!");	
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
