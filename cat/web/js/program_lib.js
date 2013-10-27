/*****************************************************************************
 * Copyright 2012, 2013 University of Saskatchewan
 *
 * This file is part of the Curriculum Alignment Tool (CAT).
 *
 * CAT is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 *(at your option) any later version.
 *
 * CAT is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with CAT.  If not, see <http://www.gnu.org/licenses/>.
 *
 ****************************************************************************/


function saveProgram(requiredParameterArray, parameterArray,type)
{
	changeDetected = false;
	clearMessages(requiredParameterArray);
	if(checkRequired(requiredParameterArray))
	{
			
		$('#saveButton').attr("disabled","true");
		var object = $("#objectClass").val();
		if(type != null)
		{
			object = type;
		}
		var objectId= $("#objectId").val();
		
		var parentObjectId= $("#parentObjectId").val();
		var parameters = "object=" + object;
		if(objectId != null && objectId.length > 0)
		{	
			parameters += "&id="+objectId;
		}
		if(parentObjectId != null && parentObjectId.length > 0)
		{	
			parameters += "&parentObjectId="+parentObjectId;
		}
		var asProgramId = $("#as_program_id").val();
		if(asProgramId!=null)
		{
			parameters += "&program_id="+asProgramId;
		}
		
		
		parameters += readParameters(parameterArray);
		//console.log(parameters);
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/modifyProgram/saveProgram.jsp",
			data: 		parameters,
			success:	function(msg) 
			{
				$("#messageDiv").html(msg);
				$("#messageDiv").show();
				if(msg.indexOf("ERROR") >=0)
				{
					alert("There was a problem saving the data! "+msg);
				}
				else
				{
					$("#messageDiv").html(msg);
				}
				//if edit organization or add program,reload org  Organization_<%=o.getId()%>
				//if add org, reload whole thing id allOrganizations
				//console.log("object="+object);
				//console.log("objectId="+objectId);
				var programId = $("#program_id").val();
				
				var organizationId = $("#organization_id").val();
				if(object == "Organization")
				{
					if(parentId != null && parentId.length > 0)
					{
						objectId = parentId;
					}
					if(objectId != null && objectId.length > 0)
					{	
						loadURLIntoId("/cat/organization.jsp?id="+objectId,"#Organization_"+objectId);
						
					}
					else //no id, must be a new org
					{
						loadURLIntoId("/cat/organizations.jsp","#allOrganizations");
					}
				}
				else if(object == "Program")
				{
					var parentId = $("#organization_id").val();
					if(objectId != null && objectId.length > 0)
					{	
						loadURLIntoId("/cat/auth/programView/program.jsp?program_id="+objectId,"#program");
					}
				
					else if(parentId != null && parentId.length > 0)
					{
						parentObjectId = parentId;
						
					}
				
					if(parentObjectId != null && parentObjectId.length > 0)
					{	
						loadURLIntoId("/cat/organization.jsp?organization_id="+parentObjectId,"#Organization_"+parentObjectId);
						var command = "toggleDisplay('org_"+parentObjectId+"','"+clientBrowser+"')";
						setTimeout(command,1000);
					}
				}
				else if(object == "Course")
				{
					var courseId = $("#objectId").val();
					if(courseId == null)
					{
						courseId = msg.substring(msg.indexOf("[")+1, msg.indexOf("]"));
						document.location = "/cat/auth/programView/courseCharacteristicsWrapper.jsp?program_id="+programId+"&course_id="+courseId;
					}
					else
					{
						loadURLIntoId("/cat/auth/programView/courseCharacteristics.jsp?program_id="+programId+"&course_id="+courseId,"#CourseCharacteristicsDiv");
					}
				}
				else if(object == "CourseOffering")
				{
					var courseId = $("#course_id").val();
					loadURLIntoId("/cat/auth/programView/courseOfferings.jsp?course_id="+courseId+"&program_id="+programId,"#courseOfferingsDiv");
				}
				
				else if(object == "LinkCourseProgram")
				{
					var courseId = $("#course_id").val();
					loadURLIntoId("/cat/auth/programView/courseCharacteristics.jsp?link_id="+objectId+"&course_id="+courseId+"&program_id="+programId,"#CourseCharacteristicsDiv");
				}
				else if(object == "ProgramOutcome")
				{
					var programId = $("#program_id").val();
					loadURLIntoId("/cat/auth/programView/programOutcomes.jsp?program_id="+programId,"#programOutcomesDiv");
				}
				else if(object == "NewProgramOutcome")
				{
					var programId = $("#program_id").val();
					var newOutcomeName = $("#newOutcomeName").val();
					loadURLIntoId("/cat/auth/modifyProgram/programOutcome.jsp?program_id="+programId+"&outcome="+escape(newOutcomeName),"#editDiv");
				}
				else if(object == "InstructorAttribute")
				{
					var orgId = $("#organization_id").val();
					loadURLIntoId("/cat/organization.jsp?organization_id="+orgId,"#Organization_"+orgId);
				}
				else if(object == "InstructorAttributeValue")
				{
					var programId = $("#program_id").val();
					var userid = $("#userid").val();
					var courseId = $("#course_id").val();
					loadModify("/cat/auth/modifyProgram/modifyInstructorAttributes.jsp?program_id="+programId+"&userid="+userid+"&course_id="+courseId);
					loadURLIntoId("/cat/auth/programView/courseOfferings.jsp?program_id="+programId+"&course_id="+courseId,"#courseOfferingsDiv");
				}
				else if(object == "CourseAttribute")
				{
					var orgId = $("#organization_id").val();
					loadURLIntoId("/cat/organization.jsp?organization_id="+orgId,"#Organization_"+orgId);
				}
				else if(object == "CourseAttributeValue")
				{
					var programId = $("#program_id").val();
					var courseId = $("#course_id").val();
					loadModify("/cat/auth/modifyProgram/modifyCourseAttributes.jsp?program_id="+programId+"&course_id="+courseId);
					loadURLIntoId("/cat/auth/programView/programCourses.jsp?program_id="+programId,"#programCoursesDiv");
				}
				else if(object == "OrganizationOutcome")
				{
					var organizationId = $("#organization_id").val();
					loadURLIntoId("/cat/organizationOutcomes.jsp?organization_id="+organizationId,"#organizationOutcomesDiv_"+organizationId);
				}
				else if(object=="ProgramOutcomeOrganizationOutcome")
				{
					var programId = $("#program_id").val();
					var organizationOutcomeId = $("#organization_outcome_id").val();
					
					loadModify('/cat/auth/modifyProgram/editOutcomeMapping.jsp?program_id='+programId+'&organization_outcome_id='+organizationOutcomeId);
					loadURLIntoId("/cat/auth/programView/outcomesMapping.jsp?program_id="+programId,"#outcomesMappingDiv");
				}
				else if(object=="LinkCourseOrganization")
				{
					var programId = $("#program_id").val();
					var courseId = $("#objectId").val();
					
					loadURLIntoId("/cat/auth/modifyProgram/courseOrganizations.jsp?program_id="+programId+"&course_id="+courseId,"#courseOrganizationsDiv");
				}
				else if (object=="ProgramOutcomeWithCharacteristics")
				{
					
				}
				else if (object == "AnswerOption")
				{
					var programId = $("#as_program_id").val();
			
					$("#optionMessageDiv").html(msg);
					$("#optionMessageDiv").show();
					$("#optionMessageDiv").html(msg);
					$('#saveOptionButton').removeAttr("disabled");
					
					var questionType = $("#as_question_type").val();
					var setId = $("#answer_set_id").val();
					var asOptionId = $("#as_option_id").val();
					var asSetId = $("#as_answer_set_id").val();
					
					if(asSetId == "-1" && asOptionId == "-1")
					{
						var setName = $("#answer_set_name").val();
						loadURLIntoId("/cat/auth/programView/answerSet.jsp?program_id="+programId+"&answer_set_id="+setName+"&inUse=false&editMode=true"+"&question_type="+questionType, "#AnswerSetDiv");
						$("#EditAnswerSetDiv").html("");
						$("#answer_set_id").val(setName);
					}
					else
					{
						loadURLIntoId("/cat/auth/programView/answerSet.jsp?program_id="+programId+"&answer_set_id="+setId+"&inUse=false&editMode=true"+"&question_type="+questionType, "#AnswerSetDiv");
						$("#EditAnswerSetDiv").html("");
					}
				}
				else if (object == "ProgramQuestion")
				{
					var programId = $("#program_id").val();
					var listShownString = $("#list_shown").val();
					if (listShownString != null && listShownString)
					{
						loadURLIntoId("/cat/auth/programView/questionLibrary.jsp?program_id="+programId,"#questionLibraryDiv","Question has been added to the library.");
					}
							
				}
				$('#saveButton').removeAttr("disabled");
				setTimeout("clearMessage();",500);
				//console.log("object="+object);
				if(object != "AnswerOption" && object != "ProgramQuestion" && object != "Course" && object!="NewProgramOutcome" && object!= "InstructorAttributeValue" && object!="CourseAttributeValue" && object!="ProgramOutcomeOrganizationOutcome" && object !="LinkCourseOrganization")
				{
					setTimeout("closeEdit()",2000);
				}
			},
			error:function (xhr, ajaxOptions, thrownError){
				updateLoginStatus("errorIfNotLoggedin()");
				$('#saveButton').removeAttr("disabled");
			}
		});
	}
	
}

