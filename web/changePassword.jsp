<% 
	String username = (String)session.getAttribute("username");
	String password = (String)session.getAttribute("password");
	//System.out.println ("Username: " + username + " Password: " + password);
	
	if (username == null || password == null) {
		response.sendRedirect("login.jsp");
	}
%>

<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<div class="main-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Change Password</h3>
</div> 

<div class="row">
	<div class="col-sm-offset-5 col-sm-7">
	
<% 
	if (session.getAttribute("error") != null) {
		out.print("<div class=\"errors\"><ul><li>");
		out.print(session.getAttribute("error"));
		out.print("</li></ul></div>");
	}
	session.setAttribute("error", null);
%>

	</div>
</div>

<form class="form-horizontal" action="changePasswordBean.jsp" method="post" role="form" name="change-form">
	<div class="form-group">
	  	<label for="password" class="col-sm-offset-3 col-sm-2">Password*:</label>
	  	<div class="col-sm-4">
	   		<input type="password" class="form-control input-sm" id="password" name="password">
	  	</div>
	</div>
	<div class="form-group">
  		<label for="newPassword" class="col-sm-offset-3 col-sm-2">New Password*:</label>
  		<div class="col-sm-4">
   			<input type="password" class="form-control input-sm" id="newPassword" name="newPassword">
  		</div>
	</div>
	<div class="form-group">
  		<label for="confirm-password" class="col-sm-offset-3 col-sm-2">Confirm Password*:</label>
  		<div class="col-sm-4">
   			<input type="password" class="form-control input-sm" id="confirm-password" name="confirm-password">
  		</div>
	</div>
	<div class="form-group">
    	<div class="col-sm-offset-5 col-sm-4">
    		<label>
				<button type="submit" class="btn btn-primary btn-sm">SUBMIT</button>
			</label>
		</div>
	</div>
	<input type="hidden" name="session-id" value="<% out.print(session.getId()); %>">
</form>


<%@ include file="includes/footer.jsp" %>