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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
int organizationId = HTMLTools.getInt(request.getParameter("organization_id")) ;

Organization o = new Organization();
boolean editing = false;
boolean hasChildren = false;




if(organizationId > 0)
{
	o  = OrganizationManager.instance().getOrganizationById(organizationId);
	editing = true;
	List<Organization> children = OrganizationManager.instance().getChildOrganizationsOrderedByName(o,true);
	hasChildren = children != null && !children.isEmpty();
	
}

int parentId = HTMLTools.getInt(request.getParameter("parent_organization_id"));
boolean hasParent = false;
if(parentId > 0)
{
	hasParent = true;
}
List<Organization> rootList = OrganizationManager.instance().getParentOrganizationsOrderedByName(true);
Organization bogus = new Organization();
bogus.setId(-1);
bogus.setName("This Organization has no parent");
rootList.add(0,bogus);
%>
<p>
A organization can have 2 different names. The system-name is used for association of courses with organizations dynamically. 
 If data is loaded from an external system, this is the alternate name that can be used to identify the organization.
</p>
<form name="newCourseForm" id="newCourseForm" method="post" action="" >
	<input type="hidden" name="objectClass" id="objectClass" value="Organization"/>
	<%
	
	if(editing)
		{
			%><input type="hidden" name="objectId" id="objectId" value="<%=o.getId()%>"/>
			<%
			if(hasParent)
			{
				%><input type="hidden" name="old_parent_id" id="old_parent_id" value="<%=parentId%>"/>
				<%
			}
		}
	if(!hasChildren)
	{
	%>
	<div class="formElement">
		<div class="label">Parent Organization:</div>
		<div class="field"> <%=HTMLTools.createSelect("parent_organization_id",rootList, "Id", "Name", hasParent?""+parentId:null, null) %></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	<%} %>

	<div class="formElement">
		<div class="label">Name:</div>
		<div class="field"> <input type="text" size="40" maxlength="100" name="name" id="name" value="<%=editing?o.getName():""%>" /></div>
		<div class="error" id="nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	
	
	<br/>
	<div class="formElement">
		<div class="label">System Name:</div>
		<div class="field"> <input type="text" size="50" name="system_name" id="system_name" value="<%=o.getSystemName()==null?"":o.getSystemName()%>"/></div>
		<div class="error" id="system_nameMessage"></div>
		<div class="spacer"> </div>
	</div>
	
		<div class="formElement">
		<div class="label">Active:</div>
		<div class="field">	<input type="radio" name="active"   <%=o.getActive() == null || o.getActive().equals("Y")?"checked=\"checked\"":""%> value="Y"/> Yes<br>
							<input type="radio" name="active"   <%=o.getActive()!= null && o.getActive().equals("N")?"checked=\"checked\"":""%> value="N"/> No<br>
		</div>
		<div class="error" id="activeMessage"></div>
		<div class="spacer"> </div>
	</div>
	
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save Organization" onclick="saveSystem(new Array('name'),new Array('name','system_name','active','parent_organization_id','old_parent_id'));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

<% if(editing)
{
	%>
	<p>Choose a subject for which you want to add/remove the home-organization.
	</p>
	<div id="assignCoursesDiv">
	<jsp:include page="existingCourseSelector.jsp">
		<jsp:param name="organization_id" value="<%=organizationId%>" />
	</jsp:include>
	
	</div>
	
		<%
}
		%>		
