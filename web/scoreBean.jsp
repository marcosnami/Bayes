<jsp:useBean id="score" class="com.bayescorp.beans.scoreBean" scope="request">
    <jsp:setProperty property="fileName" name="score"/>
    <jsp:setProperty property="profile" name="score"/>
    <jsp:setProperty property="output" name="score"/>
</jsp:useBean>


<%
	String username = (String)session.getAttribute("username");
	score.setUsername(username);
	String password = (String)session.getAttribute("password");
	score.setPassword(password);
	String fileName = request.getParameter("fileName");
	String profile  = request.getParameter("profile");
	String output   = request.getParameter("output");
	String sessionId = request.getParameter("session-id");
	/* System.out.println("Username: " + username + " Bean Username: " + score.getUsername());
	System.out.println("Password: " + password + " Bean Password: " + score.getPassword());
	System.out.println("File Name: " + fileName + " Bean File Name: " + score.getFileName());
	System.out.println("Profile: " + profile + " Bean Profile: " + score.getProfile());
	System.out.println("Output: " + output + " Bean Output: " + score.getOutput());
	System.out.println("Session Id: " + sessionId); */
	
	if (session.getId() != null && sessionId != null) {
		if (sessionId.equals(session.getId())) {
			if (fileName.equals("choosefile")) {
		       	session.setAttribute("error", "Please, you must select a file to be scored.");
		       	response.sendRedirect("score.jsp");
			} else if (profile.equals("chooseprofile")) {
		       	session.setAttribute("error", "Please, you must select a profile.");
		       	response.sendRedirect("score.jsp");
			} else if (output.equals("chooseoutput")) {
		       	session.setAttribute("error", "Please, you must select an output type.");
		       	response.sendRedirect("score.jsp");
			} else if (score.score()) {
		       	response.sendRedirect("result.jsp");
			} else {
				session.setAttribute("error", "You file has not the right format");
		       	response.sendRedirect("score.jsp");
			}
		} else {
			session.setAttribute("error", "Your browser\'s session has expired. Try login again.");
			response.sendRedirect("login.jsp");
		}
	} else {
		response.sendRedirect("logout.jsp");
	}

%>