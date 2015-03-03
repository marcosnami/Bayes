<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>

<jsp:useBean id="activate" class="com.bayescorp.beans.registerBean" scope="request">
    <jsp:setProperty property="email" name="activate"/>
    <jsp:setProperty property="emailCode" name="activate"/>
</jsp:useBean>


<%
	String email = (String)request.getParameter("email");
	String emailCode = (String)request.getParameter("emailCode");
	//System.out.println("Email: " + email + " Email Code: " + emailCode);
	if (email == null || emailCode == null) {
		response.sendRedirect("logout.jsp");
	}
%>

<div class="bayes-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Activation</h3>
</div> 

<div class="bayes-message text-center">
	<% 
		if (!activate.emailExists()) {
			out.print("<p>Sorry, the email address " + email + "</p>");
			out.print("<p>is not the email address registered to your account.</p>");
		} else if (!activate.accountExists()) {
			out.print("<p>Sorry, We had problems activating your account.");
			out.print("<p>Please, perform the registration process one more time.</p>");
	%>
			<p><a href="<% out.print(BASE_URL); %>register.jsp">Go to Registration</a>
	<%
		} else if (!activate.activateAccount()) {
			out.print("<p>Sorry, We had problems activating your account.");
			out.print("<p>Please try activating your account again.</p>");
		} else {
			out.print("<p>Your account has been activated.</p>");
			out.print("<p>You are free to login!.</p>");
	%>
			<p><a href="<% out.print(BASE_URL); %>login.jsp">Go to Login</a>
	<%
		}
	%>
</div>

<%@ include file="includes/footer.jsp" %>