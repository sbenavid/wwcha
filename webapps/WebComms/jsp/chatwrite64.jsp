<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>

<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright � 2014 Avaya Inc. All Rights Reserved

   String 		sessionKey;
   String 		contactID;
   String		message;
   String 		chatbox="";
   String		hiddenMessage="";
   String 		type="";
   String               telnumber="";
   
   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");
   message=request.getParameter("message");
   chatbox=request.getParameter("chatbox");
   hiddenMessage=request.getParameter("hiddenMessage");
   type=request.getParameter("type");
   telnumber = request.getParameter("telnumber");
   
   // Customer Question
   // String onHoldQuestion="";
   // onHoldQuestion = request.getParameter("onHoldQuestion");
   
   String newnumber = "";
   newnumber = request.getParameter("newnumber");
   
   
   if (telnumber == null)
   {
       telnumber = "";
   }
   
   if (newnumber == null)
   {
       newnumber = "";
   }
      
   // If this is an anonymous connection/session, set the phone number to empty.
   if (telnumber.equals("NONE"))
   {
       telnumber = "";
   }
   
   
   if (chatbox == null)
   {
	chatbox ="";
   }

   if (message == null)
   {
   	message = "null";
   }

   if (message.indexOf("null") == -1)
   {
	try
   	{
	
		java.net.URL ciWebCommsWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 

		CIWebCommsWs webCommsWsLocator = new CIWebCommsWsLocator();
		CIWebCommsWsSoap webCommsWs = webCommsWsLocator.getCIWebCommsWsSoap( ciWebCommsWsUrl );

		// We can either prefix the written message with a generic customer prefix
		// as configured in the CCMM Administrator or alternatively we can choose to
		// prefix the message by the customer name
		
                // Option1: Uncomment the section below to use the default [Customer] tag, as per CCMM Admin:
		/// String custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);

                // Option2: Get the name based on the contact ID:
                // Note: This can be empty/null in the case of a an anonymous chat implementation.
                
                String custLabel = "";
		CICustomerChatNameReadType customerName = webCommsWs.getCustomerTextChatName(new Long(contactID).longValue(), sessionKey);
                
                if(customerName.getFirstName() != null) // This may not be set if the session is an anonymous chat session:
                {
                    // Set the Customer label to be the Customer first name:
                    custLabel = "[" + customerName.getFirstName() + "]";
                }
                else
                {
                    custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);
                }
                                
		message = custLabel + " " + message;

   		// We must write the correct message type with the text. This allows the agent to correctly process
   		// the message e.g. display pushed page. The hiddenMessage is the URL of a pushed page.

		if(type.equals("Chat_Message_from_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, "", CIChatMessageType.Chat_Message_from_Customer, sessionKey);    
		}
		else if (type.equals("Page_Pushed_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Page_Pushed_by_Customer, sessionKey);    
		}
		else if (type.equals("Form_Shared_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Form_Shared_by_Customer, sessionKey);    
		}
		else if (type.equals("CallMe_Request_from_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.CallMe_Request_from_Customer, sessionKey);    
		}
		else if (type.equals("Page_Previewed_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Page_Previewed_by_Customer, sessionKey);    
		}
		else if (type.equals("Session_Disconnected_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Session_Disconnected_by_Customer, sessionKey);    
		}

	}
   	catch(Exception e)
   	{
   	
   		// We caught an exception while trying to write a chat message. The session has been disconnected. 
   		// Inform the customer that the agent has left the conversation and update the status.
   	
		%><script language="Javascript">
			parent.chatdisplay.document.chatform.chatterbox.value = parent.chatdisplay.document.chatform.chatterbox.value + "\n" + "Agent has left the conversation.";
			parent.chatdisplay.document.chatform.chatterbox.scrollTop = parent.chatdisplay.document.chatform.chatterbox.scrollHeight;
			parent.statuscontrol.document.statusform.status.value = "Session Disconnected";
			parent.statuscontrol.document.statusform.inSession.value = "0";

		</script><%
	}
   }

%>

<HTML>

  <style type="text/css">

    .textarea
    {
	color: ffffff;
	border: 0px;
	background-color:transparent;
	overflow:auto;
    }

    .customerchat
    {
	overflow:auto;
    }

    .status
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
	font-weight: bold;
    }

    .isWriting
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
	font-style: italic;
    }

    .table
    {
	position: absolute; top: 10px;
    }

  </style>
  <link rel="stylesheet" type="text/css" href="css/style.css" />
<HEAD>

<script LANGUAGE="JavaScript">

  NS4 = (document.layers) ? true : false;

  function checkEnter(event)
  { 	
	// If the enter key was pressed, send the message or assume a page preview.
	var code = 0;
       
	if (NS4)
		code = event.which;
	else
		code = event.keyCode;
            
	if (code==13)
	{
		sendChat();
		parent.chatwrite.document.chatform.submit();
                //parent.statuscontrol.RefreshChatHistory();
	}
        else
        {
           // NOTE: This exmaple implements the "Customer Is Typing"  feature
           // each time a key is pressed. To reduce the load on the server, this can
           // be reduced by only allowing this once per 'pre-submit' time interval.
            
           // Check if the customer is typing in the chat text-area: 
           // If text remmains in the text-area inform the agent that the
           // customer is typing a message:
           if (document.chatform.customerchat.value.length > 0)
           {
               parent.statuscontrol.InformCustomerIsTyping(true);
           }
           else // Customer has removed any text and is no longer typing: 
           {
               parent.statuscontrol.InformCustomerIsTyping(false);
           }
        }
  }
  
  
  function setfocus()
  {
  	document.chatform.customerchat.focus();
        
        var origTelNumber = "<%=telnumber%>";
        var updatedTelNumber = "<%=newnumber%>";
       
        // The page is reloaded everytime a message is sent.
        // Update the phone number field to be the correct value.
        if (updatedTelNumber.length > 0)
        {
            document.getElementById('phonenumber').value = updatedTelNumber;
        }
        else
        {
            document.getElementById('phonenumber').value = origTelNumber;
        }
  }


  function sendChat()
  {
    // Send the chat message only if there is an active session and there is a message to send.

    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("El mensaje no puede enviarse debido a que no hay un agente activo para esta conversacion.");
    }
    else
    {
    	
	if(parent.chatwrite.document.chatform.customerchat.value=="")
	{
	
	  // do nothing as the user has not entered a chat message
	  parent.chatwrite.document.chatform.message.value = "null";

	}
	else
	{
	  parent.chatwrite.document.chatform.customerchat.value = " " + parent.chatwrite.document.chatform.customerchat.value;
	  parent.chatwrite.document.chatform.message.value = parent.chatwrite.document.chatform.customerchat.value;
	  parent.chatwrite.document.chatform.type.value = "Chat_Message_from_Customer";
	  parent.chatwrite.document.chatform.hiddenMessage.value = "";
	  parent.chatwrite.document.chatform.customerchat.value = "";
          
          // Keep a copy of the latest customer Telephone number:
          parent.chatwrite.document.chatform.newnumber.value = document.getElementById('phonenumber').value;
          
	  message = null;
	}
    }
  }

  function printChat()
  {
     window.parent.chatdisplay.focus();
     window.print();
  }

  function exitChat()
  {
  	// Terminate the session if the user confirms.
  
  	var isSessionActive = parent.statuscontrol.document.statusform.inSession.value;
	var answer = confirm ("This will close your Web Chat session. Do you wish to continue?") 
	if (answer) 
	{
		// Close the session:
		// Session cleanup code is contained in exitFormImpl64.jsp
		
		parent.location="exitFormImpl64.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>&inSession=" + isSessionActive;	   
	}
  }
  
  function checkSpace(event)
  { 	
	return event.which !== 32;
  }
  
  function callMeBack()
  {
  
    // If the customer and agent are in an active session, then allow the customer
    // to request that the agent calls them. Prompt for a telephone number and
    // notify the agent of the request.
   
    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("Opcion no disponible debido a que no se encuentra en sesion de chat activa.");
    }
    else
    {

      var customerNumber = "";
      customerNumber = document.getElementById('phonenumber').value;
      
      if (0 == customerNumber.length)
      {
          // Ask the customer for their number
          customerNumber = prompt("Proporcione un numero al cual podeamos llamarle:", ""); 
          document.getElementById('phonenumber').value = customerNumber;
      }
            
      // Note: In this example, no validation of entered values are done...
      // Ensure the number you are passing to the agent is forrectly formatted
      
      if ((customerNumber != null) && (customerNumber.length > 0))
      {
      	 document.chatform.message.value = " El cliente solicito llamarle: " + customerNumber;
	 document.chatform.hiddenMessage.value = customerNumber;
	 document.chatform.type.value = "CallMe_Request_from_Customer";
         
         parent.chatwrite.document.chatform.newnumber.value = customerNumber;
         
      	 document.chatform.submit();
      }
      else
      {
         alert("Favor de proporcionar su telefono");
      }
    }
  }


</script>

</HEAD>

<body background="../images/bg2.gif" onload=setfocus()>

<table width="100%" height="70%" class="table">
 <tr>
  <td width="60%">
    <form name="chatform" method="POST">
      <textarea name="customerchat" class="customerchat" cols=65 rows=2 onkeypress="checkEnter(event)"></textarea>
      <input type="submit" id='enterButton' class="wc_submit" style="vertical-align:bottom;" value="Submit" onClick="sendChat();" />
      <input type="hidden" name="message" value="<%=message%>">
      <input type="hidden" name="chatbox" value="<%=chatbox%>">
      <input type="hidden" name="type" value="<%=type%>">
      <input type="hidden" name="hiddenMessage" value="<%=hiddenMessage%>">
      <input type="hidden" name="telnumber" value="<%=telnumber%>"><!-- Telephone number passed in by WebChat login screen -->
      <input type="hidden" name="newnumber" value="<%=newnumber%>">
  </form>
 </tr>
 <tr>
   <td width="60%" >
       <input class="customerchat" align="right" type="field" maxlength="24" disabled id="phonenumber" name="phonenumber" size="30" onKeyPress="return checkSpace(event)" />
       <input type="image" style="cursor:hand;padding-top:5px;padding-left:15px;padding-bottom:2px;padding-right:15px;vertical-align:bottom;" src="../images/icon_callme_small.gif" height="20" width="20" border="0" title="Ask the agent to call you" id='CallMeButton' onclick="callMeBack();"/>
       <input type="image" style="cursor:hand;padding-top:5px;padding-left:15px;padding-bottom:2px;padding-right:15px;vertical-align:bottom;" src="../images/close.png" height="20" width="20" border="0" title="Close my chat session" id='closeButton' onclick="exitChat();"/>       
   </td>
 </tr>
 
</table>
  
</BODY>
</HTML>
