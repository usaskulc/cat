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


function saveOffering(requiredParameterArray, parameterArray,type)
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
		parameters += readParameters(parameterArray);
		if(object == "LinkCourseOfferingAssessmentMethod")
		{
			$("[name^='additionalQuestions_']").each(function(index) {
				if(($(this).is("input:checkbox") || $(this).is("input:radio")) && $(this).attr("checked")!= null && $(this).attr("checked") == "checked")
				{
					parameters += "&additionalQuestionAnswer=" + $(this).val();
				}
				else if($(this).is("select"))
				{
					parameters += "&additionalQuestionAnswer=" + $(this).val();
				}
			});
			$("[name^='criterion_exists']").each(function(index) {
				if($(this).is("input:radio") && $(this).attr("checked")!= null && $(this).attr("checked") == "checked")
				{
					parameters += "&criterion_exists=" + $(this).val();
				}
			});
			$("[name^='criterion_completed']").each(function(index) {
				if($(this).is("input:radio") && $(this).attr("checked")!= null && $(this).attr("checked") == "checked")
				{
					parameters += "&criterion_completed=" + $(this).val();
				}
			});
			$("[name^='criterion_submitted']").each(function(index) {
				if($(this).is("input:radio") && $(this).attr("checked")!= null && $(this).attr("checked") == "checked")
				{
					parameters += "&criterion_submitted=" + $(this).val();
				}
			});
			var assessmentLinkId =  $("#assessment_link_id").val();
			if(assessmentLinkId != null)
				parameters+= "&assessment_link_id="+assessmentLinkId;
		}
		else if (object == 'Questions')	
		{
			var courseOfferingId = $("#course_offering_id").val();
			var programId = $("#program_id").val();
			var idFilter = "[name^='"+programId+"_"+courseOfferingId+"_']"
			parameters += "&program_id="+programId+"&course_offering_id="+courseOfferingId;
			$(idFilter).each(function(index) {
				if(($(this).is("input:checkbox") || $(this).is("input:radio")) && $(this).attr("checked")!= null && $(this).attr("checked") == "checked")
				{
					parameters += "&"+$(this).attr('name') + "=" + $(this).val();
				}
				else if($(this).is("select"))
				{
					parameters += "&"+$(this).attr('name') + "=" + $(this).val();
				}
				else if($(this).is("textarea"))
				{
					var text = $(this).val();
					if (text != null && text.trim().length > 0)
						parameters += "&"+$(this).attr('name') + "=" + escape(text);
				}
			
			});
			//console.log(parameters);
		}
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/courseOffering/saveCourseOffering.jsp",
			data: 		parameters,
			success:	function(msg) 
			{
				$('#saveButton').removeAttr("disabled");
				$("#messageDiv").show();
				
				if (object != 'Questions')	
					setTimeout("clearMessage();",2500);
				else
					setTimeout("clearMessage();",5000);
					
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
				var organizationId = $("#organization_id").val();
				if(object == "LinkCourseOfferingAssessmentMethod")
				{
					var courseOfferingId = $("#course_offering_id").val();
					loadURLIntoId("/cat/auth/courseOffering/assessmentMethods.jsp?course_offering_id="+courseOfferingId,"#assessmentMethodsDiv");
				//	loadURLIntoId("/cat/auth/courseOffering/assessmentMethodGroups.jsp?course_offering_id="+courseOfferingId,"#assessmentMethodGroupsDiv");
					
				//	openDiv('assessmentMethodsBargraphDiv');
					//loadBarGraphData(courseOfferingId);
					//loadURLIntoId("/cat/auth/courseOffering/assessmentMethodBargraph.jsp?course_offering_id="+courseOfferingId,"#assessmentMethodsBargraphDiv");
					//setTimeout("drawGraphs();", 1000);
					
				}
				else if(object == "CourseOfferingOutcome")
				{
					var courseOfferingId = $("#course_offering_id").val();
					loadURLIntoId("/cat/auth/courseOffering/outcomes.jsp?organization_id="+organizationId+"&course_offering_id="+courseOfferingId,"#outcomesDiv");
					loadURLIntoId("/cat/auth/courseOffering/outcomesMapping.jsp?course_offering_id="+courseOfferingId,"#outcomesMappingDiv");
					
				}
				else if(object == "CourseOfferingComments")
				{
					var courseOfferingId = $("#course_offering_id").val();
					var type = $('#commentType').val();
					
					if( type != null && type=="teaching_comment")
						loadURLIntoId("/cat/auth/courseOffering/editableTeachingMethods.jsp?course_offering_id="+courseOfferingId,"#editableTeachingMethodsDiv");
					else if( type != null && type=="contribution_comment")
						loadURLIntoId("/cat/auth/courseOffering/programOutcomeContributions.jsp?course_offering_id="+courseOfferingId,"#programOutcomeContributionsDiv");
					else if( type != null && type=="outcome_comment")
						loadURLIntoId("/cat/auth/courseOffering/outcomesMapping.jsp?course_offering_id="+courseOfferingId,"#outcomesMappingDiv");
					else
						loadURLIntoId("/cat/auth/courseOffering/comments.jsp?course_offering_id="+courseOfferingId,"#courseOfferingCommentsDiv");
			
				}
				else if(object == "NewCourseOutcome")
				{
					var courseOfferingId = $("#course_offering_id").val();
					var newOutcomeName = $("#newOutcomeName").val();
					if(courseOfferingId != null && courseOfferingId.length > 0)
					{
						var charId = $("#char_id").val();
						loadURLIntoId("/cat/auth/courseOffering/addOutcome.jsp?organization_id="+organizationId+"&course_offering_id="+courseOfferingId+"&char_id="+charId+"&outcome="+escape(newOutcomeName),"#editDiv");
					}
					else
					{
						loadURLIntoId("/cat/auth/courseOffering/programOutcome.jsp?program_id="+programId+"&outcome="+escape(newOutcomeName),"#editDiv");
					}
				}
				else if (object == "EditCourseOutcome")
				{
					var deptId = $("#organization_id").val();
					loadModify("/cat/auth/courseOffering/organization.jsp?organization_id="+deptId);
				}				
				else if(object=="CourseOutcomeProgramOutcome")
				{
					var courseOfferingId = $("#course_offering_id").val();
					var programOutcomeId = $("#program_outcome_id").val();
					
					loadURLIntoId("/cat/auth/courseOffering/outcomesMapping.jsp?course_offering_id="+courseOfferingId,"#outcomesMappingDiv");
			
				}
				
				if(object!="EditCourseOutcome" && object != "NewCourseOutcome" && object != 'LinkCourseOfferingAssessmentMethod' && object != 'CourseOfferingOutcome' && object!="CourseOutcomeProgramOutcome")
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
function showMoreAssessmentInfo(id,courseOfferingId)
{
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/additionalAssessmentInfo.jsp?link_id="+id+"&&course_offering_id="+courseOfferingId,
		success:	function(msg) 
		{
			$("#additionalAssessmentInfo_"+id).html(msg);
			$("#additionalAssessmentInfo_"+id).show();
			resetChanges();
		}
	});

}

