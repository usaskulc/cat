function toggleEmailEnable(id, checkboxTriggered)
{
	var checkBoxValue = checkboxTriggered.checked;
	$.ajax({
		type: 		"post",
		url: 		"ajaxProcess.jsp",
		data: 		"object=toggleEmail&id=" + id +"&selected="+checkBoxValue,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert(msg);
			}
			else
			{
				var checkboxes = $("."+id);
				for(var i=0; i < checkboxes.length ; i++)
				{
					var checkbox = checkboxes[i];
					//alert("checkbox with index "+i+" value = "+checkbox.checked+" setting to "+checkBoxValue);
					checkbox.checked = checkBoxValue;
					
				}
				var selector = "div[id^="+id+"]";
				if(msg.indexOf("true") >0)
				{
					$(selector).attr('class','selectedItem');
				}
				else
				{
					$(selector).attr('class','notSelectedItem');
				}
			}
		}
	});
}
function toggleEnabled(checkBox,id)
{
	var checkBoxValue = checkBox.checked;
	$.ajax({
		type: 		"post",
		url: 		"ajaxProcess.jsp",
		data: 		"object=toggleOffering&id=" + id +"&selected="+checkBoxValue,
		success:	function(msg) {
			if(msg.indexOf("ERROR") >=0)
			{
				alert(msg);
			}
			else
			{
				
				if(msg.indexOf("true") >0)
				{
					$('#'+id).attr('class','selectedItem');
				}
				else
				{
					$('#'+id).attr('class','notSelectedItem');
				}
			}
		}
	});
}

function selectAll()
{
	var allCheckboxes = $("input[name^=checkbox]");
	for(var i = 0; i<allCheckboxes.length ; i++)
	{
		allCheckboxes[i].checked="checked";	
	}
	$.ajax({
		type: 		"post",
		url: 		"ajaxProcess.jsp",
		data: 		"object=enableAll",
		success:	function(msg) 
		{
			$("tr[id$='offering']").attr('class','selectedItem');
		}
	});
	$('#selectAllButton').hide();
	$('#selectNoneButton').show();
}
function selectNone()
{
	var allCheckboxes = $("input[name^=checkbox]");
	for(var i = 0; i<allCheckboxes.length ; i++)
	{
		allCheckboxes[i].checked="";	
	}
	$.ajax({
		type: 		"post",
		url: 		"ajaxProcess.jsp",
		data: 		"object=disableAll",
		success:	function(msg) 
		{
			$("tr[id$='offering']").attr('class','notSelectedItem');
		}
	});
	$('#selectAllButton').show();
	$('#selectNoneButton').hide();
}
function toggleTesting()
{
	var newValue = "";
	if($("#testingEnabled").attr("checked"))
	{
		$("#notTestingDiv").hide();
		$("#testingDiv").show();
		newValue = "testingEnabled";
	}
	else if($("#testingDisabled").attr("checked"))
	{
		$("#notTestingDiv").show();
		$("#testingDiv").hide();
		newValue = "testingDisabled";
	}
	$.ajax({
		type: 		"post",
		url: 		"ajaxProcess.jsp",
		data: 		"object=sendMail&testing="+newValue,
		success:	function(msg) 
		{
			if(msg.indexOf("ERROR") >=0)
			{
				alert(msg);
			}
			else
			{
				if(msg.indexOf("done") < 0)
				{
					$('#messageDiv').html("Error processing !");
	
				}
			}
		}
	});
}
function clearMessage()
{
	$('#messageDiv').fadeOut(3000);
}
function sendMail(count)
{
	$('#messageDiv').show();
	$('#messageDiv').html("Processing...");
	$('#sendButton').attr("disabled","true");
	var to="";
	var from=$("#from").val();
	var greeting=$("#greeting").val();
	var body=$("#body").val();
	var subject=$("#subject").val();
	var send = false;
	
	if($("#testingEnabled").attr("checked"))
	{
		to = $("#toTesting").val();
		send = true;
		//don't ask for confirmation, send the testing email
	}
	else
	{
		
		if(confirm("This will send an email to "+count+" people, are you sure you want to continue? (click Ok to continue)"))
		{
			to="all";
			send = true;
		}
	}
	
	if(send)
	{
		$.ajax({
				type: 		"post",
				url: 		"ajaxProcess.jsp",
				data: 		"object=sendMail&to="+escape(to)+"&from="+escape(from)+"&greeting="+escape(greeting)+"&subject="+escape(subject)+"&body="+escape(body),
				success:	function(msg) 
				{
					if(msg.indexOf("ERROR") >=0)
					{
						alert(msg);
					}
					else
					{
						$('#messageDiv').html(msg);
					}
					$('#sendButton').removeAttr("disabled");
					setTimeout("clearMessage();",2000);
				}
		});
		
	}
	
}



