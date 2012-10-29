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

