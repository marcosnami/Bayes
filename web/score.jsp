<%@ page import="java.io.*, java.util.*, java.text.*" %>
<%@ page import="com.bayescorp.db.ProfilesMap" %>

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

<div class="main-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Score Files</h3>
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

<%
	String rootPath = System.getProperty("catalina.home");
	String path = rootPath + File.separator + "tmpfiles" + File.separator + username + File.separator + "uploadDir"; 
	String files;
	Date date;
	long time;
	File folder = new File(path);
	File[] listOfFiles = folder.listFiles();
%>

<form class="form-horizontal" action="scoreBean.jsp" method="post" role="form" name="score-form">
	<div class="form-group">
	  	<label for="filename" class="col-sm-offset-3 col-sm-2">Select File*:</label>
	  	<div class="col-sm-4">
	   		<select class="form-control" id="filename" name="fileName">
				<option value="choosefile" selected="selected">Choose a file</option>
				<% 	if (listOfFiles != null) {
						if (listOfFiles.length != 0) {
							for (int i = 0; i < listOfFiles.length; i++) {
								if (listOfFiles[i].isFile()) {
							 		files = listOfFiles[i].getName();
							 		out.println("<option value=\"" + files + "\">" + files + "</option>");
							    }
							}
						}
					}
				%>
			</select>
	  	</div>
	</div>
	<% HashMap<String, String> hm = ProfilesMap.getProfilesMap(username); %>
	<div class="form-group">
	  	<label for="profile" class="col-sm-offset-3 col-sm-2">Select Profile*:</label>
	  	<div class="col-sm-4">
	   		<select class="form-control" id="profile" name="profile">
				<option value="chooseprofile" selected="selected">Choose a profile</option>
				<% 
					if (hm != null) {
						if (!hm.isEmpty()) {
							for (Map.Entry<String, String> m : hm.entrySet()) {
								out.println("<option value=\"" + m.getKey() + "\">" + m.getValue() + "</option>");
					            //System.out.println(m.getKey() + " " + m.getValue());  
					        } 
						}
					}
				%>
			</select>
	  	</div>
	</div>
	<div class="form-group">
	  	<label for="output" class="col-sm-offset-3 col-sm-2">Select Output*:</label>
	  	<div class="col-sm-4">
	   		<select class="form-control" id="output" name="output">
				<option value="chooseoutput" selected="selected">Choose output type</option>
				<option value="20Cells">Cell Score: 20 Cells</option>
			  	<option value="100Cells">Cell Score: 100 Cells</option>
			  	<option value="3Colors">Color Score: 3 Colors</option>
			  	<option value="5Colors">Color Score: 5 Colors</option>
			</select>
	  	</div>
	</div>
	<div class="form-group">
    	<div class="col-sm-offset-5 col-sm-4">
    		<label>
				<button type="submit" class="btn btn-primary btn-sm">SCORE</button>
			</label>
		</div>
	</div>
	<input type="hidden" name="session-id" value="<% out.print(session.getId()); %>">
</form>


<%@ include file="includes/footer.jsp" %>
