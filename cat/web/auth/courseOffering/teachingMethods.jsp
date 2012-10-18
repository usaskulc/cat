<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
@SuppressWarnings("unchecked")
String courseOfferingId = request.getParameter("course_offering_id");
boolean access = true;
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}
List<LinkCourseOfferingTeachingMethod> list = cm.getTeachingMethods(courseOffering);

%>
<h2>Teaching Strategies used</h2>
	<div>
		<table style="empty-cells:show;">
			<tr>
				<th>Strategy</th>
				<th>Description</th>
				<th> % of total meeting time used</th>
			</tr>
		
		<%
		for(LinkCourseOfferingTeachingMethod link : list)
		{
			%>
			<tr>
				<td>
					<%=link.getTeachingMethod().getName()%> 
				</td>
				<td>
					<%=link.getTeachingMethod().getDescription()%> 
				</td>
				<td>
					<%=link.getHowLong().getName()%>
				</td>
			</tr>
			<% 
		}
		if(list.isEmpty())
		{
			%>
			<tr><td colspan="2">No teaching strategies added (yet)</td></tr>
			<%
		}
		
		if(access)
		{%>
			<tr>
				<td colspan="3">
					<a href="javascript:loadModifyIntoDiv('/cat/auth/courseOffering/editTeachingMethods.jsp?course_offering_id=<%=courseOfferingId%>','addTeachingMethodDiv');" class="smaller"">
						<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Edit" >Edit
					</a>
					<hr/>
					<div id="addTeachingMethod">
					</div>
				</td>
			</tr>
		<%} %>
		</table>
		<%long time = System.currentTimeMillis(); %>
		<div id="teachingMethodsGraphDiv" style="width:550px;height:300px;">
			<img src="/cat/auth/courseOffering/teachingMethodsBargraph.jsp?size=200&course_offering_id=<%=courseOffering.getId()%>&bogus_param=<%=time%>"/>
		</div>
	</div>

