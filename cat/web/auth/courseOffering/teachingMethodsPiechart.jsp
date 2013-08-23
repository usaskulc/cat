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
CourseManager cm = CourseManager.instance();
CourseOffering courseOffering = null;
if(HTMLTools.isValid(courseOfferingId))
	courseOffering = cm.getCourseOfferingById(Integer.parseInt(courseOfferingId));

List<LinkCourseOfferingTeachingMethod> list = cm.getTeachingMethods(courseOffering);
%>
<script type="text/javascript">
 
graphsToDraw.push("drawTeachingMethodsGraph<%=courseOfferingId%>()");
 
function drawTeachingMethodsGraph<%=courseOfferingId%>()
{
	if(<%=!list.isEmpty()%>)
	{
	  //Create pie chart
	  var teachingMethodsGraph = new Bluff.Mini.Pie('teachingMethodsGraph<%=courseOfferingId%>', <%=size%>);
	  //Use keynote theme. Several other themes can be used
	 // bluffGraph.theme_keynote();
	  teachingMethodsGraph.theme_37signals();
	  teachingMethodsGraph.title = '';
	  teachingMethodsGraph.hide_labels_less_than = 1000;
	  teachingMethodsGraph.legend_font_size = 40;
	  for (i in teachingMethodsData<%=courseOfferingId%>.items) 
	  {
	    var item = teachingMethodsData<%=courseOfferingId%>.items[i];
	    //Add each data item to pie
	    teachingMethodsGraph.data(item.label, item.data);
	  }
	  //Finally draw the chart
	  teachingMethodsGraph.draw();
	}
}
var teachingMethodsData<%=courseOfferingId%> = {
	items: [
	        
<%
boolean first = true;
for(LinkCourseOfferingTeachingMethod link : list)
{
	if(first)
		first = false;
	else
		out.print(",");
	%>
	{label:'<%=link.getTeachingMethod().getName()%>', data: <%=link.getHowLong().getComparativeValue()%>}<%
}%>	]};
</script>
<canvas id="teachingMethodsGraph<%=courseOfferingId%>"></canvas>