function removeProgram(program_id,organization_id)
{
	if(!confirm("Are you sure you want to remove this program ? Any course associations, outcome links, question links, responses to program questions and characteristic links will be removed!"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/removeProgram.jsp?program_id="+program_id,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			loadURLIntoId("/cat/organization.jsp?organization_id="+organization_id,"#Organization_"+organization_id);
			resetChanges();
			var command = "toggleDisplay('org_"+organization_id+"','"+clientBrowser+"')";
			setTimeout(command,1000);
		}
	});
}
function removeOrganizationFromCourse(organizationLinkId, programId, courseId)
{
	if(!confirm("Are you sure you want to remove this organization?"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editCourseOrganization.jsp?program_id="+programId + "&dept_link_id="+organizationLinkId + "&action=removeOrganization",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			resetChanges();
			loadURLIntoId("/cat/auth/modifyProgram/courseOrganizations.jsp?program_id="+programId+"&course_id="+courseId,"#courseOrganizationsDiv");
		}
	});
}
function editCourseOfferingInstructor(action, linkOrUser,programId,courseOfferingId,courseId,first,last)
{
	if(action == "delete" && !confirm("Are you sure you want to remove this instructor?"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editCourseOfferingInstructor.jsp?program_id="+programId + "&user_or_link="+linkOrUser + "&action="+
						action+"&course_offering_id="+courseOfferingId+"&first="+escape(first)+"&last="+escape(last),
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			resetChanges();
			loadURLIntoId("/cat/auth/modifyProgram/courseOfferingInstructors.jsp?program_id="+programId+"&course_offering_id="+courseOfferingId+"&course_id="+courseId,"#courseOfferingInstructorsDiv");
			loadURLIntoId("/cat/auth/programView/courseOfferings.jsp?course_id="+courseId+"&program_id="+programId,"#courseOfferingsDiv");
			
		}
	});
}

