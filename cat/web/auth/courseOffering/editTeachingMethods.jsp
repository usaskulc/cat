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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));


List<TeachingMethodPortionOption> optionsList = cm.getTeachingMethodPortionOptions();
List<String> portionIds = new ArrayList<String>();
List<String> portionValues = new ArrayList<String>();
portionIds.add("-1");
portionValues.add("not used");
		
for(TeachingMethodPortionOption time : optionsList)
{
	portionIds.add(""+time.getId());
	portionValues.add(time.getName());
}

%>
<div id="addTeachingMethodDiv" >
	<form name="addTeachingMethodForm" id="teachingMethodForm" method="post" action="" >
		<table >
			<tr>
				<th>Method</th><th>description</th><th>% used</th></tr>
				<%
					List<TeachingMethod> list = cm.getAllTeachingMethods();
		
		for(TeachingMethod tm : list)
		{
			%>
			<tr>
				<td class="padded_cell">
					<%=tm.getName()%> 
				</td>
				<td class="padded_cell">
					<%=tm.getDescription()%>
				</td>
				<td>
					<%
					LinkCourseOfferingTeachingMethod existing = cm.getLinkTeachingMethodByData(courseOffering, tm);
					out.println(HTMLTools.createSelect("teachingMethod"+tm.getId(),portionIds, portionValues, existing != null? ""+existing.getHowLong().getId():null, "editTeachingMethod("+courseOffering.getId()+","+tm.getId()+",this);"));
					
				%>	
				</td>
				<td width="200px">
				<div id="teachingMethodMessage<%=tm.getId()%>" style="display:none;" class="error"></div>				
				</td>
				</tr>
		<%}
		%>

		</table>
	
	</form>
	<a href="javascript:openDiv('newTeachingMethodDiv');">Add a new teaching strategy (the one I want isn't covered by the list above)</a><hr/>
</div>
	<input type="hidden" id="course_offering_id" name="course_offering_id" value="<%=courseOfferingId%>" />
	<div id="newTeachingMethodDiv"  class="fake-input" style="display:none;">
		<hr/>
		<div class="formElement">
			<div class="label">Short name :</div>
			<div class="field">
				<input type="text" id="newTeachingMethodName" name="newTeachingMethodName" size="80" value="" />
			</div>
		</div>
		<hr/>
		<div class="formElement">
			<div class="label">Description :</div>
			<div class="field">
				<textarea id="newTeachingMethodDescription" name="newTeachingMethodDescription" cols="30" rows="5" ></textarea>
			</div>
		</div>
		<hr/>
		<div class="formElement">
			<div class="label">
				<input type="button" 
					   name="saveNewTeachingMethodButton" 
					   id="saveNewTeachingMethodButton" 
					   value="Add the new Teaching strategy to list above"
					   onclick="saveNewTeachingMethod(<%=courseOfferingId%>,Array('newTeachingMethodName'),new Array('newTeachingMethodName','newTeachingMethodDescription','course_offering_id'));" />
			</div>
			<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		</div>
</div>

