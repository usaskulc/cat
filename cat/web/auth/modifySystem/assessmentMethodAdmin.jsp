<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
CourseManager cm = CourseManager.instance();
List<AssessmentGroup> allGroups = cm.getAssessmentGroups();
%>
<h2>Available assessment methods:</h2>
<ul>
<%

for(int i = 0; i< allGroups.size(); i++)
{
	AssessmentGroup group = allGroups.get(i);
	%>
	
	<li><div id="assessment_group_<%=group.getId()%>" >
		<jsp:include page="assessmentGroupEdit.jsp" >
			<jsp:param value="<%=i==0%>"  name="first"/>
			<jsp:param value="<%=i==(allGroups.size()-1)%>"  name="last"/>
			<jsp:param value="<%=group.getId()%>" name="assessment_group_id"/>
		</jsp:include>
		</div>
	</li>
	<%
}%>
	<li>
		<a href="javascript:editGenericSystemField('','AssessmentGroup','name','assessmentMethodAdmin','assessmentMethodAdmin.jsp');">
	 	Create new assessment group
		</a>
	</li>
</ul>


		