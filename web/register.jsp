<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>

<div class="bayes-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Registration</h3>
</div> 

<div class="row">
	<div class="col-sm-offset-5 col-sm-7">
	
<%
	String username = (String)session.getAttribute("username");
	String company = (String)session.getAttribute("company");
	String email = (String)session.getAttribute("email");

	if (session.getAttribute("error") != null) {
		out.print("<div class=\"errors\"><ul><li>");
		out.print(session.getAttribute("error"));
		out.print("</li></ul></div>");
	}
	session.setAttribute("error", null);
%>

	</div>
</div>

<form class="form-horizontal" action="registerBean.jsp" method="post" role="form" name="register-form">
	<div class="form-group">
	  	<label for="username" class="col-sm-offset-3 col-sm-2">Username*:</label>
	  	<div class="col-sm-4">
	   		<input type="text" class="form-control input-sm" id="username" name="username" 
	   		value="<% if (username != null) { out.print(username); }; %>">
	  	</div>
	</div>
	<div class="form-group">
  		<label for="password" class="col-sm-offset-3 col-sm-2">Password*:</label>
  		<div class="col-sm-4">
   			<input type="password" class="form-control input-sm" id="password" name="password">
  		</div>
	</div>
	<div class="form-group">
  		<label for="confirm-password" class="col-sm-offset-3 col-sm-2">Confirm Password*:</label>
  		<div class="col-sm-4">
   			<input type="password" class="form-control input-sm" id="confirm-password" name="confirm-password">
  		</div>
	</div>
	<div class="form-group">
  		<label for="company" class="col-sm-offset-3 col-sm-2">Company*:</label>
  		<div class="col-sm-4">
   			<input type="text" class="form-control input-sm" id="company" name="company"
   			value="<% if (company != null) { out.print(company); }; %>">
  		</div>
	</div>
	<div class="form-group">
  		<label for="email" class="col-sm-offset-3 col-sm-2">Email*:</label>
  		<div class="col-sm-4">
   			<input type="email" class="form-control input-sm" id="email" name="email"
   			value="<% if (email != null) { out.print(email); }; %>">
  		</div>
	</div>
	<div class="form-group">
    	<div class="col-sm-offset-5 col-sm-4">
    		<label>
				<button type="submit" class="btn btn-primary btn-sm">REGISTER</button>
			</label>
		</div>
	</div>
	<input type="hidden" name="session-id" value="<% out.print(session.getId()); %>">
</form>

<%@ include file="includes/footer.jsp" %>
