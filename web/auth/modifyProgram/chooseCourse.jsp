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
String programId = request.getParameter("program_id") ;
%>
	<div id="existingCourseSelector">
		<jsp:include page="existingCourseSelector.jsp"/>
	</div>
<br>
	<a href="javascript:openDiv('addCourseDiv');" class="smaller"><img src="/cat/images/add_24.gif" style="height:14pt;" alt="Add" >Add a course (the one I am looking for isn't in the system yet)</a>
<br>
<div id="addCourseDiv" style="display:none;">
	<jsp:include page="/auth/modifyProgram/course.jsp"/>
</div>

		
