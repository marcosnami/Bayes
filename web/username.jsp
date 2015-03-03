<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>

<%
	String email = (String)session.getAttribute("email");
%>

<div class="bayes-logo text-center">
	<img class="img-responsive img-thumbnail" src="<% out.print(BASE_URL); %>img/logo.jpg" 
	alt="Bayes Corp Logo">
</div>

<div class="bayes-title text-center">
	<h4>BAYESCORP</h4>
</div>

<div class="bayes-subtitle text-center">
	<h3>Username Recovery</h3>
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

<form class="form-horizontal" action="usernameBean.jsp" method="post" role="form" name="username-form">
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
				<button type="submit" class="btn btn-primary btn-sm">SUBMIT</button>
			</label>
		</div>
	</div>
	<input type="hidden" name="session-id" value="<% out.print(session.getId()); %>">
</form>

<%@ include file="includes/footer.jsp" %>
