<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));


List<TeachingMethodPortionOption> optionsList = cm.getTeachingMethodPortionOptions();
List<String> portionIds = new ArrayList<String>();
List<String> portionValues = new ArrayList<String>();
portionIds.add("-1");
portionValues.add("Please select a value");
		
for(TeachingMethodPortionOption time : optionsList)
{
	portionIds.add(""+time.getId());
	portionValues.add(time.getName());
}

%>
<div id="addTeachingMethodDiv" >
<h2>My Instructional Methods</h2>
<p>This section gathers information about how you teach this course. 
Five types of instructional methods are identified in the first column with example strategies 
for each method in the middle column. Please use the pull down menus in the last column to indicate
 the extent to which you use each instructional method in this course.
   The descriptors are not intended to be numeric.  Where you feel you use overlapping strategies, 
   you can assign those strategies the same "extent of use"" (pull down menu) description. 
    Below a bar graph will display your general distribution of instructional strategies for this course.  
    You also have the option to add information to the comment section appearing below the table.
</p>
	<form name="addTeachingMethodForm" id="teachingMethodForm" method="post" action="" >
		<table >
			<tr>
				<th>Method</th><th>Description</th><th>Extent of Use</th></tr>
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
				<br/>
				
				<div id="teachingMethodMessage<%=tm.getId()%>" style="display:none;" class="error"></div>				
				</td>
				</tr>
		<%}
		%>

		</table>
	<div id="teachingMethodComment">
		
	<%=courseOffering.getTeachingComment()==null?"No additional information entered. Select edit icon below to add additional information about your Instructional Methods.":courseOffering.getTeachingComment() %>
	
</div>
<br/>
<a href="javascript:loadModify('/cat/auth/courseOffering/editComments.jsp?course_offering_id=<%=courseOfferingId%>&type=teachingMethodComment','teachingMethodComment');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit"></a>

	</form>
</div>
<div id="teachingMethodsGraphDiv" style="width:600px;height:300px;">
	<img src="/cat/auth/courseOffering/teachingMethodsBargraph.jsp?course_offering_id=<%=courseOffering.getId()%>"/>
</div>
