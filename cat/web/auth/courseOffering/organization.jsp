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

		