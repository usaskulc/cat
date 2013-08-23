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


<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,org.hibernate.validator.Length"%>
<%
int id = HTMLTools.getInt(request.getParameter("id"));
String fieldName = request.getParameter("field_name");
String object = request.getParameter("object");
String existingValue = "";
int fieldSize = 0;
String display="";


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
		display="Enter Organization Outcome Group. Maximum of ("+ fieldSize+" characters)";
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
		display="Enter Organzation Outcome. Maximum of ("+ fieldSize+" characters)";

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
		display="Enter Program Outcome Group. Maximum of ("+ fieldSize+" characters)";
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
		display = "Type in one course learning outcome then click save. Return to this add outcome window to enter additional outcomes. Each entry may contain no more than "+fieldSize+" characters.";
		

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
<p>
<%= display%>
</p>

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
	<%
	int organizationId = HTMLTools.getInt(request.getParameter("organization_id"));
	
	if(object.equals("ProgramOutcome")  && organizationId > -1)
	{
		int programId = HTMLTools.getInt(request.getParameter("program_id"));
		Program program = ProgramManager.instance().getProgramById(programId);
		
	boolean editing = HTMLTools.isValid(existingValue);
	String parameterString = "";
	Organization organization = OrganizationManager.instance().getOrganizationById(organizationId);
	List<CharacteristicType> charTypes = organization.getCharacteristicTypes();
	List<Characteristic> outcomeCharacteristics = new ArrayList<Characteristic>();
	OutcomeManager om = OutcomeManager.instance();
	ProgramOutcome outcome = null;
	if(editing)
	{
		outcomeCharacteristics = om.getCharacteristicsForProgramOutcome(program,outcome, organization);
	}
	for(int i=0; i< charTypes.size() ; i++)
	{
		CharacteristicType temp = charTypes.get(i);
		int selectedId = -1;
		for(Characteristic charac: outcomeCharacteristics)
		{
			if(charac.getCharacteristicType().getId() == temp.getId())
				selectedId = charac.getId();
		}
		
		%>
			<jsp:include page="/auth/modifyProgram/characteristicType.jsp">
				<jsp:param name="selectedId" value="<%=selectedId%>" />
				<jsp:param name="charTypeId" value="<%=temp.getId()%>"/>
				<jsp:param name="index" value="<%=i%>"/>
			</jsp:include>
		<% 
		parameterString += ",'characteristic_"+i+"','characteristic_type_"+i+"'";
	}
	%>
	<input type="hidden" name="organization_id" id="organization_id" value="<%=organizationId%>"/>
	<input type="hidden" name="program_id" id="program_id" value="<%=programId%>"/>
	
	<input type="hidden" name="char_count" id="char_count" value="<%=charTypes.size()%>"/>
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" 
				   name="saveCourseOfferingOutcomeButton" 
				   id="saveCourseOfferingOutcomeButton" 
				   value="Save" 
				   onclick="saveProgram(new Array('new_value'),
				   				new Array('new_value'<%=parameterString%>,'organization_id','program_id','program_outcome_group_id','char_count','outcome_id'),'ProgramOutcomeWithCharacteristics');" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	<%}
	else
	{
	%>
	
	
	
	<br/>
	<div class="formElement">
		<div class="label"><input type="button" name="saveButton" id="saveButton" value="Save" onclick="saveGenericProgramField(new Array('new_value'),new Array('new_value','id'<%=additionalFieldsToSubmit.toString()%>));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
	<%} %>
</form>

		
