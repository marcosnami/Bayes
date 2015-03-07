<%@ page import="java.util.*" %>
<%@ page import="com.bayescorp.email.*" %> 

<jsp:useBean id="register" class="com.bayescorp.beans.registerBean" scope="request">
    <jsp:setProperty property="username" name="register"/>
    <jsp:setProperty property="password" name="register"/>
    <jsp:setProperty property="company" name="register"/>
    <jsp:setProperty property="email" name="register"/>
</jsp:useBean>

<%
	boolean isError = false;
	String[] required = {"username", "password", "confir-password", "company", "email"};
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirm-password");
	String company = request.getParameter("company");
	String email = request.getParameter("email");
	String sessionId = request.getParameter("session-id");
	 
	if (session.getId() != null && sessionId != null) {
		if (sessionId.equals(session.getId())) {
			session.setAttribute("username", username);
			session.setAttribute("company", company);
			session.setAttribute("email", email);
			Enumeration<String> paramNames = request.getParameterNames();
			while (paramNames.hasMoreElements()) {
				String paramName = (String)paramNames.nextElement();
			    String paramValue = request.getParameter(paramName);
			    //System.out.println("Parameter Name: " + paramName + " and Parameter Value: " + paramValue);
			    if (paramValue.equals("") && Arrays.asList(required).contains(paramName)) {
			isError = true;
			break;
			    }
		   	}
			
			if (isError) {
		       	session.setAttribute("error", "All fields marked with an asterisk (*) are required.");
		       	response.sendRedirect("register.jsp");
			} else if (username.contains(" ")) {
		       	session.setAttribute("error", "Sorry, username must not contain any spaces.");
		       	response.sendRedirect("register.jsp");
			} else if (register.usernameExists()) {
		       	session.setAttribute("error", "Sorry, the username " + register.getUsername() + " is already in use.");
		       	response.sendRedirect("register.jsp");
			} else if (password.length() < 8) {
		       	session.setAttribute("error", "Sorry, password must be at least 8 characters long.");
		       	response.sendRedirect("register.jsp");
			} else if (password.length() > 24) {
		       	session.setAttribute("error", "Sorry, password must not be longer than 24 characters.");
		       	response.sendRedirect("register.jsp");
			} else if (!password.equals(confirmPassword)) {
		       	session.setAttribute("error", "Sorry, password and confirm password do not match.");
		       	response.sendRedirect("register.jsp");
			} else if (!EmailValidator.validateEmailAddress(register.getEmail())) {
		       	session.setAttribute("error", "Sorry, a valid email address is required.");
		       	response.sendRedirect("register.jsp");
			} else if (register.emailExists()) {
		       	session.setAttribute("error", "Sorry, the email " + register.getEmail() + " is already in use.");
		       	response.sendRedirect("register.jsp");
			} else if (register.insert()) {
				if (register.usernameExists()) {
					session.setAttribute("email_code", register.getEmailCode());
			       	response.sendRedirect("success.jsp");
				}
			} else {
		       	session.setAttribute("error", "Sorry, there was a problem registering your account.");
		       	response.sendRedirect("register.jsp");
			}
		} else {
			session.setAttribute("error", "Your browser\'s session has expired. Try register again.");
			response.sendRedirect("register.jsp");
		}
	} else {
		response.sendRedirect("logout.jsp");
	}

%>
