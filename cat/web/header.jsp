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


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.*,ca.usask.ocd.ldap.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%> 
<%
StringBuilder parameters = new StringBuilder();
Enumeration e = request.getParameterNames();
while(e.hasMoreElements())
{
	String pName = (String)e.nextElement();
	if(pName.equals("ticket")) //don't include possible invalid tickets
		continue;
	
	if(parameters.length()==0)
	{
		parameters.append("?");
	}
	else
	{
		parameters.append("&");
	}
	
	String value = request.getParameter(pName);
	parameters.append(pName);
	parameters.append("=");
	parameters.append(value);
}
int programIdParameter = HTMLTools.getInt(request.getParameter("program_id"));
if(programIdParameter > -1)
{
	session.setAttribute("programId",""+programIdParameter);
}
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = true;
String userid=(String)session.getAttribute("edu.yale.its.tp.cas.client.filter.user");
List<Organization> organizations = PermissionsManager.instance().getOrganizationsForUser(userid, sysadmin,true);

String clientBrowser=request.getHeader("User-Agent");
//simplify the client browser
if(clientBrowser.indexOf("Mac")>-1)
	clientBrowser="mac";
else if (clientBrowser.indexOf("Linux")>-1)
	clientBrowser="linux";
else
	clientBrowser="windows";


%>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
	<head>
		<title>Curriculum Alignment Tool</title>
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/> 
		<meta content="IE=9" http-equiv="X-UA-Compatible"/>
        <meta content="IE=8" http-equiv="X-UA-Compatible"/>
 
 
 
    	<link href="http://www.usask.ca/favicon.ico" rel="apple-touch-icon"/>
    	<link href="http://www.usask.ca/favicon.ico" rel="shortcut icon"/>
    	<link href="/cat/resources/default.css" media="screen" rel="stylesheet" type="text/css"/>
 	   	<link href="/cat/resources/print.css" media="print" rel="stylesheet" type="text/css"/>
 		<!--<script src="/cat/resources/scriptaculous.js" type="text/javascript"></script> -->
		<!-- <script type="text/javascript" src="/cat/resources/effects.js"></script> -->
		<!-- <script type="text/javascript" src="/cat/resources/builder.js"></script >-->
		<!-- <script src="/cat/resources/ui.js" type="text/javascript"></script> -->
		<link href="/cat/standard.css" rel="stylesheet" type="text/css"/>
		<script src="/cat/included/jquery-1.7.1.min.js" type="text/javascript"></script>
	
		<script  type="text/javascript">
		var clientBrowser = '<%=clientBrowser%>';
		$(document).ready(function() {
			  // Handler for .ready() called.
	
 //deactivate menu items if something other
	//than a menu item is clicked
	$("html").click(function()
	{
/*		$(".drop-down-menu").each(function()
       {
			$(this).removeClass('active');
			$(this).find(".submenu").hide();
       });*/
	});


	//do not deactivate menus if the user
	//clicks on the menu itself
	$('#main-menu').click(function(event)
	{
		event.stopPropagation();
	});



	//on click deactivate all menus and activate
	//the one clicked on unless its alread active then
	//deactivate it
   $(".drop-down-menu").click(function()
   {
		var clicked = $(this);
		//reset all menus to default status except the clicked one
       $(".drop-down-menu").each(function()
       {
			var current = $(this);

			//check to ensure that the current menu is not the clicked menu
			if (clicked.length !== current.length || clicked.length !==
clicked.filter(current).length)
			{
				$(this).removeClass('active');
				$(this).find(".submenu").hide();
			}
       });

    	//if the clicked menu is active then deactivate it otherwise activate it
		if ($(this).hasClass('active'))
		{
			$(this).removeClass("active");
			$(this).find(".submenu").hide();
		}
		else
		{
			$(this).addClass("active");
			$(this).find(".submenu").show();
		}
	});
		});
	</script>
		
		
		<script src="/cat/js/global_lib.js" type="text/javascript"></script>
		<script src="/cat/js/system_lib.js" type="text/javascript"></script>
		<script src="/cat/js/program_lib.js" type="text/javascript"></script>
		<script src="/cat/js/offering_lib.js" type="text/javascript"></script>
		
	</head>
	<body>
		<div id="header">
			<div class="wrapper">
				<p id="uofs">
					<a href="http://www.usask.ca/" title="University of Saskatchewan">
						<img alt="University of Saskatchewan" src="/cat/resources/uofs-logo.png"/>
					</a>
				</p>
				<ul id="secondary-nav">
					<li class="paws-login"><a href="http://paws.usask.ca/">PAWS</a></li>
				</ul>
				<div id="search-options">
					<form action="http://www.usask.ca/search/" id="cse-search-box"><fieldset><legend class="hidden">Search</legend>
						<label class="hidden" for="q">Search:</label>
						<input class="search-box" id="q" name="q" size="20" type="text"/>
						<button class="submit" type="submit">Search</button></fieldset>
					</form>
				</div>
				<h1 id="site-name"><a href="index.jsp">Curriculum Alignment Tool</a></h1> 
				<div style="float:right;position:relative;top:-40px;left:-5px;" id="loginStatus"><jsp:include page="/login.jsp"> <jsp:param name="url" value="<%=request.getRequestURI() + parameters.toString()%>"/></jsp:include></div>
			</div>
		</div>
		<div id="global-nav">
		  	<div class="wrapper">
		  		<ul >
		  			<li><a href="/cat/auth/myCourses.jsp">My Courses</a></li>
		  			<%if(organizations!=null && !organizations.isEmpty()){ 
		  				%>
		  				<li class="drop-down-menu"><a href="#">Characteristics Admin</a>
		  					<ul style="display: none;" class="submenu">
		  					<%
		  					for(Organization organization:organizations){%>
		  						<li><a href="javascript:loadModify('/cat/auth/courseOffering/organization.jsp?organization_id=<%=organization.getId()%>');"><%=organization.getName()%></a></li> 
		  					<%}
		  					%>
		  					</ul>
		  				</li>
		  				<%}%>
		  			<li><a href="/cat/organizationsWrapper.jsp">Program Admin</a></li>
		  			<%if(sysadmin){%>
		  			<li><a href="/cat/auth/modifySystem/admin.jsp">System Admin</a></li>
		  			<%} %>
		  			
		  			
				</ul>
			</div>
		</div>
		<div  class="headerBar" id="closeLinkDiv"><a href="javascript:closeEdit();" id="closeLink" >Close <img src="/cat/images/closer.png" style="padding-right:5px;padding-top:5px;"/></a></div>
		
		<div class="editFloat" id="outerEditDiv">
			
			<div id="editDiv" >
			
			</div>
			<!-- <div  class="footerBar"><a href="javascript:closeEdit();" id="closeLink2" >Close <img src="/cat/images/closer.png" style="padding-right:5px;padding-bottom:0px;"/></a></div> -->
		
		</div>
		<div class="disableEverything" id="disableDiv"></div>
		
	