function editOutcomeAssessment(courseOfferingId, linkToDelete)
{
	if(linkToDelete > 0 && !confirm("Are you sure you want to remove the Link between the Course Learning Outcome and the Assessment?"))
	{
		return;
	}

	var outcomeId = $("#new_course_outcome").val();
	var assessmentLinkId = $("#new_assessment_link").val();
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/editOutcomeAssessmentLink.jsp?link_to_delete="+linkToDelete+"&outcome_id="+outcomeId+"&assessment_link_id="+assessmentLinkId+"&course_offering_id="+courseOfferingId,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert(msg);
			}
			else
			{
				loadURLIntoId("/cat/auth/courseOffering/outcomeAssessmentMapping.jsp?course_offering_id="+courseOfferingId,"#outcomeAssessmentMappingDiv");
			}
			resetChanges();
		}
	});

}

function deleteOutcomeMapping(courseOfferingId,programOutcomeId,existingLinkId)
{
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/editOutcomeMappingProcessing.jsp?course_offering_id="+courseOfferingId+"&link_id="+existingLinkId+"&action=deleteLink",
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem deleting Course Outcome link! "+msg);
			}
			else
			{
				loadModify('/cat/auth/courseOffering/editOutcomeMapping.jsp?course_offering_id='+courseOfferingId+'&program_outcome_id='+programOutcomeId);
				loadURLIntoId("/cat/auth/courseOffering/outcomesMapping.jsp?course_offering_id="+courseOfferingId,"#outcomesMappingDiv");
			}
			resetChanges();
		}
	});


}

