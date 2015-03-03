<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>

<%
	String username = (String)session.getAttribute("username");
	if (username == null) {
		Cookie cookie = null;
		Cookie[] cookies = null;
		
		// Get an array of Cookies associated with this domain
		cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
		    	cookie = cookies[i];
		      	if (cookie.getName().equals("username")) {
		      		username = cookie.getValue();
		      	}
		   }
		}
	}	
	//session.setAttribute("contact_status","null");    			      					      			
%>
    
<div class="bayes-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Probability Score</h3>
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

<form class="form-horizontal" action="loginBean.jsp" method="post" role="form" name="login-form">
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
    	<div class="col-sm-offset-5 col-sm-4">
      		<label>
        		<input type="checkbox" name="remember" id="remember"> Remember me
      		</label>
    	</div>
  	</div>
	<div class="form-group">
    	<div class="col-sm-offset-5 col-sm-4">
    		<label>
				<button type="submit" class="btn btn-primary btn-sm">SIGN IN</button>
			</label>
		</div>
	</div>
	<div class="form-group">
    	<div class="col-sm-offset-3 col-sm-6">
    		<label>
    			<small>
    				<span class="glyphicon glyphicon-play" aria-hidden="true"></span>
    				&nbsp;First time user? <a href="<% out.print(BASE_URL); %>register.jsp">Register</a>.
   				</small>
 			</label>
 			<br>
    		<label>
    			<small>
    				<span class="glyphicon glyphicon-play" aria-hidden="true"></span>
    				&nbsp;Forgot 
    				<a href="<% out.print(BASE_URL); %>username.jsp?">Username</a> or 
    				<a href="<% out.print(BASE_URL); %>password.jsp?">Password</a>?
   				</small>
 			</label>
		</div>
	</div>
	<input type="hidden" name="session-id" value="<% out.print(session.getId()); %>">
</form>

	
<%@ include file="includes/footer.jsp" %>
