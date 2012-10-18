	<%@ page import="java.util.*,java.net.*,ca.usask.gmcte.util.*,ca.usask.gmcte.currimap.model.*"%>
<jsp:include page="/header.jsp"/>
		<div id="content-and-context" style="overflow:auto;">
			<div class="wrapper" style="overflow:auto;"> 
				<div id="content" style="overflow:auto;"> 
					<div id="breadcrumbs"><p><a href="http://www.usask.ca/gmcte/">The Gwenna Moss Centre for Teaching Effectiveness</a> 
						&gt; <a href="/cat">Curriculum Alignment Tool</a> &gt; System Admin </p></div>  
	
					
					<div id="administration" class="module" style="overflow:auto;"><h1>Administration</h1>
						<div id="accessPermissions">
							<jsp:include page="accessPermissions.jsp"/>
						</div>
				
						<div id="adminCharacteristics" class="module" style="overflow:auto;">
							<jsp:include page="adminCharacteristics.jsp"/>
						</div>
						<div id="assessmentMethodAdmin" class="module" style="overflow:auto;">
							<jsp:include page="assessmentMethodAdmin.jsp"/>
						</div>
						
						
						
					</div>
				</div>
			</div>
		</div>


<jsp:include page="/footer.jsp"/>		