function exportDataFrom(fromOfferingId,programId)
{
	var targetOfferingId = $("#exportOfferingId").val();
	$('#exportButton').attr("disabled","true");
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/saveCourseOffering.jsp?object=ExportOfferingData&course_offering_id="+fromOfferingId+"&to="+targetOfferingId+"&program_id="+programId,
		success:	function(msg) 
		{
			$("#messageDiv").html(msg);
			$("#messageDiv").show();
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem exporting the data! "+msg);
			}
			else
			{
				$("#messageDiv").html(msg);
				$('#exportOfferingId')
				    .find(targetOfferingId)
				    .remove();
			}
			$('#exportButton').removeAttr("disabled");
			resetChanges();
		}
	});
}


function saveNewAssessmentMethod(course_offering_id,requiredParameterArray, parameterArray)
{
	clearMessages(requiredParameterArray);
	if(checkRequired(requiredParameterArray))
	{
		$('#saveNewAssessmentMethodButton').attr("disabled","true");
		var object = "AssessmentMethod";
		var parameters = "object=" + object;
		parameters += readParameters(parameterArray);
		
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/courseOffering/saveCourseOffering.jsp",
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
				var name=$("#newAssessmentMethodName").val();
				
				var courseOfferingId = $("#course_offering_id").val();
				loadURLIntoId("/cat/auth/courseOffering/editAssessmentMethods.jsp?course_offering_id="+courseOfferingId+"&name="+escape(name),"#editDiv");
				//loadURLIntoId("/cat/auth/courseOffering/assessmentMethodBargraph.jsp?course_offering_id="+courseOfferingId,"#assessmentMethodsBargraphDiv");
			//	openDiv('assessmentMethodsBargraphDiv');
			//	loadBarGraphData(course_offering_id);
				$('#saveNewAssessmentMethodButton').removeAttr("disabled");
				resetChanges();
			}
		});
	}
}
function loadBarGraphData(courseOfferingId)
{
	var seconds = new Date().getTime();
	$("#assessmentMethodsBargraphDiv").html('<img src="/cat/auth/courseOffering/assessmentMethodBargraph.jsp?course_offering_id='+courseOfferingId+'&bogusParameter='+seconds+'"/>');
	$("#assessmentMethodGroupsDiv").html('<img src="/cat/auth/courseOffering/assessmentMethodGroups.jsp?course_offering_id='+courseOfferingId+'&time='+seconds+'"/>');
	resetChanges();
}
function saveNewTeachingMethod(course_offering_id,requiredParameterArray, parameterArray)
{
	//console.log("1");
	
	clearMessages(requiredParameterArray);
	//console.log("2");
	
	if(checkRequired(requiredParameterArray))
	{
		//console.log("3");
		
		$('#saveNewTeachingMethodButton').attr("disabled","true");
		var object = "TeachingMethod";
		var parameters = "object=" + object;
		parameters += readParameters(parameterArray);
		
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/courseOffering/saveCourseOffering.jsp",
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
				var name=$("#newTeachingMethodName").val();
				
				var courseOfferingId = $("#course_offering_id").val();
				loadURLIntoId("/cat/auth/courseOffering/editTeachingMethods.jsp?course_offering_id="+courseOfferingId,"#editDiv");
				$('#saveNewTeachingMethodButton').removeAttr("disabled");
				resetChanges();
			}
		});
	}
}
function editTeachingMethod(offeringId, teachingMethodId,selectBox)
{
	var howLongId = selectBox.options[selectBox.selectedIndex].value;
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/editCourseOfferingTeachingMethod.jsp?course_offering_id="+offeringId+"&teaching_method_id="+teachingMethodId+"&how_long_id="+howLongId ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				$("#teachingMethodMessage"+teachingMethodId).html(msg);
			}
			else
			{
				var div =$("#teachingMethodMessage"+teachingMethodId);
				div.html(msg);
				div.show();
				loadTeachingMethodsBarGraphData(offeringId);
				div.fadeOut(1000);
			}
			resetChanges();
		}
	});
}
function loadTeachingMethodsBarGraphData(courseOfferingId)
{
	var seconds = new Date().getTime();

	$("#teachingMethodsGraphDiv").html('<img src="/cat/auth/courseOffering/teachingMethodsBargraph.jsp?course_offering_id='+courseOfferingId+'&time='+seconds+'"/>');
	resetChanges();
}

