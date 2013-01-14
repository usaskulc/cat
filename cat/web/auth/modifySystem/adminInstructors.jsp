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

