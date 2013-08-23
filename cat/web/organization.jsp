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


<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%> 
<%
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
String id  = request.getParameter("organization_id");
OrganizationManager manager = OrganizationManager.instance();
Organization o = manager.getOrganizationById(Integer.parseInt(id));
Organization parent = o.getParentOrganization();
@SuppressWarnings("unchecked")
HashMap<String,Organization>  userHasAccessToOrganizations = (HashMap<String,Organization> )session.getAttribute("userHasAccessToOrganizations");
boolean access = sysadmin || userHasAccessToOrganizations!=null && userHasAccessToOrganizations.containsKey(id);

boolean hasParent = parent != null;


String clientBrowser=request.getHeader("User-Agent");
//simplify the client browser
if(clientBrowser.indexOf("Mac")>-1)
	clientBrowser="mac";
else if (clientBrowser.indexOf("Linux")>-1)
	clientBrowser="linux";
else
	clientBrowser="windows";

List<Organization> children = OrganizationManager.instance().getChildOrganizationsOrderedByName(o,true);
boolean hasChildren = children !=null && !children.isEmpty();

%>


<h<%=hasParent?"4":"3"%>><a href="javascript:toggleDisplay('org_<%=id%>','<%=clientBrowser%>');"><img src="images/closed_folder_<%=clientBrowser%>.gif" id="org_<%=id%>_img"><%=o.getName()%></a><%if(sysadmin){%> <a href="javascript:loadModify('/cat/auth/modifySystem/editOrganization.jsp?organization_id=<%=o.getId()%>&parent_organization_id=<%=hasParent?parent.getId():"-1"%>');"><img src="/cat/images/edit_16.gif" alt="Edit organization" title="Edit organization" ></a><%} %></h<%=hasParent?"4":"3"%>>
<div id="org_<%=id%>_div" style="display:none;">
	<div id="Organization_<%=o.getId()%>_children" style="padding-left:20px;">
		<div id="Organization_<%=o.getId()%>_programs">
			<ul>
				<% 
				for(Program p : o.getPrograms())
				{%>
					<%if(access){%>
					<li><a href="/cat/auth/programView/programWrapper.jsp?program_id=<%=p.getId()%>"><%=p.getName()%></a>						
						<a href="javascript:removeProgram(<%=p.getId()%>,<%=o.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Delete program" title="Delete program" ></a>					
					</li>
					<%}%>
				<%}
				if(access){%><li>
					<a href="javascript:loadModify('/cat/auth/modifyProgram/program.jsp?organization_id=<%=o.getId()%>');" class="smaller"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add a program" title="Add a program"> Add a program</a></li>
				<%}
				if(!hasParent && sysadmin)
					{%>
				<li><a href="javascript:loadModify('/cat/auth/modifySystem/editOrganization.jsp?parent_organization_id=<%=o.getId()%>');" class="smaller"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add an organization" title="Add an organization">Add an organization</a>
				<%}
				if(access)
				{%>
				<li><a href="/cat/auth/programView/organizationOfferingsWrapper.jsp?organization_id=<%=o.getId()%>" target="_blank">Data Completion table (opens in a new tab or window, <b>may take some time to load</b>)</a></li>
				<%}
				if(access)
				{%>
				<li><a href="/cat/auth/modifyProgram/organizationExport.jsp?organization_id=<%=o.getId()%>" target="_blank">Data Export</a> The data can be analyzed in excel using tools such as filters, sorts, vlookup and counts, or can be translated and combined for use in other software.</li>
				<%} %>
			</ul>		
		</div>
		<%if(access && !hasParent) 
		{%>
		<a href="javascript:toggleDisplay('settings_org_<%=id%>','<%=clientBrowser%>');" class="smaller"><img src="images/closed_folder_<%=clientBrowser%>.gif" id="settings_org_<%=id%>_img">settings</a>
		<div id="settings_org_<%=id%>_div" style="display:none;">
			<div id="Organization_<%=o.getId()%>_InstructorAttributes">
			<%	List<InstructorAttribute> attributes = manager.getInstructorAttributes(o);%>
			
				<h5>Available Instructor Attributes</h5>
				<ul>
				<%
				for(InstructorAttribute attr : attributes)
				{
					%>
						<li><%=attr.getName()%>
						<a href="javascript:removeInstructorAttribute(<%=attr.getId()%>,<%=o.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Delete instructor attribute type" title="Delete instructor attribute type" ></a>
					<%
				}
				%><li><a href="javascript:loadModify('/cat/auth/modifyProgram/instructorAttribute.jsp?organization_id=<%=o.getId()%>');" class="smaller"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add an instructor attribute" title="Add an instructor attribute"> Add an instructor attribute</a></li>
				</ul>
			</div>
			<div id="Organization_<%=o.getId()%>_CourseAttributes">
			<%	List<CourseAttribute> cattributes = manager.getCourseAttributes(o);%>
			
				<h5>Available Course Attributes</h5>
				<ul>
				<%
				for(CourseAttribute attr : cattributes)
				{
					%>
						<li><%=attr.getName()%>
						<a href="javascript:removeCourseAttribute(<%=attr.getId()%>,<%=o.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Delete course attribute" title="Delete course attribute" ></a>
					<%
				}
				%><li><a href="javascript:loadModify('/cat/auth/modifyProgram/courseAttribute.jsp?organization_id=<%=o.getId()%>');" class="smaller"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add a course attribute" title="Add a course attribute"> Add a course attribute</a></li>
				</ul>
				<div id="organizationOutcomesDiv_<%=o.getId()%>">
					<jsp:include page="organizationOutcomes.jsp">
						<jsp:param name="organization_id" value="<%=o.getId()%>"/>
					</jsp:include>
				</div>
			</div>
		</div>
	<%
		}
	if(hasChildren)
	{
		for(Organization child : children)
		{
			%>
			<div id="Organization_<%=child.getId()%>">
				<jsp:include page="organization.jsp">
					<jsp:param name="organization_id" value="<%=child.getId()%>" />
				</jsp:include>
			</div>
			<%
		}%>
		
	<%}
	%>
	
	</div>	
</div>			


