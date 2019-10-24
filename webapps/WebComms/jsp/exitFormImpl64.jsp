<%-- 
    Document   : exitFormImpl64
    Created on : 26-Apr-2014, 10:17:33
    Author     : Administrator
--%>

<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>


<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright 2014 Avaya Inc. All Rights Reserved
   
   // This page contains logic to determine how the browser close events
   // are handled. If a customer is in an active session with an agent, a 
   // disconnect message is sent. If the customer is on hold waiting for 
   // an agent to join, the contact is dropped from the queue.

   String 		sessionKey;
   String 		contactID;
   String 		inSession;

   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");
   String webServerName  = application.getInitParameter("WEBCOMMS_HOSTNAME");
   String webServerPort  = application.getInitParameter("WEBCOMMS_PORT");
   String homePath = application.getInitParameter("HOME_PATH");
   
   
   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");
   inSession=request.getParameter("inSession");
   
   long lSession = new Long(inSession).longValue();

   try
   {

	java.net.URL ciWebCommsWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 

	CIWebCommsWs webCommsWsLocator = new CIWebCommsWsLocator();
	CIWebCommsWsSoap webCommsWs = webCommsWsLocator.getCIWebCommsWsSoap( ciWebCommsWsUrl );
		
	// We can either prefix the disconnect message with a generic customer prefix
	// as configured in the CCMM Administrator or alternatively we can choose to
	// prefix the disconnect message by the customer name
				
	String custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);
		
	// CICustomerChatNameReadType customerName = webCommsWs.getCustomerTextChatName(new Long(contactID).longValue(), sessionKey);
	// String custLabel = "[" + customerName.getFirstName() + " " + customerName.getLastName() + "]";
		

	// If the contact is still in the queue, i.e. an agent has not yet accepted the contact,
	// we want to abandon its queuing. If it is already in session, notify the agent of the
	// disconnect and let the agent clean up the session. We perform a read to check if the agent has just joined.
		
	
	java.util.GregorianCalendar gCalendar = new java.util.GregorianCalendar(2006, 1, 1, 12, 0, 0 );
	
	CIDateTime tm = new CIDateTime();
	tm.setMilliseconds(gCalendar.getTimeInMillis());
	
	
	CIMultipleChatMessageReadType chatMessages = new CIMultipleChatMessageReadType();
	
	chatMessages = webCommsWs.readChatMessage(new Long(contactID).longValue(), tm, false, sessionKey);

	
	CIChatMessageReadType[] arrayOfMessages = chatMessages.getListOfChatMessages();
	int length = 0;
	
	if(arrayOfMessages != null)
	{
	
	     length = arrayOfMessages.length;
	}
	
	if((length == 0) && (lSession==0))
	{
	    // not previously connected with agent and no new messages have arrived
	
	    long stat = webCommsWs.abandonQueuingWebCommsContact(new Long(contactID).longValue(), "Customer Abandoned Session", sessionKey); 
	} 
	else if((length > 0) && (lSession == 0))
	{
	    // not previously connected with agent but a new message has arrived

	   long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), custLabel + " Session Disconnected", "", CIChatMessageType.Session_Disconnected_by_Customer, sessionKey);    
	}
     	else
	{
	    // previously connected with an agent     
	    long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), custLabel + " Session Disconnected", "", CIChatMessageType.Session_Disconnected_by_Customer, sessionKey);
            
	}
	     

   }
   catch(Exception e)
   {
       // Handle exceptions....
   }

%>

<HTML>
<HEAD>

<script LANGUAGE="JavaScript">
    parent.location="endsession64.jsp";
</script>
	
</HEAD>
<BODY>
</BODY>
</HTML>
