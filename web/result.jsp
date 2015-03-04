<%@ page import="java.io.*, java.util.*, java.text.*" %>

<% 
	String username = (String)session.getAttribute("username");
	String password = (String)session.getAttribute("password");
	//System.out.println ("Username: " + username + " Password: " + password);
	
	if (username == null || password == null) {
		response.sendRedirect("login.jsp");
	}
%>

<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>


<div class="main-subtitle text-center">
	<h3>Scored Files</h3>
</div> 

<br><br>

<div class="row">
	<div class="col-sm-offset-1 col-sm-10">
		<%
			String rootPath = System.getProperty("catalina.home");
			String path = rootPath + File.separator + "tmpfiles" + File.separator + username + File.separator + "downloadDir"; 
			String files;
			Date date;
			long time;
			File folder = new File(path);
			File[] listOfFiles = folder.listFiles();
			if (listOfFiles != null) {
				if (listOfFiles.length != 0) {
				%>
					<div class="table-responsive">
			  			<table class="table table-condensed">
			 				<thead>
			            		<tr>
			              			<th>Scored File Name</th>
			             			<th>Scored Date</th>
			              			<th>&nbsp;</th>
			            		</tr>
			          		</thead>
			          		<tbody>
			          		<%
								for (int i = 0; i < listOfFiles.length; i++) {
									if (listOfFiles[i].isFile()) {
								 		files = listOfFiles[i].getName();
								 		time = listOfFiles[i].lastModified();
								 		date = new Date(time);
								 		out.println("<tr><td>" + files + "</td>");
								 		out.println("<td>" + DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(date) + "</td>");
								 		out.println("<td><a href=\"downloadServlet?path=" + path + "&file=" + files + "\">Download</a> | <a href=\"deleteFile.jsp?page=result.jsp&path=" + path + File.separator + files + "\">Delete</a></td></tr>");
								    }
								}
			          		%>
		          			</tbody>
		  				</table>
					</div>
				<% 
				} else {
				%>
					<br><br><p class="text-center">There are not scored files to be displayed.</p>	
				<%
				}
			}
			%>
	</div>
</div>



<%@ include file="includes/footer.jsp" %>
