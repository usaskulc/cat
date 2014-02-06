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
    pageEncoding="UTF-8" import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.currimap.action.*"%>
<%
List<Instructor> instructors =  PermissionsManager.instance().getAllInstructors();
Instructor choose = new Instructor();
choose.setFirstName("Please select an instructor to edit");
choose.setUserid("");
choose.setId(0);
instructors.add(0,choose);
%>
Select an instructor from the list below (to edit the instructor) (or click "create new" to create a new instructor)


<form name="genericFieldForm" id="genericFieldForm" method="post" action="" >
	
	<div class="formElement">
		<div class="label">Instructor:</div>
		<div class="field">
			<%=HTMLTools.createSelect("instructor", instructors, "id", "InstructorDisplay", null, "editInstructor('instructor');")%>
		</div>
		<div class="error" id="new_valueMessage" style="padding-left:10px;"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button"
		           value="Create new" 
				   onclick="editInstructor();" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	
	</form>

