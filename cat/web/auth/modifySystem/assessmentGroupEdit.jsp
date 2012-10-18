<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*, ca.usask.gmcte.util.*"%>
<%
CourseManager cm = CourseManager.instance();
int groupId = HTMLTools.getInt( request.getParameter("assessment_group_id"));
AssessmentGroup group = cm.getAssessmentGroupById(groupId); 
boolean first = request.getParameter("first") != null && Boolean.parseBoolean(request.getParameter("first"));
boolean last = request.getParameter("first") != null && Boolean.parseBoolean(request.getParameter("last"));

%>
	<%=group.getName()%>  
			<a href="javascript:editGenericSystemField(<%=group.getId()%>,'AssessmentGroup','name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit Name" alt="Edit Name"/></a>
	<%=group.getShortName()%>  
			<a href="javascript:editGenericSystemField(<%=group.getId()%>,'AssessmentGroup','short_name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit Short Name" alt="Edit Short Name"/></a>
	
	  		<%
	  			if(!first)
				{%>
					<a href="javascript:editAssessment(-1,<%=group.getId()%>,'group_up','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/up2.gif"  alt="Move Up"/></a><%
				}
				if(!last)
				{%>
					<a href="javascript:editAssessment(-1,<%=group.getId()%>,'group_down','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/down2.gif"  alt="Move Down"/></a><%
				}%>
	  		
	  		<a href="javascript:editAssessment(<%=group.getId()%>,<%=group.getId()%>,'group_delete','assessment_group_<%=group.getId()%>');"><img src="/cat/images/deletes.gif" title="Delete Assessment Group" alt="Delete"/></a>
		<ul>
			<%
			List<Assessment> assessments = cm.getAssessmentsForGroup(group);
			for(int i = 0 ; i < assessments.size() ; i++ )
			{
				Assessment a = assessments.get(i);%>
				<li><span title="<%=a.getDescription()%>"><%=a.getName()%></span><a href="javascript:editGenericSystemField(<%=a.getId()%>,'Assessment','name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit Name" alt="Edit Name"/></a>
					<a href="javascript:editGenericSystemField(<%=a.getId()%>,'Assessment','description','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit Description" alt="Edit Description"/></a>
						
				<%
				if(i>0)
				{%>
					<a href="javascript:editAssessment(<%=a.getId()%>,<%=group.getId()%>,'up','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/up2.gif"  alt="Move Up"/></a><%
				}
				if(i < assessments.size()-1)
				{%>
					<a href="javascript:editAssessment(<%=a.getId()%>,<%=group.getId()%>,'down','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/down2.gif"  alt="Move Down"/></a><%
				}%>
					<a href="javascript:editAssessment(<%=a.getId()%>,<%=group.getId()%>,'delete','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/deletes.gif"  alt="Delete"/></a>
				</li><%
			}
			%>
				<li>
					<a href="javascript:editGenericSystemField('','Assessment','name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>','part_of_id=<%=group.getId()%>');" class="smaller">
					 	<img src="/cat/images/add_24.gif"  height="10px;" title="Add Assessment to group" alt="Add"/> Add Assessment to group
					</a>
				</li>
			</ul>
			
		


		