function deleteOrganizationOutcomeMapping(programId,organizationOutcomeId,existingLinkId)
{
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editOutcomeMappingProcessing.jsp?link_id="+existingLinkId+"&action=deleteLink",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem deleting Program Outcome link! "+msg);
			}
			else
			{
				loadModify('/cat/auth/modifyProgram/editOutcomeMapping.jsp?program_id='+programId+'&organization_outcome_id='+organizationOutcomeId);
				loadURLIntoId("/cat/auth/programView/outcomesMapping.jsp?program_id="+programId,"#outcomesMappingDiv");
			}
			resetChanges();
		}
	});


}
function removeOrganizationOutcome(organizationId,link_id)
{
	if(!confirm("Are you sure you want to remove the Organization Outcome ?"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/removeOrganizationOutcome.jsp?link_id="+link_id+"&organization_id="+organizationId,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			loadURLIntoId("/cat/organizationOutcomes.jsp?organization_id="+organizationId,"#organizationOutcomesDiv_"+organizationId);
			resetChanges();
		}
	});

}

function removeProgramOutcome(program_id,link_id)
{
	if(!confirm("Are you sure you want to remove the Program Outcome ?"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/removeProgramOutcome.jsp?link_id="+link_id+"&program_id="+program_id,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			loadURLIntoId("/cat/auth/programView/programOutcomes.jsp?program_id="+program_id,"#programOutcomesDiv");
			resetChanges();
		}
	});

}
function removeProgramOutcome(program_id,link_id, organization_id)
{

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/removeProgramOutcome.jsp?link_id="+link_id+"&program_id="+program_id,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			loadURLIntoId("/cat/auth/programView/programOutcomes.jsp?program_id="+program_id,"#programOutcomesDiv");
			resetChanges();
		}
	});

}

