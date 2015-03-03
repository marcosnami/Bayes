<jsp:useBean id="login" class="com.bayescorp.beans.loginBean" scope="request">
    <jsp:setProperty property="username" name="login"/>
    <jsp:setProperty property="password" name="login"/>
</jsp:useBean>

<%	

	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String remember = request.getParameter("remember");
	String sessionId = request.getParameter("session-id");
	//System.out.println("Session Id: " + sessionId);
	
	if (session.getId() != null && sessionId != null) {
		if (sessionId.equals(session.getId())) {
			if (username.equals("") || username == null || password.equals("") || password == null) {
		       	session.setAttribute("error", "All fields marked with an asterisk (*) are required.");
		       	response.sendRedirect("login.jsp");
			} else if (login.isValidate()) {
		  		session.setAttribute("username",login.getUsername());
		       	session.setAttribute("password",login.getPassword());
				if (remember != null) {
			    	// Create cookies for first and last names.      
		    	   	Cookie userName = new Cookie("username", username);
		    	   	// Set expiry date after 24 Hrs for both the cookies.
		    	   	userName.setMaxAge(60*60*24*30); 
		    	   	// Add both the cookies in the response header.
		    	   	response.addCookie(userName);
				}
		       	response.sendRedirect("home.jsp");
	       	} else {
		       	session.setAttribute("error", "Sorry, logging failed. Please try again.");
		       	response.sendRedirect("login.jsp");
		   	}
		}
	} else {
		response.sendRedirect("logout.jsp");
	}
   	
%>
