<%@ page import="java.util.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,java.awt.image.BufferedImage,java.io.*,javax.imageio.*"%>
<%
String courseOfferingId = request.getParameter("course_offering_id");
String size = request.getParameter("size");
String loadValuesOnlyString = request.getParameter("load_values");
boolean loadValuesOnly = HTMLTools.isValid(loadValuesOnlyString) && loadValuesOnlyString.equals("true");
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
//the "name" of the teaching method
List<String> optionsString = new ArrayList<String>();

//the value of the option to be used on the y-axis
List<Integer> optionValuesString = new ArrayList<Integer>();

List<TeachingMethodPortionOption> optionsList = cm.getTeachingMethodPortionOptions();
int maxYValue = 0;
for(TeachingMethodPortionOption option : optionsList)
{
	optionsString.add(option.getName()+" ("+option.getComparativeValue()+")");
	optionValuesString.add(option.getComparativeValue());
	if(option.getComparativeValue() > maxYValue)
		maxYValue = option.getComparativeValue();
}

//the available teaching methods (for the labels to be displayed along the right side
List<String> teachingMethodsString = new ArrayList<String>();
List<TeachingMethod> teachingMethodslist = cm.getAllTeachingMethods();
for(TeachingMethod option : teachingMethodslist)
{
	teachingMethodsString.add(option.getName());
}
//the actual values for the bars
List<Double> values = new ArrayList<Double>();
List<LinkCourseOfferingTeachingMethod> list = cm.getTeachingMethods(courseOffering);
double maxColumnValue = 0.0;
for(TeachingMethod option : teachingMethodslist)
{
	boolean found = false;
	for(LinkCourseOfferingTeachingMethod link : list)
	{
		if(link.getTeachingMethod().getId() == option.getId())
		{
			double val = (double)link.getHowLong().getComparativeValue();
			values.add( new Double(val));
			
			found = true;
			if(val>maxColumnValue)
				maxColumnValue = val;
		}
	}
	if(!found)
		values.add(new Double(0.0));
}

BarChartTeachingMethodGenerator bcg = new BarChartTeachingMethodGenerator(); 
bcg.init(teachingMethodslist.size(), 
		teachingMethodsString, 
		 "No data to display, please select Instructional Strategies used above.", 
		 values, 
		 maxColumnValue,
		 optionValuesString, 
		 optionsString,
		 maxYValue);
BufferedImage offImage = bcg.getImage();

response.setContentType("image/png");
OutputStream os = response.getOutputStream();
ImageIO.write(offImage, "png", os);
os.close();
%>