function removeProgramCourse(program_id,link_id)
{
	if(!confirm("Are you sure you want to remove the Course from this program ?"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/removeProgramCourse.jsp?link_id="+link_id+"&program_id="+program_id,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
			}
			loadURLIntoId("/cat/auth/programView/programCourses.jsp?program_id="+program_id,"#programCoursesDiv");
			resetChanges();
		}
	});

}

function removeInstructorAttributeValue(link_id,program_id,userid,courseId)
{
	if(!confirm("Are you sure you want to remove the Instructor Attribute value? "))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editInstructorAttribute.jsp?link_id="+link_id+"&program_id="+program_id+"&action=removeValue",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
				loadModify("/cat/auth/modifyProgram/modifyInstructorAttributes.jsp?program_id="+program_id+"&userid="+userid+"&course_id="+courseId);
				loadURLIntoId("/cat/auth/programView/courseOfferings.jsp?program_id="+program_id+"&course_id="+courseId,"#courseOfferingsDiv");
			}
			resetChanges();
			
		}
	});

}



function removeInstructorAttribute(link_id,organization_id)
{
	if(!confirm("Are you sure you want to remove the Instructor Attribute?  Any values already entered of this type will be deleted! "))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editInstructorAttribute.jsp?link_id="+link_id+"&organization_id="+organization_id+"&action=removeType",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
				loadURLIntoId("/cat/organization.jsp?organization_id="+organization_id,"#Organization_"+organization_id);
			}
			resetChanges();
			
		}
	});

}
function removeCourseAttributeValue(link_id,program_id,courseId)
{
	if(!confirm("Are you sure you want to remove the Course Attribute value? "))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editCourseAttribute.jsp?link_id="+link_id+"&program_id="+program_id+"&action=removeValue",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
				loadModify("/cat/auth/modifyProgram/modifyCourseAttributes.jsp?program_id="+program_id+"&course_id="+courseId);
				loadURLIntoId("/cat/auth/programView/programCourses.jsp?program_id="+program_id,"#programCoursesDiv");
			}
			resetChanges();
			
		}
	});

}
function removeCourseAttribute(link_id,organization_id)
{
	if(!confirm("Are you sure you want to remove the Course Attribute?  Any values already entered of this type will be deleted! "))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editCourseAttribute.jsp?link_id="+link_id+"&organization_id="+organization_id+"&action=removeType",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
				loadURLIntoId("/cat/organization.jsp?organization_id="+organization_id,"#Organization_"+organization_id);
			}
			resetChanges();
			
		}
	});

}
function editGenericField(id, object,field_name, divToReload, urlToLoadOnComplete,additionalData)
{
	onCompleteUrl = urlToLoadOnComplete;
	onCompleteDiv = divToReload;
	if(additionalData == null)
		additionalData = "";
	else
		additionalData = "&" + additionalData;
	
	loadModifyIntoDiv("/cat/auth/modifySystem/genericField.jsp?object="+object+"&field_name="+field_name+additionalData+"&id="+id);
	resetChanges();
}
function saveGenericField(requiredParameterArray, parameterArray)
{
	clearMessages(requiredParameterArray);
	if(checkRequired(requiredParameterArray))
	{
		
		$('#saveButton').attr("disabled","true");
		var parameters = "object=" + $("#object").val();
		parameters += readParameters(parameterArray);
		//alert(parameters);
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/modifySystem/saveGenericField.jsp",
			data: 		parameters,
			success:	function(msg) 
			{
				$("#messageDiv").html(msg);
				$("#messageDiv").show();
				if(msg.indexOf("ERROR") >=0)
				{
					alert("There was a problem saving the data! "+msg);
				}
				else
				{
					$("#messageDiv").html(msg);
					loadURLIntoId(onCompleteUrl, "#"+ onCompleteDiv);
				}
				resetChanges();
			}
		
		});
	}
}
				
	
function editCharacteristic(charId,charTypeId,command,target)
{
	if(command != 'down' && command != 'up'  && command != 'edit' && !confirm("Are you sure you want to remove this characteristic (or characteristic type)? Any assignments of this characteristic to a course or program will be removed!"))
	{
		return;
	}

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifySystem/editCharacteristic.jsp?char_id="+charId+"&charTypeId="+charTypeId+"&command="+command ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				if(command == "deleteType")
				{
					loadURLIntoId("/cat/auth/modifySystem/adminCharacteristics.jsp","#adminCharacteristics");
				}
				else
				{
					loadURLIntoId("/cat/auth/modifySystem/characteristicTypeEdit.jsp?type_id="+charTypeId,target);
				}
				$("#messageDiv").html(msg);
				resetChanges();
			}
		}
	});
}

