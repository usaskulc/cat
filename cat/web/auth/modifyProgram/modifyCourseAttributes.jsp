<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<div id="content" style="overflow:auto;"> 
<%
int programId = HTMLTools.getInt( request.getParameter("program_id"));
int courseId = HTMLTools.getInt(request.getParameter("course_id"));

CourseManager manager = CourseManager.instance();

List<CourseAttribute> attrTypes = manager.getCourseAttributes(programId);

List<CourseAttributeValue> attrValues = manager.getCourseAttributeValues(courseId, programId);

for(CourseAttribute attrType: attrTypes)
{
	%>
	Attributes of type : <%=attrType.getName()%>
	<ul>
	<%
	for(CourseAttributeValue av : attrValues)
	{
		if(av.getAttribute().getId() == attrType.getId())
		{
			%>
			<li><%=av.getValue()%>
				<a href="javascript:loadModify('/cat/auth/modifyProgram/addCourseAttributeValue.jsp?program_id=<%=programId%>&attribute_value_id=<%=av.getId()%>&course_id=<%=courseId%>');"><img src="/cat/images/edit_16.gif" alt="Edit course attribute" title="Edit course attribute"></a>
				<a href="javascript:removeCourseAttributeValue(<%=av.getId()%>,<%=programId%>,<%=courseId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove course attribute" title="Remove course attribute" ></a>
			</li>
			<%
		}
	}
	%>
	<li><a href="javascript:loadModify('/cat/auth/modifyProgram/addCourseAttributeValue.jsp?program_id=<%=programId%>&attribute_id=<%=attrType.getId()%>&course_id=<%=courseId%>');" class="smaller">Add <%=attrType.getName()%></a></li>
	</ul>
	<%
}
%>
	</div>	