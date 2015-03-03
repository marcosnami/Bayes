<jsp:useBean id="password" class="com.bayescorp.beans.registerBean" scope="request">
    <jsp:setProperty property="email" name="password"/>
    <jsp:setProperty property="username" name="password"/>
</jsp:useBean>

<%
	String email = (String)request.getParameter("email");
	String username = (String)request.getParameter("username");
	String sessionId = (String)request.getParameter("session-id");
	
	if (session.getId() != null && sessionId != null) {
		if (sessionId.equals(session.getId())) {
			session.setAttribute("username", username);
			session.setAttribute("email", email);
			if (email.equals("") || email == null || username.equals("") || username == null) {
	       		session.setAttribute("error", "All fields marked with an asterisk (*) are required.");
	       		response.sendRedirect("password.jsp");
			} else if (!password.emailExists()) {
	       		session.setAttribute("error", "Sorry, this email address is not register to your account.");
	       		response.sendRedirect("password.jsp");
			} else if (!password.usernameExists()) {
		       	session.setAttribute("error", "Sorry, this username is not register to your account.");
		       	response.sendRedirect("password.jsp");
			} else if (!password.resetPassword()) {
		       	session.setAttribute("error", "Sorry, there was a problem resetting your password.");
		       	response.sendRedirect("password.jsp");
			} else {			
				session.setAttribute("password", password.getPassword());
		       	response.sendRedirect("successPassword.jsp");
			}
		}
	} else {
		response.sendRedirect("logout.jsp");
	}
		
%>