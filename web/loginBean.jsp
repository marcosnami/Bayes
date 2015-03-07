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
	//System.out.println("Session Id: " + session.getId());
	
	if (session.getId() != null && sessionId != null) {
		//System.out.println("Session Id is not null");
		if (sessionId.equals(session.getId())) {
			//System.out.println("Session Id is equal session id from the form");
			if (username.equals("") || username == null || password.equals("") || password == null) {
				//System.out.println("Username is equal null");
		       	session.setAttribute("error", "All fields marked with an asterisk (*) are required.");
		       	response.sendRedirect("login.jsp");
			} else if (login.isValidate()) {
				//System.out.println("Validate Login");
		  		session.setAttribute("username",login.getUsername());
		       	session.setAttribute("password",login.getPassword());
				if (remember != null) {
					//System.out.println("Remember is not null");
			    	// Create cookies for first and last names.      
		    	   	Cookie userName = new Cookie("username", username);
		    	   	// Set expiry date after 24 Hrs for both the cookies.
		    	   	userName.setMaxAge(60*60*24*30); 
		    	   	// Add both the cookies in the response header.
		    	   	response.addCookie(userName);
				}
				//System.out.println("Send to Home.jsp");
		       	response.sendRedirect("home.jsp");
	       	} else {
	    		//System.out.println("If not validate");
		       	session.setAttribute("error", "Sorry, logging failed. Please try again.");
		       	response.sendRedirect("login.jsp");
		   	}
		} else {
			session.setAttribute("error", "Your browser\'s session has expired. Try login again.");
			response.sendRedirect("login.jsp");
		}
	} else {
		//System.out.println("Session Id is null");
		response.sendRedirect("login.jsp");
	}
   	
%>
