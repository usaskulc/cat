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
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*, org.apache.log4j.Logger,org.hibernate.validator.Length"%>
<%!private static Logger logger = Logger.getLogger("/auth/modifyProgram/saveProgram.jsp");%>
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

if(object.equals("Course"))
{
	String subject = request.getParameter("subject");
	String courseNumber = request.getParameter("courseNumber");
	String title = request.getParameter("title");
	String description = request.getParameter("description");
	String id = request.getParameter("id");
	
	CourseManager cm = CourseManager.instance();
	//check first if it already exists:
	Course course = cm.getCourseBySubjectAndNumber(subject.trim(), courseNumber.trim());
	if(course != null)
	{
		out.println("Course already exists!");
		out.println("["+course.getId()+"]");
		id = ""+course.getId();
	}
	if(id != null)
	{
		if(cm.update(course, subject, courseNumber, title, description))
		{
			out.println("Course updated");
		}
		else
		{
			out.println("There was a problem updating the course!");
		}
	}
	else if(cm.save(subject, courseNumber, title, description))
	{
		out.println("Course created");
		Course created = cm.getCourseBySubjectAndNumber(subject.trim(), courseNumber.trim());
		out.println("["+created.getId()+"]");
	}
	else
	{
		out.println("There was a problem creating the course!");
	}
	
	
}
else if(object.equals("CourseOffering"))
{
	String sectionNumber = request.getParameter("sectionNumber");
	String term = request.getParameter("term");
	String medium = request.getParameter("medium");
	String courseId = request.getParameter("course_id");
	
	CourseManager cm = CourseManager.instance();
	Course course = cm.getCourseById(Integer.parseInt(courseId));
	CourseOffering offering = cm.getOfferingByCourseAndSectionAndTerm(course, sectionNumber, term);
	if(offering != null)
	{
		if(cm.updateCourseOffering(offering, sectionNumber, term, medium))
		{
			out.println("Course offering updated");
		}
		else
		{
			out.println("There was a problem updating the course offering!");
		}
	}
	else if(cm.saveCourseOffering(course, sectionNumber, term, medium))
	{
		out.println("Course offering created");
		//trigger re-init for reloading permissions
		session.removeAttribute("sessionInitialized");
	}
	else
	{
		out.println("There was a problem creating the course offering!");
	}
}

