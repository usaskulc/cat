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


var toReloadDiv = "";
var onCompleteDiv = "";
var onCompleteUrl = "";
var doneLoading = false;
var selectedCourseId = 0;
var ulrToLoad = "";
var changeDetected = false;
function errorIfNotLoggedin()
{
	alert("Something went wrong!");
}
function loadURLIntoId(url, id, message)
{
	doneLoading = false;
	//console.log("Loading ["+url+"] into ["+id+"]");
	$.ajax({
		type: 		"post",
		url: 		url,
		success:	function(msg) 
		{
			$(id).html(msg);
			doneLoading = true;
			if(message != null)
			{
				$('#messageDiv').show();
				$('#messageDiv').html(message);
				setTimeout("clearMessage()",1000);	
			}
			
		}
	});
}


function readParameters(fieldNameArray)
{
	var parameterString = "";
	for(var i = 0; i< fieldNameArray.length ; i++)
	{
		var obj = $("#"+fieldNameArray[i]);
		//alert(fieldNameArray[i] + " "+ obj.val());
		if(obj.is("input:checkbox"))
		{
			parameterString += "&" + fieldNameArray[i] + "=" + (obj.attr("checked")=="checked");
		}
		else 
		{
			parameterString += "&" + fieldNameArray[i] + "=" + escape(cleanString(""+obj.val()));
		}
	}
	//console.log("cleaned="+parameterString);
	return parameterString;
}

function cleanString(orig)
{
	//console.log("before:"+orig);
    var s = "" + orig;

    // smart single quotes and apostrophe
    s = s.replace(/[\u2018|\u2019|\u201A]/g, "\'");
    // smart double quotes
    s = s.replace(/[\u201C|\u201D|\u201E]/g, "\"");
    // ellipsis
    s = s.replace(/\u2026/g, "...");
    // dashes
    s = s.replace(/[\u2013|\u2014]/g, "-");
    // circumflex
    s = s.replace(/\u02C6/g, "^");
    // open angle bracket
    s = s.replace(/\u2039/g, "<");
    // close angle bracket
    s = s.replace(/\u203A/g, ">");
    // spaces
    s = s.replace(/[\u02DC|\u00A0]/g, " ");
	//console.log("after:"+s);
	return s;

}
function checkRequired(fieldNameArray)
{
	//console.log("2-1");
	var allOkay = true;
	for(var i = 0; i < fieldNameArray.length ; i++)
	{
		//console.log("2-1 i="+i +" field= "+fieldNameArray[i]);
		var obj = $("#"+fieldNameArray[i]);
		if(obj.is("input:checkbox"))
		{
			//nothing to check, it's all good
		}
		else if (obj.is("select"))
		{
			var value = obj.val();
			if(value == null || value.length < 1 ) 
			{
				var messageDiv = $("#"+fieldNameArray[i]+"Message");
				messageDiv.html("Please select a value");
				messageDiv.attr('class','error');
				messageDiv.show();
				allOkay = false;
			}
		}
		else
		{
			if(obj.val() == null || obj.val().length < 1)
			{
				var messageDiv = $("#"+fieldNameArray[i]+"Message");
				messageDiv.html("Please enter a value");
				messageDiv.attr('class','error');
				messageDiv.show();
				allOkay = false;
			}
		}
	}
	return allOkay;
}

function clearMessages(requiredParameterArray)
{
	$(".error").hide();
	$("#messageDiv").html("");
	for(var i = 0; i < requiredParameterArray.length ; i++)
	{
		$("#"+requiredParameterArray[i]+"Message").html("");
	}
	
}
function clearMessage(id)
{
	if(id==null)
		id="#messageDiv";
	$(id).fadeOut(3000);
}

function loadModifyIntoDivWithReload(url,targetDiv,toReloadDivParam)
{
	toReloadDiv = toReloadDivParam;
	loadModifyIntoDiv(url,targetDiv);
}

function loadModifyIntoDiv(url,targetDiv)
{
	var target = "#"+targetDiv;
	$(target).show();
	$.ajax({
		type: 		"post",
		url: 		url,
		success:	function(msg) 
		{
			changeDetected = false;
			openEdit();
			$("#editDiv").html(msg);
			$(".error").hide();    	  
			$("input, select, textarea").change(function() {
				 changeDetected = true;
			});
			//$(target).html(msg);
		},
	 	error:function (xhr, ajaxOptions, thrownError){
			
			if(!loggedIn())
			{
				alert("You are not logged in.  Please log in first.");
			}
			else
			{
				alert("Something went wrong during processing ! Please try to reload the page and try again.");
			}
	 		
	 
     }    
	});
}
function toggleTerms(term)
{
	if($("#"+term+"checkbox").attr("checked")=="checked")
	{
		$(".Term_"+term).show();
	}
	else
	{
		$(".Term_"+term).hide();
	}	
}


function loggedIn()
{
	return $("#loginStatus").html().indexOf("logged in as") > -1;
}

