function saveSystem(requiredParameterArray, parameterArray,type)
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
		if(object=="DepartmentCourses")
		{
			$("[name^='course_number_checkbox_']").each(function(index) {
				if(($(this).is("input:checkbox") || $(this).is("input:radio")) && $(this).attr("checked")!= null && $(this).attr("checked") == "checked")
				{
					parameters += "&" + $(this).attr("name")+ "=true";
				}
			});	
		}
		
		
		parameters += readParameters(parameterArray);
		//alert(parameters);
		//alert(object);
		$.ajax({
			type: 		"post",
			url: 		"/cat/auth/modifySystem/saveSystem.jsp",
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
				var departmentId = $("#department_id").val();
				if(object == "Organization")
				{
					if(objectId != null && objectId.length > 0)
					{	
						loadURLIntoId("/cat/organization.jsp?organization_id="+objectId,"#Organization_"+objectId);
					}
					else //no id, must be a new org
					{
						loadURLIntoId("/cat/organizations.jsp","#allOrganizations");
					}
				}
				else if(object == "Program")
				{
					var organizationId = $("#organization_id").val();
					loadURLIntoId("/cat/organization.jsp?organization_id="+organizationId,"#Organization_"+organizationId);
				}
				else if(object == "DepartmentCourses")
				{
					$("#messageDiv").hide();
					$("#message2Div").show();
					$("#message2Div").html(msg);
				}
				else if(object == "Department")
				{
					loadURLIntoId("/cat/auth/modifySystem/adminDepartments.jsp","#adminDepartmentsDiv");
					
				}
				
				$('#saveButton').removeAttr("disabled");
				setTimeout("clearMessage();",500);
				if(object != "Course" && object!="NewProgramOutcome" && object!="DepartmentCourses" && object != "Department")
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


function addDepartment(name)
{
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifySystem/saveSystem.jsp?object=Department&name="+escape(name),
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem adding the department! "+msg);
			}
			else
			{
				loadURLIntoId("/cat/auth/modifySystem/chooseDepartment.jsp?departmentName="+escape(name),"#chooseDepartmentDiv");
				$("#addLdapGroupDiv").hide();
			}
			
		}
	});

}
function deleteOrganization(id)
{
	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifySystem/saveSystem.jsp?action=delete&object=Organization&id="+id,
		success:	function(msg) 
		{
			
			$("#message2Div").show();
			$('html, body').animate({
			    scrollTop: $("#message2Div").offset().top-400
			   }, 1000);
			$("#message2Div").html(msg);
			setTimeout("clearMessage('#message2Div');",5000);
			if(msg.indexOf("ERROR") >=0)
			{
			}
			else
			{
				loadURLIntoId("/cat/auth/modifySystem/accessPermissions.jsp","#accessPermissions");
			}
			
		}
	});

}

function editDepartment(id)
{
	var deptId = -1
	if(id != null)
	{
		var selectBox = $("#"+id);
		deptId = selectBox.val();
	}
	loadModify("/cat/auth/modifySystem/editDepartment.jsp?department_id="+deptId);
}
function loadDeptCourseNumbers(id,departmentId)
{
	var selectBox = $("#"+id);
	
	loadURLIntoId("/cat/auth/modifySystem/existingCourseSelector.jsp?subjectParameter="+selectBox.val()+"&department_id="+departmentId,"#assignCoursesDiv");
}
function selectCourses(which)
{
	if(which == 'all')
	{
		$('[name^="course_number_checkbox_"]').attr("checked",true);
	}
	else
	{
		$('[name^="course_number_checkbox_"]').attr("checked",false);
	}	
}
function editGenericSystemField(id, object,field_name, divToReload, urlToLoadOnComplete,additionalData)
{
	resetChanges();
	onCompleteUrl = urlToLoadOnComplete;
	onCompleteDiv = divToReload;
	if(additionalData == null)
		additionalData = "";
	else
		additionalData = "&" + additionalData;
	
	loadModifyIntoDiv("/cat/auth/modifySystem/genericField.jsp?object="+object+"&field_name="+field_name+additionalData+"&id="+id);
}
function saveSystemGenericField(requiredParameterArray, parameterArray)
{
	resetChanges();
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

function editAssessment(aId,groupId,command,target)
{
	if(command != 'group_down' && command != 'group_up' && command != 'down' && command != 'up'  && command != 'edit' && !confirm("Are you sure you want to remove this Assessment method (or Assessment Method Group)? You will not be able to delete an assement method that has already been used!"))
	{
		return;
	}

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifySystem/editAssessment.jsp?assessment_id="+aId+"&assessment_group_id="+groupId+"&command="+command ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				if(command == "group_delete" || command == "group_up" || command == "group_down")
				{
					loadURLIntoId("/cat/auth/modifySystem/assessmentMethodAdmin.jsp","#assessmentMethodAdmin");
				}
				else
				{
					loadURLIntoId("/cat/auth/modifySystem/assessmentGroupEdit.jsp?assessment_group_id="+groupId,target);
				}
				$("#messageDiv").html(msg);
				resetChanges();
			}
		}
	});
}

function modifyPermission(programId,organizationId,type,name,command, permission_id)
{
	if(command != 'add' && !confirm("Are you sure you want to remove this permission?"))
	{
		return;
	}

	$.ajax({
		type: 		"post",
		url: 		"/cat/auth/modifySystem/editPermission.jsp?program_id="+programId+"&organization_id="+organizationId+"&type="+type+"&name="+escape(name)+"&command="+command+"&permission_id="+permission_id ,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert("There was a problem saving the data! "+msg);
			}
			else
			{
				if(programId=="-1" && organizationId == "-1")
				{
					loadURLIntoId("/cat/auth/modifySystem/systemPermissions.jsp","#editDiv",msg);
				}
				else if(programId != "-1")
				{
					loadURLIntoId("/cat/auth/modifySystem/programPermissions.jsp?program_id="+programId,"#editDiv",msg);
				}
				else
				{
					loadURLIntoId("/cat/auth/modifySystem/organizationPermissions.jsp?organization_id="+organizationId,"#editDiv",msg);
						
				}
				resetChanges();
			}
		}
	});
}
