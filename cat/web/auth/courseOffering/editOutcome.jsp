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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,org.hibernate.validator.Length"%>
<%
int id = HTMLTools.getInt(request.getParameter("id"));
String value = "";
String deptId = request.getParameter("organization_id");
if(id >= 0)
{
	CourseOutcome outcome = OrganizationManager.instance().getCourseOutcomeById(id);
	value = outcome.getName();
}
%>

<form name="genericFieldForm" id="genericFieldForm" method="post" action="" >
	<input type="hidden" name="organization_id" id="organization_id" value="<%=deptId%>" />
	<% if(id >= 0)
		{
			%><input type="hidden" name="id" id="id" value="<%=id%>"/>
			<%
		}
		%>
	<div class="formElement">
		<div class="label">Name :</div>
		<div class="field">
			 <input type="text" size="60" maxlength="100" name="value" id="value" value="<%=value%>"/>
		</div>
		<div class="error" id="valueMessage" style="padding-left:10px;"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveOffering(new Array('value'),new Array('value','id'),'EditCourseOutcome');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		
