<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.action.*,ca.usask.gmcte.currimap.model.*"%>
<%String programId = request.getParameter("program_id");
Program p = ProgramManager.instance().getProgramById(Integer.parseInt(programId));
%>

<jsp:include page="/header.jsp"/>

		<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
					<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> &gt; <a href="/currimap">Curriculum Alignment Tool</a> &gt; <a href="/cat/auth/programView/programWrapper.jsp?program_id=<%=p.getId()%>"><%=p.getName()%></a> &gt; CourseOffering characteristics</p></div>  
					<div id="CourseCharacteristicsDiv" class="module" style="overflow:auto;">
						<jsp:include page="courseCharacteristics.jsp"/>
					</div>
					<div id="modifyDiv" class="fake-input" style="display:none;"></div>
				</div>
			</div>
		</div>
<jsp:include page="/footer.jsp"/>	