function removeOfferingFromCourse(courseId, courseOfferingId,programId)
{
	if(!confirm("Are you sure you want to remove this offering?"))
	{
		return;
	}

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/removeOfferingFromCourse.jsp?course_offering_id="+courseOfferingId+"&program_id="+programId ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem removing the offering! "+msg);
			}
			else
			{
				loadURLIntoId("/cat/courseOfferings.jsp?course_id="+courseId+"&program_id="+programId,"#courseOfferingsDiv");
			}
			resetChanges();
		}
	});
}	

function saveContribution(linkId,programId,courseId)
{
	var contributionId = $("#contribution"+linkId).val();
	var masteryId = $("#mastery"+linkId).val();
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editOutcomeMappingProcessing.jsp?course_id="+courseId+"&program_id="+programId
						+"&action=saveCourseContribution&link_id="+linkId+"&contribution_id="+contributionId+"&mastery_id="+masteryId ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				$("#table_cell_"+linkId).css('background-color','red');
			}
			else
			{
				$("#table_cell_"+linkId).css('background-color','green');
				$("#table_cell_"+linkId).animate({ backgroundColor: "white" }, 2000);
			}
			resetChanges();
		}
	});
}

function loadCourseNumbers(id,programId)
{
	var selectBox = $("#"+id);
	
	loadURLIntoId("/cat/auth/modifyProgram/chooseCourse.jsp?subjectParameter="+selectBox.val()+"&program_id="+programId,"#courseInfoDiv");
}
function loadCourseFromSubjectAndNumber(subject,id,programId)
{
	var selectBox = $("#"+id);
	loadURLIntoId("/cat/auth/modifyProgram/chooseCourse.jsp?subjectParameter="+subject+"&courseNumberParameter="+selectBox.val()+"&program_id="+programId,"#courseInfoDiv");
}

