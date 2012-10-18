<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,org.hibernate.validator.Length"%>
<%
int id = HTMLTools.getInt(request.getParameter("id"));
String fieldName = request.getParameter("field_name");
String object = request.getParameter("object");
String existingValue = "";
int fieldSize = 0;
if(HTMLTools.isValid(object) && HTMLTools.isValid(fieldName))
{
	if(object.equals("OrganizationOutcomeGroup"))
	{
		OrganizationOutcomeGroup group = new OrganizationOutcomeGroup(); 
		if( id > -1 )
			group = OrganizationManager.instance().getOrganizationOutcomeGroupById(id);
		
		if(fieldName.equals("name"))
		{
			existingValue = group.getName()==null?"":group.getName();
			fieldSize= (OrganizationOutcomeGroup.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}
	}
	else if(object.equals("OrganizationOutcome"))
	{
		OrganizationOutcome o =  new OrganizationOutcome();
		if(id > -1)
			o = OrganizationManager.instance().getOrganizationOutcomeById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (OrganizationOutcome.class.getMethod("getName")).getAnnotation(Length.class).max();
			existingValue = o.getName()==null?"":o.getName();
		}
		else if(fieldName.equals("description"))
		{
			fieldSize= (OrganizationOutcome.class.getMethod("getDescription")).getAnnotation(Length.class).max();
			existingValue = o.getDescription()==null?"":o.getDescription();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}

	}
	else if(object.equals("ProgramOutcomeGroup"))
	{
		ProgramOutcomeGroup group = new ProgramOutcomeGroup(); 
		if( id > -1 )
			group = ProgramManager.instance().getProgramOutcomeGroupById(id);
		
		if(fieldName.equals("name"))
		{
			existingValue = group.getName()==null?"":group.getName();
			fieldSize= (ProgramOutcomeGroup.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}
	}
	else if(object.equals("ProgramOutcome"))
	{
		ProgramOutcome o =  new ProgramOutcome();
		if(id > -1)
			o = ProgramManager.instance().getProgramOutcomeById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (ProgramOutcome.class.getMethod("getName")).getAnnotation(Length.class).max();
			existingValue = o.getName()==null?"":o.getName();
		}
		else if(fieldName.equals("description"))
		{
			fieldSize= (ProgramOutcome.class.getMethod("getDescription")).getAnnotation(Length.class).max();
			existingValue = o.getDescription()==null?"":o.getDescription();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}

	}
	else 
	{
		out.println("Unable to find object["+object+"]");
	}

}
List<String> fieldsToIgnore = new ArrayList<String>();
fieldsToIgnore.add("id");

StringBuffer additionalFields = new StringBuffer();
StringBuffer additionalFieldsToSubmit = new StringBuffer();

@SuppressWarnings("unchecked")
Enumeration<String> e = (Enumeration<String>)request.getParameterNames();
while(e.hasMoreElements())
{
	String pName = (String)e.nextElement();
	if(!fieldsToIgnore.contains(pName))
	{
		String value = request.getParameter(pName);
		additionalFields.append("<input type=\"hidden\" name=\"");
		additionalFields.append(pName);
		additionalFields.append("\" id=\"");
		additionalFields.append(pName);
		additionalFields.append("\" value=\"");
		additionalFields.append(value);
		additionalFields.append("\"/>\n");
		additionalFieldsToSubmit.append(",'");
		additionalFieldsToSubmit.append(pName);
		additionalFieldsToSubmit.append("'");
	}
}
%>

<form name="genericFieldForm" id="genericFieldForm" method="post" action="" >
	
	<%=additionalFields.toString()%>
	
	<% if(id > -1)
		{
			%><input type="hidden" name="id" id="id" value="<%=id%>"/>
			<%
		}
		%>
	<div class="formElement">
		<div class="label"><%=fieldName%>:</div>
		<div class="field">
		<%if(fieldSize > 100)
		{
			%>
			<textarea name="new_value" id="new_value" cols="40" rows="10"><%=existingValue%></textarea>
			<%
		}
		else
		{%>
			 <input type="text" size="60" maxlength="<%=fieldSize%>" name="new_value" id="new_value" value="<%=existingValue%>"/>
		<%} %>
		</div>
		<div class="error" id="new_valueMessage" style="padding-left:10px;"></div>
		<div class="spacer"> </div>
	</div>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveGenericProgramField(new Array('new_value'),new Array('new_value','id'<%=additionalFieldsToSubmit.toString()%>));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		