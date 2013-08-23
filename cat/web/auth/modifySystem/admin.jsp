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


	<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
	
	<%String clientBrowser=request.getHeader("User-Agent");
	//simplify the client browser
	if(clientBrowser.indexOf("Mac")>-1)
		clientBrowser="mac";
	else if (clientBrowser.indexOf("Linux")>-1)
		clientBrowser="linux";
	else
		clientBrowser="windows";
		
	%>
<jsp:include page="/header.jsp"/>
		<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
					<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> 
						&gt; <a href="/cat">Curriculum Alignment Tool</a> &gt; System Admin </p></div>  

					<div id="administration" class="module" style="overflow:auto;">
						<a href="javascript:toggleDisplay('organizationEditSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="organizationEditSection_img">Edit/Add Organizations</a>
						<div id="organizationEditSection_div" style="display:none;">
							<div id="adminOrganizationsDiv">
								<jsp:include page="adminOrganizations.jsp"/>
							</div>
						</div>
						<hr/>
						<div id="accessPermissions">
							<jsp:include page="accessPermissions.jsp"/>
						
						</div>
						<hr/>
						<a href="javascript:toggleDisplay('characteristicSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="characteristicSection_img">Manage Characteristics</a>
						<div id="characteristicSection_div" style="display:none;">
							
							<div id="adminCharacteristics" class="module" style="overflow:auto;">
								<jsp:include page="adminCharacteristics.jsp"/>
							</div>
						</div>
						<hr/>
						<a href="javascript:toggleDisplay('assessmentSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="assessmentSection_img">Manage Assessment Methods</a>
						<div id="assessmentSection_div" style="display:none;">
						
							<div id="assessmentMethodAdmin" class="module" style="overflow:auto;">
								<jsp:include page="assessmentMethodAdmin.jsp"/>
							</div>
						</div>
						<hr/>
						<a href="javascript:toggleDisplay('instructorsSection','<%=clientBrowser%>');"><img src="/cat/images/closed_folder_<%=clientBrowser%>.gif" id="instructorsSection_img">Manage Instructors</a>
						<div id="instructorsSection_div" style="display:none;">
						
							<div id="instructorAdmin" class="module" style="overflow:auto;">
								<jsp:include page="adminInstructors.jsp"/>
							</div>
						</div>

						
					</div>
				</div>
			</div>
		</div>


<jsp:include page="/footer.jsp"/>		
