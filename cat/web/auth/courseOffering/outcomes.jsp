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
String courseOfferingId = request.getParameter("course_offering_id") ;


CourseOffering courseOffering = new CourseOffering();
CourseManager cm = CourseManager.instance();
OrganizationManager dm = OrganizationManager.instance();
OutcomeManager om = OutcomeManager.instance();
boolean access = true;
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}
List<Organization> organizations = cm.getOrganizationForCourseOffering(courseOffering);
Organization organization = organizations.get(0);  

if(organization == null)
{
	%>
	<h1>Unable to find associated organization!</h1>
	<%
	return;
}
else if(organizations.size() > 1)
{	
%>
<h1>Course offering appears to be associated with multiple organizations! </h1>
<%
	
}

List<CharacteristicType> characteristicTypes = organization.getCharacteristicTypes();
if(characteristicTypes == null  || characteristicTypes.isEmpty())
{
	%>
	<h1>No Characteristics associated with organization <b><%=organization.getName()%></b>!  Add Characteristics first please!</h1>
	<%
	return;
}
int maxOutcomes = 20;
%>
<h2>My Course Learning Outcomes</h2>
<p>This section gathers information about your goals for the course, 
specifically those abilities, knowledge, and values for which you anticipate
 evidence of in students as they complete your course. 
 You may enter up to <%=maxOutcomes%> course learning outcomes one-at-a time by clicking on <i><b>add course learning outcome</b></i> to add each entry.
Each entry may contain no more than 400 characters (less than 10 outcomes recommended). 
To change the order of the course learning outcomes, use the arrows to the left of each outcome
</p>

<div>
	<div id="mainCourseOfferingCharacteristics">
		<table border="1" cellpadding="5" cellspacing="0">
<%
int count = 1;
List<CourseOutcome> outcomes = om.getOutcomesForCourseOffering(courseOffering);
int lastOne = outcomes.size()-1;
for(CourseOutcome o : outcomes)
{
	List<Characteristic> outcomeCharacteristics = om.getCharacteristicsForCourseOfferingOutcome(courseOffering,o, organization);
	StringBuilder charOutput = new StringBuilder();
	int charTypeIndex = 0;
	int colorIndex = 0;
	for(Characteristic charac: outcomeCharacteristics)
	{
		CharacteristicType cType = charac.getCharacteristicType();
		if(cType.getQuestionDisplay().length() > 0)
		{
			if(cType.getQuestionDisplay().length()>0)
			{
				charOutput.append(cType.getQuestionDisplay());	
			}
			charOutput.append(" ");
			charOutput.append(charac.getName());
			charOutput.append("      ");
		}
		
	}
	String charOutputDisplay = "";
	if(charOutput.length() > 0)
		charOutputDisplay = " title=\"" + charOutput.toString() +"\"";
	
	%>
	<tr>
	    <td><%=count %></td>
	    <td>
	    <%if(count>1)
		{%>
			<a href="javascript:moveOutcome(<%=o.getId()%>,<%=courseOfferingId%>,'up');">
				<img src="/cat/images/up2.gif"  alt="move up" title="move up"/>
			</a>
		<%}
		if(count <= lastOne)
		{%>
			<a href="javascript:moveOutcome(<%=o.getId()%>,<%=courseOfferingId%>,'down');">
				<img src="/cat/images/down2.gif"  alt="move down" title="move down"/>
			</a>
		<%}
		%>
	    </td>
	    <td <%=charOutputDisplay%>><%=o.getName()%>	
	    <%if(access)
		  {%>	
				<a href="javascript:loadModify('/cat/auth/courseOffering/addOutcome.jsp?outcome_id=<%=o.getId()%>&organization_id=<%=organization.getId()%>&course_offering_id=<%=courseOfferingId%>');" class="smaller"><img src="/cat/images/edit_16.gif" alt="Edit outcome" title="Edit outcome"></a>
				<a href="javascript:removeCourseOfferingOutcome(<%=courseOfferingId%>,<%=o.getId()%>);"><img src="/cat/images/deletes.gif" style="height:10pt;" alt="Remove outcome" title="Remove outcome"/></a><%
		  }%>
		</td>
	</tr>
	<%
	count++;
}

if(access)
{
	if(count <= maxOutcomes)

	{
	%>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2"><a href="javascript:loadModify('/cat/auth/courseOffering/addOutcome.jsp?organization_id=<%=organization.getId()%>&course_offering_id=<%=courseOfferingId%>');" class="smaller">
				<img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add course outcome" title="Add course outcome"/>
				add course learning outcome 
			</a>
		    </td>
		</tr>
	<%}
	else
	{
		%>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">Maximum of <%=maxOutcomes%> has been reached.
		    </td>
		</tr>
	<%}
}
%>
 </table>
</div>
<div id="characteristicsModifyDiv" class="fake-input" style="display:none;">
</div>
</div>
<%!
public String getStars(int value, int max)
{
	String yellow = "<img src=\"/cat/images/yellow_star.png\">";
	String white =  "<img src=\"/cat/images/white_star.png\">";
	
	StringBuilder r = new StringBuilder();
	for(int i=1; i <= value ; i++)
		r.append(yellow);
	for(int i=value+1; i <= max ; i++)
		r.append(white);
	return r.toString();
}

char[] colourValues="0123456789ABCDEFFEDCBA9876543210".toCharArray();
public String getColour(int type, int level, int maxLevel)
{
	int colourLevel = 14;
	if(level <= 1)
	{
		colourLevel = 0;
	}
	else if(maxLevel > level)
	{
		level = level - 1;
		maxLevel--;
		double ratio = (level *1.0 )/maxLevel;
		colourLevel = (int)(ratio * 16);
	}
	if(colourLevel < 0)
		colourLevel = 0;
	else if(colourLevel >14)
		colourLevel = 14;
	
	char levelChar = colourValues[colourLevel];
	if(type == 0)
	{
		return "F" + levelChar + levelChar;
	}
	else if(type == 1)
	{
		return levelChar + "F" + levelChar;
	}
	else if(type == 2)
	{
		return levelChar + levelChar + "F";
	}
	else if(type == 3)
	{
		return levelChar + "FF";
	}
	else if(type == 4)
	{
		return "F" + levelChar + "F";
	}
	else if(type == 5)
	{
		return "FF" + levelChar;
	}
	return "000";
}

%>
