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


<%@ page import="java.util.*,java.net.*,java.io.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,ca.usask.gmcte.util.*,org.apache.log4j.Logger"%><%!
Logger logger = Logger.getLogger("programExport.jsp");
%>
<%
Organization org = null;
int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
if (organizationId > -1)
{
	org = OrganizationManager.instance().getOrganizationById(organizationId);
}
File excelFile = ExcelEporter.createExportFile(org);


String attachment=new String();
String header=request.getHeader("User-Agent");
if(header.indexOf("IE")>=0 ) 
{
	response.setContentType("application/x-msdownload");
	response.setStatus(response.SC_OK);
}
else
{
	attachment="attachment;";
	response.setContentType("application/octet-stream");
}	
String headerText=attachment+"filename=\""+excelFile.getName()+"\"";
response.setHeader	("Content-Disposition",headerText);
			
InputStream in = new FileInputStream(excelFile);
ServletOutputStream outs = response.getOutputStream();
int bit = 256;
int i = 0;
try 
{
	bit=in.read();
	do 
	{
		outs.write(bit);
		bit=in.read();	
	}while(bit>=0);

} catch (IOException ioe) 
{
	logger.error("problem with downloading",ioe);
}
outs.flush();
outs.close();
in.close();	
%>