else if(object.equals("LinkCourseProgram"))
{
	String courseId = request.getParameter("course_id");
	String programId = request.getParameter("program_id");
	
	String courseClassifcation = request.getParameter("courseClassifcation");
	String time = request.getParameter("time");
	String id = request.getParameter("id");
	
	ProgramManager manager = ProgramManager.instance();
	if(id != null)
	{
		if(manager.updateLinkCourseProgram(Integer.parseInt(id),Integer.parseInt(courseClassifcation), Integer.parseInt(time)))
		{
			out.println("Course info updated");
		}
		else
		{
			out.println("There was a problem updating the course info!");
		}
	}
	else if(manager.saveLinkCourseProgram(Integer.parseInt(courseId), Integer.parseInt(programId), Integer.parseInt(courseClassifcation), Integer.parseInt(time)))
	{
		out.println("CourseOffering added to program");
		//trigger re-init for reloading permissions
		session.removeAttribute("sessionInitialized");
	}
	else
	{
		out.println("There was a problem adding the courseOffering to the program!");
	}
	
}
else if(object.equals("ProgramOutcome"))
{
	String linkId = request.getParameter("id");
	String programId = request.getParameter("program_id");
	String[] outcomeIds = request.getParameter("outcomeToAdd").split(",");
	OutcomeManager manager = OutcomeManager.instance();
	String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
	int count = 0;
	if(linkId == null || linkId.trim().length() < 1 )
	{
		for(String outcomeId : outcomeIds)
		{//new outcome link
			if(manager.saveProgramOutcomeLink(Integer.parseInt(programId), Integer.parseInt(outcomeId)))
			{
				count++;
			}
		}
		out.println(count+" outcome(s) added");
	}
	
}
else if(object.equals("OrganizationOutcome"))
{
	String linkId = request.getParameter("id");
	String organizationId = request.getParameter("organization_id");
	String[] outcomeIds = request.getParameter("outcomeToAdd").split(",");
	OutcomeManager manager = OutcomeManager.instance();
	String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
	int count = 0;
	if(linkId == null || linkId.trim().length() < 1 )
	{
		for(String outcomeId : outcomeIds)
		{//new outcome link
			if(manager.saveOrganizationOutcomeLink(Integer.parseInt(organizationId), Integer.parseInt(outcomeId)))
			{
				count++;
			}
		}
		out.println(count+" outcome(s) added");
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
else if(object.equals("NewProgramOutcome"))
{
	String newOutcomeName = request.getParameter("newOutcomeName");
	String programId = request.getParameter("program_id");
	String newOutcomeDescription = request.getParameter("newOutcomeDescription");
	String newOutcomeProgramSpecific = request.getParameter("newOutcomeProgramSpecific");
	OutcomeManager manager = OutcomeManager.instance();
	if(manager.saveNewProgramOutcome(newOutcomeName, programId,newOutcomeDescription,newOutcomeProgramSpecific))
	{
		out.println("Done saving new outcome");
	}
	else
	{
		out.println("ERROR: Unable to save new outcome");
	}
	
}

else if(object.equals("InstructorAttribute"))
{
	String name = request.getParameter("name");
	String organizationId = request.getParameter("organization_id");
	OrganizationManager manager = OrganizationManager.instance();
	Organization org = manager.getOrganizationById(Integer.parseInt(organizationId));
	
	if(manager.addAttribute(org,name))
	{
		out.println("Done saving new Instructor Attribute");
	}
	else
	{
		out.println("ERROR: Unable to save new Instructor Attribute");
	}
	
}
else if(object.equals("InstructorAttributeValue"))
{
	String value = request.getParameter("value");
	String programId = request.getParameter("program_id");
	String userid = request.getParameter("userid");
	int instructorAttributeValueId = HTMLTools.getInt(request.getParameter("attribute_value_id"));
	int instructorAttributeId = HTMLTools.getInt(request.getParameter("attribute_id"));
	
	CourseManager manager = CourseManager.instance();
	if(instructorAttributeValueId > -1)
	{
		//editing
		if(manager.editInstructorAttributeValue(instructorAttributeValueId, value))
		{
			out.println("Done saving new Instructor Attribute");
		}
		else
		{
			out.println("ERROR: Unable to save new Instructor Attribute");
		}
		
	}
	else
	{
		//create new one
		if(manager.saveInstructorAttributeValue(instructorAttributeId, value,userid))
		{
			out.println("Done saving new Instructor Attribute");
		}
		else
		{
			out.println("ERROR: Unable to save new Instructor Attribute");
		}

	}	
}
else if(object.equals("CourseAttribute"))
{
	String name = request.getParameter("name");
	String organizationId = request.getParameter("organization_id");
	OrganizationManager manager = OrganizationManager.instance();
	Organization org = manager.getOrganizationById(Integer.parseInt(organizationId));
	
	if(manager.addCourseAttribute(org,name))
	{
		out.println("Done saving new Course Attribute");
	}
	else
	{
		out.println("ERROR: Unable to save new Course Attribute");
	}
	
}
else if(object.equals("CourseAttributeValue"))
{
	String value = request.getParameter("value");
	String programId = request.getParameter("program_id");
	int courseId = HTMLTools.getInt(request.getParameter("course_id"));
	int courseAttributeValueId = HTMLTools.getInt(request.getParameter("attribute_value_id"));
	int courseAttributeId = HTMLTools.getInt(request.getParameter("attribute_id"));
	
	CourseManager manager = CourseManager.instance();
	if(courseAttributeValueId > -1)
	{
		//editing
		if(manager.editCourseAttributeValue(courseAttributeValueId, value))
		{
			out.println("Done saving new Course Attribute");
		}
		else
		{
			out.println("ERROR: Unable to save new Course Attribute");
		}
		
	}
	else
	{
		//create new one
		if(manager.saveCourseAttributeValue(courseAttributeId, value,courseId))
		{
			out.println("Done saving new Course Attribute");
		}
		else
		{
			out.println("ERROR: Unable to save new Course Attribute");
		}

	}	
}
else if(object.equals("Program"))
{
	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String organizationId = request.getParameter("organization_id");
	String id = request.getParameter("id");
	
	ProgramManager manager = ProgramManager.instance();
	if(id != null)
	{
		if(manager.update(id,name,description))
		{
			out.println("Program updated");
			//trigger re-init for reloading permissions
			session.removeAttribute("sessionInitialized");
		}
		else
		{
			out.println("There was a problem updating the program!");
		}
	}
	else if(manager.save(name,description,organizationId))
	{
		out.println("Program created");
		//trigger re-init for reloading permissions
		session.removeAttribute("sessionInitialized");
	}
	else
	{
		out.println("There was a problem creating the program!");
	}
	
	
}
else if (object.equals("ProgramOutcomeOrganizationOutcome"))
{
	int outcomeId = HTMLTools.getInt(request.getParameter("outcome_selected"));
	int organizationOutcomeId = HTMLTools.getInt(request.getParameter("organization_outcome_id"));
	int programId = HTMLTools.getInt(request.getParameter("program_id"));
	
	
	OrganizationManager manager = OrganizationManager.instance();
	if(manager.saveProgramOutcomeOrganizationOutcome(outcomeId, organizationOutcomeId,programId))
	{
		out.println("Contribution added");
	}
	else
	{
		out.println("ERROR: Unable to save contribution");
	}
}
else if (object.equals("LinkCourseOrganization"))
{
	int courseId = HTMLTools.getInt(request.getParameter("id"));
	int organizationId = HTMLTools.getInt(request.getParameter("organization"));
	
	CourseManager manager = CourseManager.instance();
	if(manager.addOrganizationToCourse(organizationId, courseId))
	{
		out.println("Organization added");
	}
	else
	{
		out.println("ERROR: Unable to add Organization");
	}
}
else if (object.equals("MoveQuestionItem"))
{
	int programId = HTMLTools.getInt(request.getParameter("program_id"));
	int toMoveId = HTMLTools.getInt(request.getParameter("option_id"));
	int setId = HTMLTools.getInt(request.getParameter("set_id"));
	String action = request.getParameter("action");
	String type = request.getParameter("type");

	QuestionManager manager = QuestionManager.instance();
	if(type.equals("answerOption"))
	{
		if(manager.moveAnswerOption(toMoveId, action))
		{
			out.println("");
		}
		else
		{
			out.println("ERROR: Unable to perform answer option action");
		}
	}
	else if (type.equals("question"))
	{
		if(manager.moveQuestion(programId,toMoveId, action))
		{
			out.println("");
		}
		else
		{
			out.println("ERROR: Unable to perform question action");
		}
	}
}
else if (object.equals("LinkProgramQuestion"))
{
	int programId = HTMLTools.getInt(request.getParameter("program_id"));
	int questionId = HTMLTools.getInt(request.getParameter("question_id"));
	String action = request.getParameter("action");
	
	QuestionManager manager = QuestionManager.instance();
	if(action.equals("add"))
	{
		if(manager.addQuestionToProgram(questionId, programId))
		{
			out.println("Question added");
		}
		else
		{
			out.println("ERROR: Unable to add Question");
		}
	}
	else if(action.equals("remove"))
	{
			if(manager.addQuestionToProgram(questionId, programId))
			{
				out.println("Question added");
			}
			else
			{
				out.println("ERROR: Unable to add Question");
			}

		}
}

else if (object.equals("ProgramQuestion"))
{
	int programId = HTMLTools.getInt(request.getParameter("program_id"));
	int questionId = HTMLTools.getInt(request.getParameter("question_id"));
	String display = request.getParameter("display");
	String questionType = request.getParameter("question_type");
	int answerSetId = HTMLTools.getInt(request.getParameter("answer_set_id"));
	QuestionManager manager = QuestionManager.instance();
	
	AnswerSet set= null;
	if (answerSetId < 0 && !questionType.equals("textarea"))
	{
		 set = manager.getAnswerSetByName(request.getParameter("answer_set_id"));
		 answerSetId = set.getId();
	}	 

	if(manager.saveQuestion(questionId, display, questionType, answerSetId))
	{
		out.println("Question saved");
	}
	else
	{
		out.println("ERROR: Unable to save Question");
	}
}
else if (object.equals("AnswerOption"))
{
	int programId = HTMLTools.getInt(request.getParameter("as_program_id"));
	int answerSetId = HTMLTools.getInt(request.getParameter("as_answer_set_id"));
	String display = request.getParameter("as_display");
	String calcValue = request.getParameter("calc_value");
	int optionId = HTMLTools.getInt(request.getParameter("as_option_id"));
	QuestionManager manager = QuestionManager.instance();

	if(optionId == -1 && answerSetId == -1)
	{
		String answerSetName = request.getParameter("answer_set_name");
		if(!manager.saveAnswerSet(answerSetName))
		{
			out.println("Unable to create new Answerset! Please make sure that the values you entered are not too long.");
			return;
		}
		AnswerSet newSet = manager.getAnswerSetByName(answerSetName);
		answerSetId = newSet.getId();
	}
	if(manager.saveAnswerOption(optionId,calcValue, display, answerSetId))
	{
		out.println("Option saved");
	}
	else
	{
		out.println("ERROR: Unable to save Option");
	}
}
else if (object.equals("ProgramOutcomeWithCharacteristics"))
{
	int existingOutcomeId = HTMLTools.getInt(request.getParameter("outcome_id"));
	int linkId = HTMLTools.getInt(request.getParameter("link_id"));
	int programId = HTMLTools.getInt(request.getParameter("program_id"));
	int programOutcomeGroupId = HTMLTools.getInt(request.getParameter("program_outcome_group_id"));
	
	String characteristicCount = request.getParameter("char_count");
	int charCount = Integer.parseInt(characteristicCount);
	String outcomeName = request.getParameter("new_value");
	OutcomeManager manager = OutcomeManager.instance();
	String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
	int maxFieldSize= (ProgramOutcome.class.getMethod("getName")).getAnnotation(Length.class).max();
	if(outcomeName.length() > maxFieldSize)
	{
		out.println("Maximum length of the outcome is "+maxFieldSize+" characters. The one you entered is "+outcomeName.length()+" characters.");
		return;
	}
	
	if(linkId < 0 )
	{
		boolean allOkay = true;
		//new outcome link
		existingOutcomeId = manager.saveProgramOutcomeLink(programId, outcomeName,programOutcomeGroupId);
		for(int i=0; i < charCount ; i++ )
		{
			String charString = request.getParameter("characteristic_"+i);
			String charType = request.getParameter("characteristic_type_"+i);
			logger.error("charString = ["+charString+"] charType ("+"characteristic_type_"+i+") = ["+charType+"]");
			
			allOkay = allOkay && manager.saveCharacteristic(programId, existingOutcomeId, charString,charType,userid,true);
			
		}
		if(allOkay)
		{
			out.println("Outcome added");
		}
		else
		{
			out.println("ERROR: saving new outcome");
		}
	}
	else
	{
		LinkProgramProgramOutcome existing = manager.getLinkProgramProgramOutcomeById(linkId);
		ProgramOutcome outcome =  existing.getProgramOutcome();
		if (manager.saveProgramOutcome(outcomeName, outcome.getId()))
		{
			boolean allOkay = true;
			//saving existing
			for(int i=0; i < charCount ; i++ )
			{
				String charString = request.getParameter("characteristic_"+i);
				String charType = request.getParameter("characteristic_type_"+i);
				logger.error("charString = ["+charString+"] charType ("+"characteristic_type_"+i+") = ["+charType+"]");
				
				allOkay = allOkay && manager.updateProgramOutcomeCharacteristic(linkId, charString,charType,userid);
				
			}
			if(allOkay)
			{
				out.println("Outcome updated");
			}
			else
			{
				out.println("ERROR: saving outcome changes");
			}
		}
		else
		{
			out.println("ERROR: Unable to save new Program Outcome text");
		}
	}
	
}
else if(object.equals("DeleteLibraryQuestion"))
{
	int programId = HTMLTools.getInt(request.getParameter("program_id"));
	int questionId = HTMLTools.getInt(request.getParameter("question_id"));
	
	QuestionManager manager = QuestionManager.instance();
	if(manager.deleteQuestion(questionId))
	{
		out.println("Question deleted");
	}
	else
	{
		out.println("ERROR: Unable to delete question");
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
