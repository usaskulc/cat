<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*,java.awt.image.BufferedImage,java.io.*,javax.imageio.*"%><%
String courseOfferingId = request.getParameter("course_offering_id") ;
@SuppressWarnings("unchecked")
HashMap<String,CourseOffering> userHasAccessToOfferings = (HashMap<String,CourseOffering>)session.getAttribute("userHasAccessToOfferings");

Boolean sessionValue = (Boolean)session.getAttribute("userIsSysadmin");
boolean sysadmin = sessionValue != null && sessionValue;
boolean access = sysadmin || (userHasAccessToOfferings!=null && userHasAccessToOfferings.containsKey(courseOfferingId));

CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}

List<LinkCourseOfferingAssessment> list = cm.getAssessmentsForCourseOffering(courseOffering);

List<AssessmentGroup> groups = cm.getAssessmentGroups();
ArrayList<Double> sums = new ArrayList<Double>();

for(AssessmentGroup group: groups)
{
	sums.add(new Double(0.0));
}
List<String> groupLabels = new ArrayList<String>();
boolean firstTime = true;
for(LinkCourseOfferingAssessment link : list)
{
	AssessmentGroup usedGroup = link.getAssessment().getGroup();
	
	for(AssessmentGroup group: groups)
	{
		if(firstTime) groupLabels.add(group.getShortName());
		if(usedGroup.getId() == group.getId())
		{
			Double value = sums.get(group.getDisplayIndex()-1);
			value += link.getWeight();
			sums.set(group.getDisplayIndex()-1, value);	
		}
	}
	firstTime = false;
}
double maxSum = 0.0;
for(Double sum: sums)
{
	if(sum > maxSum)
		maxSum = sum;
}
int tableWidth = 800;
double valuePerPercent = tableWidth / 100.0;
String[] colors = {"red", "blue",  "pink", "magenta","purple","grey"}; 
AssessmentCategoriesBarChart barchart = new AssessmentCategoriesBarChart();
barchart.init(groups.size(), groupLabels,"No data to display, please select Assessment Methods above.", sums, maxSum,new ArrayList<Integer>(0));
BufferedImage offImage = barchart.getImage();

response.setContentType("image/png");
OutputStream os = response.getOutputStream();
ImageIO.write(offImage, "png", os);
os.close();
%>
