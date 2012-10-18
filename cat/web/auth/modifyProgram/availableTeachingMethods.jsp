<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%
String programId = request.getParameter("program_id");
String courseOfferingId = request.getParameter("courseOffering_id");
String teachingMethodLinkId = request.getParameter("id");
LinkCourseOfferingTeachingMethod o = new LinkCourseOfferingTeachingMethod();
CourseOffering courseOffering = new CourseOffering();
String name = request.getParameter("name");
TeachingMethod createdTeachingMethod = null;
CourseOfferingManager cm = CourseOfferingManager.instance();
if(name!=null)
{
	createdTeachingMethod = cm.getTeachingMethodByName(name);
}
boolean linkLoaded = false;
if(teachingMethodLinkId != null && teachingMethodLinkId.trim().length() > 0)
{
	o = cm.getLinkTeachingMethodById(Integer.parseInt(teachingMethodLinkId));
	linkLoaded = true;
	courseOffering = o.getCourseOffering();
	courseOfferingId = ""+courseOffering.getId();
}
else 
{
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));
}

List<TeachingMethod> notUsed = cm.getTeachingMethodsNotUsed(courseOffering);
List<String> ids = new ArrayList<String>();
List<String> names = new ArrayList<String>();
for(TeachingMethod tm :notUsed)
{
	ids.add(""+tm.getId());
	names.add(tm.getName());
}
out.println(HTMLTools.createSelect("teachingMethod",ids, names, createdTeachingMethod!=null ?""+createdTeachingMethod.getId():null, null));
%>
<a href="javascript:openDiv('newTeachingMethodDiv');"><img src="/cat/images/add_24.gif" style="height:10pt;" alt="Add"  class="smaller">Add a teaching method</a>