function removeAssessmentMethod(link_id,course_offering_id)
{
	if(!confirm("Are you sure you want to remove the Assessment Method?"))
	{
		return;
	}

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/removeAssessmentMethod.jsp?link_id="+link_id+"&course_offering_id="+course_offering_id,
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
				//loadURLIntoId("/cat/auth/courseOffering/assessmentMethodGroups.jsp?course_offering_id="+course_offering_id,"#assessmentMethodGroupsDiv");
				
				loadBarGraphData(course_offering_id);
				
				//loadURLIntoId("/cat/auth/courseOffering/assessmentMethodBargraph.jsp?course_offering_id="+course_offering_id,"#assessmentMethodsBargraphDiv");
				
				//setTimeout("drawGraphs();",1000);
			}
			loadURLIntoId("/cat/auth/courseOffering/assessmentMethods.jsp?course_offering_id="+course_offering_id,"#assessmentMethodsDiv");
			resetChanges();
			
		}
	});

}
function removeCourseOfferingOutcome(course_offering_id,outcome_id)
{
	if(!confirm("Are you sure you want to remove the Course Outcome ?"))
	{
		return;
	}
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/removeCourseOutcome.jsp?course_offering_id="+course_offering_id+"&outcome_id="+outcome_id,
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
			loadURLIntoId("/cat/auth/courseOffering/outcomes.jsp?course_offering_id="+course_offering_id,"#outcomesDiv");
			loadURLIntoId("/cat/auth/courseOffering/outcomesMapping.jsp?course_offering_id="+course_offering_id,"#outcomesMappingDiv");
			resetChanges();
			
		}
	});

}

function addCharacteristicToOrganization(charId, deptId)
{
	$("#"+toReloadDiv).show();
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/addCharacteristicToOrganization.jsp?charId="+charId+"&organization_id="+deptId ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				loadURLIntoId("/cat/auth/courseOffering/organization.jsp?organization_id="+deptId,"#editDiv");
				$("#messageDiv").html(msg);
			}
			resetChanges();
	//$(id).html(msg);
		}
	});

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
			}
			resetChanges();
		}
	});
}
function moveCharacteristicType(organizationId,charTypeId,direction)
{
	if(direction != 'down' && direction != 'up' && !confirm("Are you sure you want to remove this characteristic? Any assignments of this characteristic of this type to a course offering will be removed!"))
	{
		return;
	}

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/moveCharacteristicType.jsp?organization_id="+organizationId+"&charTypeId="+charTypeId+"&direction="+direction ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				loadURLIntoId("/cat/auth/courseOffering/organizationCharacteristics.jsp?organization_id="+organizationId,"#organizationCharacteristicsDiv");
				$("#messageDiv").html(msg);
			}
			resetChanges();
		}
	});
}

