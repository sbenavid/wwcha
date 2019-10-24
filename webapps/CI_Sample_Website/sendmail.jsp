<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>

<%

  // strings used by the displayResultDescription.jsp page
  String resultTitle = "";
  String resultDescription = ""; 
  
  // ensure we are decoding the request parameters as UTF-8
  request.setCharacterEncoding("UTF-8");
  
  
  // get the Hostname of the SMTP server
  String emailServer = application.getInitParameter("EMAILSERVER_HOSTNAME"); 

  //check that the SMTP Server hostname is configured in the web.xml file i.e. that it is not the
  //default value
  if( emailServer.equals("{EMAILSERVER_HOSTNAME}") )
  {
      resultTitle = "<font color='red'>HTML Form Could Not be Sent</font>";
      resultDescription = "The EMAILSERVER_HOSTNAME property is not set in the file <font color='green'>\\CI_Sample_Website\\WEB-INF\\web.xml</font><br><br>" +
                          "Please set this property to be the hostname of your SMTP server";    
  }
  else
  {  
      
      // set up javamail properties 
      Properties props = new Properties();
      props.put("mail.smtp.host", emailServer);
      Session s = Session.getInstance(props,null);
    
      MimeMessage message = new MimeMessage(s);
    
      //set the From and To address
      String fromAddress = request.getParameter("From");
      InternetAddress from = new InternetAddress(fromAddress);
      message.setFrom(from);
      String toAddress = request.getParameter("To");
      InternetAddress to = new InternetAddress(toAddress);
      message.addRecipient(Message.RecipientType.TO, to);
    
      //set the subject and textPart ( body ) of the email
      String subject = request.getParameter("Subject");
	  
	  	//Release: CCMM 6.0  SU05  CR: Q01667461
		//Name: padraiwa - Padraic Walsh
		//Date: 09 August 2007
		//Comments:
		// Subject field wasn't submitting Chinese/Japanese characters correctly, UTF-8 encoding directive was left out (message.setText command was working fine!)
		
      message.setSubject(subject, "UTF-8");
      
      // body of email will display the results of the HTML Form 
      String textPart = "\n" + application.getInitParameter("HTML_FORM_RESULT_HEADER") + "\n" +
                    "=======================================================" +
                    "\n\n" + 
                    "Text Field 1 : " + request.getParameter("textField1") + "\n\n" +
                    "Text Field 2 : " + request.getParameter("textField2") + "\n\n" +
                    "Choice 1     : " + request.getParameter("choice1") + "\n\n" +
                    "Choice 2     : " + request.getParameter("choice2") + "\n\n" +
                    "<Start Text Area>\n\n" + 
                    request.getParameter("TxtArea") + 
                    "\n\n<End Text Area>";
      
      
      message.setText(textPart, "UTF-8");
      
      Transport.send(message);
      
      resultTitle = "Submit HTML Form";
      resultDescription = "HTML Form Successfully Sent as an Email";  
  
  }
  
%>


<%@include file="displayResultDescription.jsp"%>
 
