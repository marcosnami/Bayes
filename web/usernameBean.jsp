<jsp:useBean id="username" class="com.bayescorp.beans.registerBean" scope="request">
    <jsp:setProperty property="email" name="username"/>
</jsp:useBean>

<%
	String email = (String)request.getParameter("email");
	String sessionId = (String)request.getParameter("session-id");
	
	if (session.getId() != null && sessionId != null) {
		if (sessionId.equals(session.getId())) {
			session.setAttribute("email", email);
			if (email.equals("") || email == null) {
	       		session.setAttribute("error", "All fields marked with an asterisk (*) are required.");
	       		response.sendRedirect("username.jsp");
			} else if (!username.emailExists()) {
	       		session.setAttribute("error", "Sorry, this email address is not register to your account.");
	       		response.sendRedirect("username.jsp");
			} else if (!username.retriveUsername()){
		       	session.setAttribute("error", "Sorry, there was a problem retriving your username.");
		       	response.sendRedirect("username.jsp");
			} else {
				session.setAttribute("username", username.getUsername());
		       	response.sendRedirect("successUsername.jsp");
			}
		} else {
			session.setAttribute("error", "Your browser\'s session has expired. Try again.");
			response.sendRedirect("username.jsp");
		}
	} else {
		response.sendRedirect("logout.jsp");
	}

%>