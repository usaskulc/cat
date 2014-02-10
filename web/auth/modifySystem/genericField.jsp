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
String id = request.getParameter("id");
String fieldName = request.getParameter("field_name");
String object = request.getParameter("object");
String existingValue = "";
int fieldSize = 0;
if(HTMLTools.isValid(object) && HTMLTools.isValid(fieldName))
{
	if(object.equals("Characteristic"))
	{
		Characteristic characteristic = new Characteristic(); 
		if( HTMLTools.isValid(id))
			characteristic = CharacteristicManager.instance().getCharacteristicById(id);
		
		if(fieldName.equals("name"))
		{
			existingValue = characteristic.getName()==null?"":characteristic.getName();
			fieldSize= (Characteristic.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else if(fieldName.equals("description"))
		{
			fieldSize= (Characteristic.class.getMethod("getDescription")).getAnnotation(Length.class).max();
			existingValue = characteristic.getDescription()==null?"":characteristic.getDescription();
		}
	}
	else if(object.equals("CharacteristicType"))
	{
		CharacteristicType characteristicType =  new CharacteristicType();
		if(HTMLTools.isValid(id))
			characteristicType = CharacteristicManager.instance().getCharacteristicTypeById(id);
		
		if(fieldName.equals("name"))
		{
			fieldSize= (CharacteristicType.class.getMethod("getName")).getAnnotation(Length.class).max();
			existingValue = characteristicType.getName()==null?"":characteristicType.getName();
		}
		else if(fieldName.equals("question"))
		{
			fieldSize= (CharacteristicType.class.getMethod("getQuestionDisplay")).getAnnotation(Length.class).max();
			existingValue = characteristicType.getQuestionDisplay()==null?"":characteristicType.getQuestionDisplay();
		}
		else if(fieldName.equals("shortDisplay"))
		{
			fieldSize= (CharacteristicType.class.getMethod("getShortDisplay")).getAnnotation(Length.class).max();
			existingValue = characteristicType.getShortDisplay()==null?"":characteristicType.getShortDisplay();
		}
		else if(fieldName.equals("AnswerType"))
		{
			fieldSize= (CharacteristicType.class.getMethod("getValueType")).getAnnotation(Length.class).max();
			existingValue = characteristicType.getValueType()==null?"":characteristicType.getValueType();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}

	}
	else if(object.equals("Assessment"))
	{
		Assessment assessment = new Assessment(); 
		if( HTMLTools.isValid(id))
			assessment = CourseManager.instance().getAssessmentById(Integer.parseInt(id));
		
		if(fieldName.equals("name"))
		{
			existingValue = assessment.getName()==null?"":assessment.getName();
			fieldSize= (Assessment.class.getMethod("getName")).getAnnotation(Length.class).max();
		}
		else if(fieldName.equals("description"))
		{
			existingValue = assessment.getDescription()==null?"":assessment.getDescription();
			fieldSize= (Assessment.class.getMethod("getDescription")).getAnnotation(Length.class).max();
		}
		else 
		{
			out.println("Unable to find field["+fieldName+"]");
		}
	}
	else if(object.equals("AssessmentGroup"))
	{
		AssessmentGroup assessmentGroup =  new AssessmentGroup();
		if(HTMLTools.isValid(id))
			assessmentGroup = CourseManager.instance().getAssessmentGroupById(Integer.parseInt(id));
		
		if(fieldName.equals("name"))
		{
			fieldSize= (AssessmentGroup.class.getMethod("getName")).getAnnotation(Length.class).max();
			existingValue = assessmentGroup.getName()==null?"":assessmentGroup.getName();
		}
		else if(fieldName.equals("short_name"))
		{
			fieldSize= (AssessmentGroup.class.getMethod("getShortName")).getAnnotation(Length.class).max();
			existingValue = assessmentGroup.getShortName()==null?"":assessmentGroup.getShortName();
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
	
	<% if(HTMLTools.isValid(id))
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
		<div class="label"><input type="button" name="saveGenericFieldButton" id="saveGenericFieldButton" value="Save" onclick="saveSystemGenericField(new Array('new_value'),new Array('new_value','id'<%=additionalFieldsToSubmit.toString()%>));" /></div>
		<div class="field"><div id="messageDiv" class="completeMessage"></div></div>
		<div class="spacer"> </div>
	</div>
</form>

		