function loadModify(url)
{
	loadModifyIntoDiv(url,"modifyDiv");
}
function openDiv(id)
{
	$("#"+id).show();
	if(id=="newAssessmentMethodDiv")
		$("#outerEditDiv").animate({ scrollTop: $("#outerEditDiv").prop("scrollHeight") }, 1000);
	
	
	//document.getElementById(id).scrollIntoView(true);
}
function hideDiv(id)
{
	$("#"+id).hide();
}
function updateLoginStatus()
{	
	if(!loggedIn())
	{
		window.location.reload(); 
	}
	//loadURLIntoId("/cat/login.jsp","#loginStatus");
}
function logout()
{
	
	window.open("/cat/logout.jsp");
	setTimeout('document.location="/cat/logout.jsp"',1000);
}
function updateLoginStatusAfterlogout()
{
	window.location="/cat/auth/myCourses.jsp";
	//window.location.reload(); 
	//loadURLIntoId("/cat/login.jsp","#loginStatus");
}
function openEdit()
{
	var text = "";
	$("#outerEditDiv").show();
	var scrollY = getScrollY();
	$("#outerEditDiv").css("top",getScrollY()+50);
	
	$("#outerEditDiv").width($(window).width()-200);
	$("#outerEditDiv").height($(window).height()-100);

	$("#closeLinkDiv").css("top", scrollY+50);
    $("#closeLinkDiv").css("left",$(window).width()-160);
    $("#closeLinkDiv").css("width",100);
    $("#closeLinkDiv").show();
	var disable = $("#disableDiv");
	disable.height($(document).innerHeight());
	disable.width($(document).innerWidth());
	disable.css("left","0px");
	disable.css("top","0px");
	disable.show();
	//console.log("Window height = "+$(window).height() + " offset = "+window.pageYOffset+" document height = "+$(document).height());
}

function getScrollY() 
{
	  var scrOfY = 0;
	  if( typeof( window.pageYOffset ) == 'number' ) 
	  {
	    //Netscape compliant
	    scrOfY = window.pageYOffset;
	  } else if( document.body && document.body.scrollTop ) 
	  {
	    //DOM compliant
	    scrOfY = document.body.scrollTop;
	  } else if( document.documentElement && document.documentElement.scrollTop ) 
	  {
	    //IE6 standards compliant mode
	    scrOfY = document.documentElement.scrollTop;
	  }
	  return scrOfY;
}
function resetChanges()
{
	changeDetected = false;
}

function closeEdit()
{
	if(changeDetected)
	{
		if(!confirm("Any changes you have made have not been saved. Click \"Ok\" to close the window without saving, \"Cancel\" to go back without closing the windows."))
		{
			return;
		}
		changeDetected = false;
	}
	var text = "";
	$("#outerEditDiv").hide();
	$("#closeLinkDiv").hide();
	var disable = $("#disableDiv");
	disable.height(0);
	disable.width(0);
	disable.css("left","-1000px");
	disable.css("top","-1000px");
	disable.hide();
}


function toggleDisplay(id, browser)
{
	var $div = $("#" + id + "_div");
	if($div.css('display') == 'none')
	{
		$div.show(500);
		$("#" + id + "_img").attr("src","/cat/images/open_folder_" + browser + ".gif");
	}
	else
	{
		$div.hide(500);
		$("#" + id + "_img").attr("src","/cat/images/closed_folder_" + browser + ".gif");
	}
}
(function(d){d.each(["backgroundColor","borderBottomColor","borderLeftColor","borderRightColor","borderTopColor","color","outlineColor"],function(f,e){d.fx.step[e]=function(g){if(!g.colorInit){g.start=c(g.elem,e);g.end=b(g.end);g.colorInit=true}g.elem.style[e]="rgb("+[Math.max(Math.min(parseInt((g.pos*(g.end[0]-g.start[0]))+g.start[0]),255),0),Math.max(Math.min(parseInt((g.pos*(g.end[1]-g.start[1]))+g.start[1]),255),0),Math.max(Math.min(parseInt((g.pos*(g.end[2]-g.start[2]))+g.start[2]),255),0)].join(",")+")"}});function b(f){var e;if(f&&f.constructor==Array&&f.length==3){return f}if(e=/rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(f)){return[parseInt(e[1]),parseInt(e[2]),parseInt(e[3])]}if(e=/rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(f)){return[parseFloat(e[1])*2.55,parseFloat(e[2])*2.55,parseFloat(e[3])*2.55]}if(e=/#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(f)){return[parseInt(e[1],16),parseInt(e[2],16),parseInt(e[3],16)]}if(e=/#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(f)){return[parseInt(e[1]+e[1],16),parseInt(e[2]+e[2],16),parseInt(e[3]+e[3],16)]}if(e=/rgba\(0, 0, 0, 0\)/.exec(f)){return a.transparent}return a[d.trim(f).toLowerCase()]}function c(g,e){var f;do{f=d.curCSS(g,e);if(f!=""&&f!="transparent"||d.nodeName(g,"body")){break}e="backgroundColor"}while(g=g.parentNode);return b(f)}var a={aqua:[0,255,255],azure:[240,255,255],beige:[245,245,220],black:[0,0,0],blue:[0,0,255],brown:[165,42,42],cyan:[0,255,255],darkblue:[0,0,139],darkcyan:[0,139,139],darkgrey:[169,169,169],darkgreen:[0,100,0],darkkhaki:[189,183,107],darkmagenta:[139,0,139],darkolivegreen:[85,107,47],darkorange:[255,140,0],darkorchid:[153,50,204],darkred:[139,0,0],darksalmon:[233,150,122],darkviolet:[148,0,211],fuchsia:[255,0,255],gold:[255,215,0],green:[0,128,0],indigo:[75,0,130],khaki:[240,230,140],lightblue:[173,216,230],lightcyan:[224,255,255],lightgreen:[144,238,144],lightgrey:[211,211,211],lightpink:[255,182,193],lightyellow:[255,255,224],lime:[0,255,0],magenta:[255,0,255],maroon:[128,0,0],navy:[0,0,128],olive:[128,128,0],orange:[255,165,0],pink:[255,192,203],purple:[128,0,128],violet:[128,0,128],red:[255,0,0],silver:[192,192,192],white:[255,255,255],yellow:[255,255,0],transparent:[255,255,255]}})(jQuery);

