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
 Five types of instructional method are identified in the first column 
 with example strategies for each method in the middle column. 
 Please use the pull down menus in the last column to indicate 
 how often you use each instructional method in this course. 
 Below a bar graph will display your distribution of instructional strategies for this course.
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
	
	</form>
</div>
<div id="teachingMethodsGraphDiv" style="width:600px;height:300px;">
	<img src="/cat/auth/courseOffering/teachingMethodsBargraph.jsp?course_offering_id=<%=courseOffering.getId()%>"/>
</div>
