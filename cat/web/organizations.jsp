<%@ page import="java.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*,org.apache.log4j.*"%> 
<%!Logger logger = Logger.getLogger("organizations.jsp"); %> 
<%
Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
//TreeMap<Organization, ArrayList<Organization>> map = OrganizationManager.instance().getOrganizationsOrderedByName();
List<Organization> list = OrganizationManager.instance().getParentOrganizationsOrderedByName(true);
for(Organization o : list)
{
	%>
	<div id="Organization_<%=o.getId()%>">
		<jsp:include page="organization.jsp">
			<jsp:param name="organization_id" value="<%=o.getId()%>" />
		</jsp:include>
	</div>
	<%
}
%>
<hr/>
<%

if(sysadmin) {%><a href="javascript:loadModify('/cat/auth/modifySystem/organization.jsp');" class="smaller"><img src="/cat/images/add_24.gif" style="height:14pt;" alt="Add organization" title="Add organization"> Add an Organization</a><%}%>





