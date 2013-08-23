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


<%@ page import="java.util.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
String size = request.getParameter("size");
String loadValuesOnlyString = request.getParameter("load_values");
boolean loadValuesOnly = HTMLTools.isValid(loadValuesOnlyString) && loadValuesOnlyString.equals("true");
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
StringBuilder optionsString = new StringBuilder();
StringBuilder optionValuesString = new StringBuilder();

List<TeachingMethodPortionOption> optionsList = cm.getTeachingMethodPortionOptions();
boolean first = true;
for(TeachingMethodPortionOption option : optionsList)
{
	if(first)
		first = false;
	else
	{
		optionsString.append(",");
		optionValuesString.append(",");
	}
	optionsString.append(option.getName());
	optionValuesString.append(option.getComparativeValue());
}
StringBuilder teachingMethodsString = new StringBuilder();
List<TeachingMethod> teachingMethodslist = cm.getAllTeachingMethods();
first = true;
for(TeachingMethod option : teachingMethodslist)
{
	if(first)
		first = false;
	else
		teachingMethodsString.append(",");
	
	teachingMethodsString.append(option.getName());
}
%>

