<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<% 
	String username = (String)session.getAttribute("username"); 
	String password = (String)session.getAttribute("password");
	//System.out.println("Username: " + username + " Password: " + password);
	if (username == null || password == null) {
		response.sendRedirect("logout.jsp");
	}
%>

<div class="main-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Success</h3>
</div> 

<div class="bayes-message text-center">
	<p>Your password has been changed successfully.</p>
</div>


<%@ include file="includes/footer.jsp" %>