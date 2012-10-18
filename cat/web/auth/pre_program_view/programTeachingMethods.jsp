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

