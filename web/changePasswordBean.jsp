<%@ page import="java.util.*" %>

<jsp:useBean id="change" class="com.bayescorp.beans.registerBean" scope="request">
    <jsp:setProperty property="password" name="change"/>
    <jsp:setProperty property="newPassword" name="change"/>
</jsp:useBean>

<%
	boolean isError = false;
	String[] required = {"password", "newPassword", "confirm-password"};
	String username = (String)session.getAttribute("username");
	String password = request.getParameter("password");
	String newPassword = request.getParameter("newPassword");
	String confirmPassword = request.getParameter("confirm-password");
	String sessionId = request.getParameter("session-id");
	 
	if (session.getId() != null && sessionId != null) {
		if (sessionId.equals(session.getId())) {
			change.setUsername(username);
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
		       	response.sendRedirect("changePassword.jsp");
			} else if (!change.passwordMatch()) {
		       	session.setAttribute("error", "Sorry, your current password is incorrect.");
		       	response.sendRedirect("changePassword.jsp");
			} else if (newPassword.length() < 8) {
		       	session.setAttribute("error", "Sorry, the new password must be at least 8 characters long.");
		       	response.sendRedirect("changePassword.jsp");
			} else if (newPassword.length() > 24) {
		       	session.setAttribute("error", "Sorry, the new password must not be longer than 24 characters.");
		       	response.sendRedirect("changePassword.jsp");
			} else if (!newPassword.equals(confirmPassword)) {
		       	session.setAttribute("error", "Sorry, the new password and confirm password do not match.");
		       	response.sendRedirect("changePassword.jsp");
			} else if (!change.changePassword()) {
		       	session.setAttribute("error", "Sorry, there was a problem changing your password.");
		       	response.sendRedirect("changePassword.jsp");
			} else {
				session.setAttribute("password", change.getNewPassword());
		       	response.sendRedirect("successChangePassword.jsp");
			}
		}
	} else {
		response.sendRedirect("logout.jsp");
	}

%>