function editGenericProgramField(id, object,field_name, divToReload, urlToLoadOnComplete,additionalData)
{
	var programId = $("#program_id").val();
	onCompleteUrl = urlToLoadOnComplete;
	onCompleteDiv = divToReload;
	if(additionalData == null)
		additionalData = "";
	else
		additionalData = "&" + additionalData;
	
	loadModifyIntoDiv("/cat/auth/modifyProgram/genericField.jsp?program_id="+programId+"&object="+object+"&field_name="+field_name+additionalData+"&id="+id);
	resetChanges();
}
function saveGenericProgramField(requiredParameterArray, parameterArray)
{
	clearMessages(requiredParameterArray);
	if(checkRequired(requiredParameterArray))
	{
		
		$('#saveButton').attr("disabled","true");
		var parameters = "object=" + $("#object").val();
		parameters += readParameters(parameterArray);
		//alert(parameters);
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/modifyProgram/saveGenericField.jsp",
			data: 		parameters,
			success:	function(msg) 
			{
				$("#messageDiv").html(msg);
				$("#messageDiv").show();
				if(msg.indexOf("ERROR") >=0)
				{
					alert("There was a problem saving the data! "+msg);
				}
				else
				{
					$("#messageDiv").html(msg);
					loadURLIntoId(onCompleteUrl, "#"+ onCompleteDiv);
				}
				resetChanges();
			}
		
		});
	}
}
function editOutcome(object,id,reloadId,action)
{
	if(!confirm("Are you sure you want to remove this value?"))
	{
		return;
	}
	var urlParam = "";
	var reloadURL = "";
	if(object=="ProgramOutcome" || object == "ProgramOutcomeGroup")
	{
		urlParam = "&program_id="+reloadId;
		reloadURL = "/cat/auth/modifyProgram/editProgramOutcomes.jsp?program_id="+reloadId;
	}
	else if(object=="OrganizationOutcome" || object == "OrganizationOutcomeGroup")
	{
		urlParam = "&organization_id="+reloadId;
		reloadURL = "/cat/auth/modifyProgram/editOrganizationOutcomes.jsp?organization_id="+reloadId;
	}
		
		
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/editOutcome.jsp?object="+object+"&id="+id+"&action="+action+urlParam ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem removing the outcome! "+msg);
			}
			else
			{
				loadModify(reloadURL);
			}
			resetChanges();
		}
	});
}
function selectTerms(which,programId)
{
	if(which == 'all')
	{
		$('[name^="termCB_"]').attr("checked",true);
		loadOutcomeMappings(programId);
	}
	else
	{
		$('[name^="termCB_"]').attr("checked",false);
	}	
	
}
function gatherAssessmentData(programId, checkboxJavascript)
{
	var checkbox = $(checkboxJavascript);
	var value = checkbox.val();
	if(checkbox.attr("checked") == "checked")
		$(value).attr('checked', true);
	else
		$(value).attr('checked', false);
	
	var parameters = "?program_id="+programId;
	var allSelected = $('.course:checkbox:checked');
	for(var i = 0; i < allSelected.length; i++)
	{
		var idString = $(allSelected[i]).val();
		var id = parseInt(idString);
		if(id > 0)
			parameters += "&course_id="+id;
	}
	parameters += getSelectedTerms();
	
	//console.log(parameters);
	loadSummaryBarGraphData(parameters);
	loadSummaryTeachingMethodBarGraphData(parameters);
	resetChanges();
}
function loadOutcomeMappings(programId)
{
	var parameters = "?program_id="+programId;
	parameters += getSelectedTerms();
	loadURLIntoId("/cat/auth/programView/summaryProgramOutcomes.jsp"+parameters , "#summaryProgramOutcomesDiv");
	gatherAssessmentData(programId);
}

function getSelectedTerms()
{
	var parameters = "";
	var allTerms = $('.termCheckbox:checked');
	
	if(allTerms.length == 0)
	{
		alert("You have no terms selected, please scroll up to just above the outcome contributions and select the terms of which you want to see graphs");
	}
	
	for(var i = 0; i < allTerms.length; i++)
	{
		var idString = $(allTerms[i]).val();
		parameters += "&term="+idString;
	}
	return parameters;
}


function loadSummaryBarGraphData(parameters)
{
	var seconds = new Date().getTime();
	$("#summaryAssessmentDiv").html('<img src="/cat/auth/programView/programCourseAssessmentData.jsp'+parameters+'&bogusParameter='+seconds+'"/>');
	$("#summaryAssessmentGroupsDiv").html('<img src="/cat/auth/programView/programAssessmentGroups.jsp'+parameters+'&bogusParameter='+seconds+'"/>');
	resetChanges();
}
function loadSummaryTeachingMethodBarGraphData(parameters)
{
	var seconds = new Date().getTime();
	$("#summaryTeachingMethodsDiv").html('<img src="/cat/auth/programView/programCourseTeachingMethodData.jsp'+parameters+'&bogusParameter='+seconds+'"/>');
	resetChanges();
}
function setProgramCourseContributionId(courseId)
{
	var programId = $("#programToSet").val();
	document.location="/cat/auth/programView/courseCharacteristicsWrapper.jsp?course_id="+courseId+"&program_id="+programId;
	resetChanges();
}
function setQuestionType(programId)
{
	var questionTypeBox = $("#question_type").get(0);
	var questionTypeSelected = questionTypeBox.options[questionTypeBox.selectedIndex].value;
	$("#question_type").val(questionTypeSelected);
	loadURLIntoId("/cat/auth/programView/availableAnswerSets.jsp?program_id="+programId+"&question_type="+questionTypeSelected , "#AnswerSetDiv");
}

