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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*, ca.usask.gmcte.util.*"%>
<%
CourseManager cm = CourseManager.instance();
int groupId = HTMLTools.getInt( request.getParameter("assessment_group_id"));
AssessmentGroup group = cm.getAssessmentGroupById(groupId); 
boolean first = request.getParameter("first") != null && Boolean.parseBoolean(request.getParameter("first"));
boolean last = request.getParameter("first") != null && Boolean.parseBoolean(request.getParameter("last"));

%>
	<%=group.getName()%>  
			<a href="javascript:editGenericSystemField(<%=group.getId()%>,'AssessmentGroup','name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit assessment group" alt="Edit assessment group"/></a>
	<%=group.getShortName()%>  
			<a href="javascript:editGenericSystemField(<%=group.getId()%>,'AssessmentGroup','short_name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"> <img src="/cat/images/edit_16.gif"  title="Edit assessment group (short version)" alt="Edit assessment group (short version)"/></a>
	
	  		<%
	  			if(!first)
				{%>
					<a href="javascript:editAssessment(-1,<%=group.getId()%>,'group_up','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/up2.gif"  alt="move up" title="move up"/></a><%
				}
				if(!last)
				{%>
					<a href="javascript:editAssessment(-1,<%=group.getId()%>,'group_down','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/down2.gif"  alt="move down" title="move down"/></a><%
				}%>
	  		
	  		<a href="javascript:editAssessment(<%=group.getId()%>,<%=group.getId()%>,'group_delete','assessment_group_<%=group.getId()%>');"><img src="/cat/images/deletes.gif" title="Delete Assessment Group" alt="Delete Assessment Group"/></a>
		<ul>
			<%
			List<Assessment> assessments = cm.getAssessmentsForGroup(group);
			for(int i = 0 ; i < assessments.size() ; i++ )
			{
				Assessment a = assessments.get(i);%>
				<li><span title="<%=a.getDescription()%>"><%=a.getName()%></span><a href="javascript:editGenericSystemField(<%=a.getId()%>,'Assessment','name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit assessment" alt="Edit assessment"/></a>
					<a href="javascript:editGenericSystemField(<%=a.getId()%>,'Assessment','description','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>');"><img src="/cat/images/edit_16.gif"  title="Edit assessment description" alt="Edit assessment description"/></a>
						
				<%
				if(i>0)
				{%>
					<a href="javascript:editAssessment(<%=a.getId()%>,<%=group.getId()%>,'up','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/up2.gif"  alt="move up" title="move up"/></a><%
				}
				if(i < assessments.size()-1)
				{%>
					<a href="javascript:editAssessment(<%=a.getId()%>,<%=group.getId()%>,'down','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/down2.gif"  alt="move down" title="move down"/></a><%
				}%>
					<a href="javascript:editAssessment(<%=a.getId()%>,<%=group.getId()%>,'delete','#assessment_group_<%=group.getId()%>');"><img src="/cat/images/deletes.gif"  alt="Delete assessment" title="Delete assessment"/></a>
				</li><%
			}
			%>
				<li>
					<a href="javascript:editGenericSystemField('','Assessment','name','assessment_group_<%=group.getId()%>','assessmentGroupEdit.jsp?assessment_group_id=<%=group.getId()%>','part_of_id=<%=group.getId()%>');" class="smaller">
					 	<img src="/cat/images/add_24.gif"  height="10px;" title="Add assessment to group" alt="Add assessment to group"/> Add assessment to group
					</a>
				</li>
			</ul>
			
		


		
