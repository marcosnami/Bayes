<%@ page import="java.io.*, java.util.*, java.text.*" %>

<% 
	String username = (String)session.getAttribute("username");
	String password = (String)session.getAttribute("password");
	String path = request.getParameter("path");
	//System.out.println("Username: " + username + " Password: " + password);
	//System.out.println("Path: " + path);
	
	if (username == null || password == null) {
		response.sendRedirect("login.jsp");
	}
	
	try {
		File file = new File(path);
		file.delete();
	} catch (Exception e) {
		System.out.println(e.getMessage());
	}
	
	response.sendRedirect("manageFiles.jsp");
	
%>