function setAnswerSet(programId, answerSetId, questionType)
{
	$("#answer_set_id").val(answerSetId);
	loadURLIntoId("/cat/auth/programView/answerSet.jsp?program_id="+programId+"&question_type="+questionType+"&inUse=true&answer_set_id="+answerSetId , "#AnswerSetDiv");
}

function addQuestionToProgram(questionId,programId)
{
	$('#saveButton').attr("disabled","true");
	var parameters = "object=LinkProgramQuestion&action=add";
	parameters+="&question_id="+questionId+"&program_id="+programId;
	//alert(parameters);
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/saveProgram.jsp",
		data: 		parameters,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem adding the question! "+msg);
			}
			else
			{
				closeEdit();
				loadURLIntoId("/cat/auth/programView/programQuestions.jsp?program_id="+programId, "#programQuestionsDiv");
			}
			
			resetChanges();
		}
	
	});

}

function editAnswerOption(programId, answerSetId,answerOptionId,action,questionType)
{
	if(action == "delete")
	{
		if (!confirm("Are you sure you want to remove this option?"))
		{
			return;
		}
		else
		{
			var parameters = "answer_option_id="+answerOptionId;
			parameters+="&program_id="+programId;
			//alert(parameters);
			$.ajax({
				type: 		"post",
				url: 		"/cat/auth/modifyProgram/removeAnswerOption.jsp",
				data: 		parameters,
				success:	function(msg) 
				{
					if(msg.indexOf("ERROR") >=0)
					{
						alert("There was a problem deleting the option! "+msg);
					}
					else
					{
						loadURLIntoId("/cat/auth/programView/answerSet.jsp?program_id="+programId+"&answer_set_id="+answerSetId+"&question_type="+questionType+"&inUse=false%editMode=true", "#AnswerSetId_"+answerSetId);
						loadURLIntoId("/cat/auth/programView/answerSet.jsp?program_id="+programId+"&question_type="+questionType+"&answer_set_id="+answerSetId+"&inUse=false&editMode=true", "#AnswerSetDiv");
						
					}
					resetChanges();
				}
			
			});
		}

	}
	else
	{
		loadURLIntoId("/cat/auth/programView/editAnswerOption.jsp?program_id="+programId+"&answer_set_id="+answerSetId+"&option_id="+answerOptionId+"&question_type="+questionType, "#EditAnswerSetDiv");
		setTimeout("scrollDown()",500);
	}
}
function scrollDown()
{
	$("#outerEditDiv").animate({ scrollTop: $("#outerEditDiv").prop("scrollHeight") }, 1000);
			
}
function move(programId,type,optionId,questionType,action,setId)
{
	if(action == "delete" && !confirm("Are you sure you want to remove this question?"))
	{
		return;
	}

	var parameters = "object=MoveQuestionItem";
	parameters+="&type="+type+"&program_id="+programId+"&option_id="+optionId+"&set_id="+setId+"&action="+action;
	//alert(parameters);
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/saveProgram.jsp",
		data: 		parameters,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem with the "+action+" of the item! "+msg);
			}
			else
			{
				if(type == "question")
					loadURLIntoId("/cat/auth/programView/programQuestions.jsp?program_id="+programId, "#programQuestionsDiv");
				else if(type == "answerOption")
					loadURLIntoId("/cat/auth/programView/answerSet.jsp?program_id="+programId+"&question_type="+questionType+"&answer_set_id="+setId+"&inUse=false&editMode=true", "#AnswerSetDiv");
			}
			
			resetChanges();
		}
	
	});
	
}

function deleteQuestion(programId, questionId)
{
	if(!confirm("Are you sure you want to remove this question from the library?"))
	{
		return;
	}

	var parameters = "object=DeleteLibraryQuestion";
	parameters+="&program_id="+programId+"&question_id="+questionId;
	//alert(parameters);
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifyProgram/saveProgram.jsp",
		data: 		parameters,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem deleting the question! "+msg);
			}
			else
			{
				loadURLIntoId("/cat/auth/programView/questionLibrary.jsp?program_id="+programId, "#questionLibraryDiv");
			}
			
			resetChanges();
		}
	
	});
	
}
	

