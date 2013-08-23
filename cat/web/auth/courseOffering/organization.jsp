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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*"%>
<%
Organization o = new Organization();
String id = request.getParameter("organization_id");
if(HTMLTools.isValid(id))
{
	o = OrganizationManager.instance().getOrganizationById(Integer.parseInt(id));
}
else
{
	%><h2>Organization id not found!</h2><%
	return;
}
%>
<script type="text/javascript">
$(document).ready(function() 
{
	$(".error").hide();
});
</script>

<form name="newObjectForm" id="newObjectForm" method="post" action="" >
	
	<div id="organizationCharacteristicsDiv">
		<jsp:include page="organizationCharacteristics.jsp"/>
	</div>
	
	
</form>

		