function moveOutcome(toMoveId,courseOfferingId,direction)
{
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/moveOutcome.jsp?course_offering_id="+courseOfferingId+"&outcome_id="+toMoveId+"&direction="+direction ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				loadURLIntoId("/cat/auth/courseOffering/outcomes.jsp?course_offering_id="+courseOfferingId,"#outcomesDiv");
				$("#messageDiv").html(msg);
			}
			resetChanges();
		}
	});
}
function setProgramId(courseOfferingId)
{
	var programId = $("#programToSet").val();
	loadURLIntoId("/cat/auth/courseOffering/outcomesMapping.jsp?course_offering_id="+courseOfferingId+"&program_id="+programId,"#outcomesMappingDiv");
	resetChanges();
}
function setProgramContributionId(courseOfferingId)
{
	var programId = $("#programToSet").val();
	loadURLIntoId("/cat/auth/courseOffering/programOutcomeContributions.jsp?course_offering_id="+courseOfferingId+"&program_id="+programId,"#programOutcomeContributionsDiv");
	resetChanges();
}
function setProgramStartId(courseOfferingId)
{
	var programId = $("#programToSet").val();
	document.location="/cat/auth/courseOffering/characteristicsStart.jsp?course_offering_id="+courseOfferingId+"&program_id="+programId;
	resetChanges();
}
function setProgramIdQuestions(courseOfferingId)
{
	var programId = $("#programToSet").val();
	loadURLIntoId("/cat/auth/courseOffering/completionTime.jsp?course_offering_id="+courseOfferingId+"&program_id="+programId,"#completionTimeDiv");
	resetChanges();
}
function processContributionChange(courseOfferingId, programOutcomeId, existingLink)
{
	var outcomeSelectBox;
	if( existingLink != null)
	{
		outcomeSelectBox = $("#outcome_selected_"+existingLink).get(0);
	}
	else
	{
		outcomeSelectBox = $("#outcome_selected_" +courseOfferingId+"_"+programOutcomeId).get(0);
	}
	
	var outcomeSelected = outcomeSelectBox.options[outcomeSelectBox.selectedIndex].value;
	$.ajax({
			type: 		"post",
			url: 		"/cat/auth/courseOffering/saveCourseOffering.jsp?object=CourseOutcomeProgramOutcomeLink&course_offering_id="
				            +courseOfferingId+"&course_outcome_id="+outcomeSelected+"&program_outcome_id="+programOutcomeId+"&existing_link_id="+existingLink ,
			success:	function(msg) 
			{
				if(msg.indexOf("ERROR") >=0)
				{
					alert("There was a problem saving the data! "+msg);
				}
				else
				{
					loadURLIntoId("/cat/auth/courseOffering/courseOutcomeContributions.jsp?course_offering_id="+courseOfferingId+"&program_outcome_id="+programOutcomeId,
							   "#programOutcomeContributions_"+courseOfferingId+"_"+programOutcomeId);
					$("#messageDiv").html(msg);
				}
				resetChanges();
			}
		});
	
}

function saveOfferingContribution(linkId,programId,courseOfferingId)
{
	var contributionId = $("#contribution"+linkId).val();
	var masteryId = $("#mastery"+linkId).val();
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/courseOffering/editOfferingOutcomeMappingProcessing.jsp?course_offering_id="+courseOfferingId+"&program_id="+programId
						+"&action=saveCourseOfferingContribution&link_id="+linkId+"&contribution_id="+contributionId+"&mastery_id="+masteryId ,
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
