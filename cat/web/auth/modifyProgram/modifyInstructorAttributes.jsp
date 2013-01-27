<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<div id="content" style="overflow:auto;"> 
<%
String userid = request.getParameter("userid");
int programId = HTMLTools.getInt( request.getParameter("program_id"));
int courseId = HTMLTools.getInt(request.getParameter("course_id"));

CourseManager manager = CourseManager.instance();

List<InstructorAttribute> attrTypes = manager.getInstructorAttributes(programId);

List<InstructorAttributeValue> attrValues = manager.getInstructorAttributeValues(userid, programId);

for(InstructorAttribute attrType: attrTypes)
{
	%>
	Attributes of type : <%=attrType.getName()%>
	<ul>
	<%
	for(InstructorAttributeValue av : attrValues)
	{
		if(av.getAttribute().getId() == attrType.getId())
		{
			%>
			<li><%=av.getValue()%>
				<a href="javascript:loadModify('/cat/auth/modifyProgram/addInstructorAttributeValue.jsp?program_id=<%=programId%>&attribute_value_id=<%=av.getId()%>&userid=<%=userid%>&course_id=<%=courseId%>');"><img src="/cat/images/edit_16.gif" alt="Edit instructor attribute" title="Edit instructor attribute"></a>
				<a href="javascript:removeInstructorAttributeValue(<%=av.getId()%>,<%=programId%>,'<%=userid%>',<%=courseId%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove instructor attribute" title="Remove instructor attribute" ></a>
			</li>
			<%
		}
	}
	%>
	<li><a href="javascript:loadModify('/cat/auth/modifyProgram/addInstructorAttributeValue.jsp?program_id=<%=programId%>&attribute_id=<%=attrType.getId()%>&userid=<%=userid%>&course_id=<%=courseId%>');" class="smaller">Add <%=attrType.getName()%></a></li>
	</ul>
	<%
}
%>
	</div>	