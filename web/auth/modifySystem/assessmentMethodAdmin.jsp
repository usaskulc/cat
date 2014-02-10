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


		
