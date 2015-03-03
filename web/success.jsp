<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ include file="includes/config.jsp" %> 
<%@ include file="includes/header.jsp" %>

<%
	String username = (String)session.getAttribute("username");
	String emailCode = (String)session.getAttribute("email_code");
	String email = (String)session.getAttribute("email");
	//System.out.println("Username: " + username + " Email Code: " + emailCode + " Email: " + email);
	if (username == null || emailCode == null || email == null) {
		%>
		<jsp:forward page="logout.jsp"/>
		<%
	}
	// Recipient's email ID needs to be mentioned.
   	String to = email;

   	// Sender's email ID needs to be mentioned
   	String from = "support@bayescorp.com";

   	// Assuming you are sending email from a server provider
   String host = "smtp.mmaweb.net";
   final String userId = "support@bayescorp.com";
   final String password = "Bl@ckD0g";
   String port = "465";

   // Get system properties object
   Properties properties = new Properties();

   // Setup mail server
   properties.put("mail.smtp.host", host);
   properties.put("mail.user", userId);
   properties.put("mail.password", password);
   properties.put("mail.smtp.auth", true);
   properties.put("mail.smtp.port", port);
   properties.put("mail.smtp.socketFactory.port", "465");  
   properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
   
   // Get the default Session object.
   Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
	   protected PasswordAuthentication getPasswordAuthentication() {
		   return new PasswordAuthentication(userId, password);
	   }
   });

   try {
      	// Create a default MimeMessage object.
     	MimeMessage message = new MimeMessage(mailSession);
      	// Set From: header field of the header.
      	message.setFrom(new InternetAddress(from));
      	// Set To: header field of the header.
      	message.addRecipient(Message.RecipientType.TO,
                               new InternetAddress(to));
      	// Set Subject: header field
      	message.setSubject("Activate your account");
      	// Now set the actual message
      	message.setText("Hello " + username + ", \n\n" + 
      		"Please to activate your account, click on the link below: \n" +
			"http://www.bayescorp.com/BayesDev-0.1-dev/activate.jsp?email=" + email + "&emailCode=" + emailCode + "\n\n" +
      		"Regards. \n\n" +
			"Bayescorp");
      	// Send message
      	Transport.send(message);
   	} catch (MessagingException mex) {
      	System.out.println(mex.getMessage());
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
	<h3>Success</h3>
</div> 

<div class="bayes-message text-center">
	<p>You have been registered successfully.</p>
	<p>Before the account can be used it has to be activated.</p>
	<p>Please check your email provided at registration time to activate your account.</p>
</div>


<%@ include file="includes/footer.jsp" %>