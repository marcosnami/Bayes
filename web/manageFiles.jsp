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
	<h3>Manage Files</h3>
</div> 

<div class="row">
	<div class="col-sm-offset-5 col-sm-7">
	
<% 
	if (session.getAttribute("error") != null) {
		out.print("<div class=\"errors\"><ul><li>");
		out.print(session.getAttribute("error"));
		out.print("</li></ul></div>");
	}
	session.setAttribute("error", null);
%>

	</div>
</div>

<form class="form-horizontal" action="uploadServlet" method="post" role="form" name="upload-form" enctype="multipart/form-data">
	<input type="hidden" name="session-id" value="<% out.print(session.getId()); %>">
	<input type="hidden" name="username" value="<% if (username != null) { out.print(username); }; %>">
	<div class="form-group">
    	<label for="inputFile" class="col-sm-offset-3 col-sm-2">Upload File*:</label>
	  	<div class="col-sm-6">
    		<input type="file" id="inputFile" name="inputFile">
    		<p>&nbsp;</p>
   		</div>
  	</div>	
	<div class="form-group">
    	<div class="col-sm-offset-5 col-sm-4">
    		<label>
				<button type="submit" class="btn btn-primary btn-sm">UPLOAD</button>
			</label>
		</div>
	</div>
</form>

<hr>

<div class="row">
	<div class="col-sm-offset-1 col-sm-10">
		<%
			String rootPath = System.getProperty("catalina.home");
			String path = rootPath + File.separator + "tmpfiles" + File.separator + username + File.separator + "uploadDir"; 
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
			              			<th>File Name</th>
			             			<th>Uploaded Date</th>
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
								 		out.println("<td><a href=\"downloadServlet?path=" + path + "&file=" + files + "\">Download</a> | <a href=\"deleteFile.jsp?page=manageFiles.jsp&path=" + path + File.separator + files + "\">Delete</a></td></tr>");
								    }
								}
			          		%>
		          			</tbody>
		  				</table>
					</div>
				<% 
				} else {
				%>
					<br><br><p class="text-center">There are not files to be displayed.</p>	
				<%
				}
			}
			%>
	</div>
</div>


<%@ include file="includes/footer.jsp" %>
