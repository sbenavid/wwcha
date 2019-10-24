<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>

<%


   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved


   String 		sessionKey;
   String 		contactID;
   String		message;
   String 		chatbox="";
   String		hiddenMessage="";
   String 		type="";

   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");
   message=request.getParameter("message");
   chatbox=request.getParameter("chatbox");
   hiddenMessage=request.getParameter("hiddenMessage");
   type=request.getParameter("type");



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
		
		String custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);

		// CICustomerChatNameReadType customerName = webCommsWs.getCustomerTextChatName(new Long(contactID).longValue(), sessionKey);
		// String custLabel = "[" + customerName.getFirstName() + " " + customerName.getLastName() + "]";


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
	}

  }
  
  function setfocus()
  {
  	document.chatform.customerchat.focus();
  }


  function sendChat()
  {

    // Send the chat message only if there is an active session and there is a message to send.

    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("El mensaje no puede ser enviado, pues no hay un agente activo en la conversacion.");
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
	var answer = confirm ("This will close your Web Communications session. Are you sure?") 
	if (answer) 
	{
		parent.statuscontrol.document.statusform.inSession.value="2";

		top.mainFrame.location="endsession.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>&inSession=" + isSessionActive;	   

	}

  }

</script>

</HEAD>

<body background="../images/bg2.gif" onload=setfocus()>

<table width="100%" height="70%" class="table">
 <tr>
  <td width="90%">
    <form name="chatform" method="POST">
      <textarea name="customerchat" class="customerchat" cols=65 rows=2 onKeyPress="checkEnter(event)"></textarea>
      <input type="image" src="../images/icon_ui_send_on.gif" BORDER="0" ALT="Send" onclick="sendChat()">
      <input type="hidden" name="message" value="<%=message%>">
      <input type="hidden" name="chatbox" value="<%=chatbox%>">
      <input type="hidden" name="type" value="<%=type%>">
      <input type="hidden" name="hiddenMessage" value="<%=hiddenMessage%>">
  </form>
  </td>
  <td width="5%">
    <input type="image" src="../images/icon_ui_print_on.gif" BORDER="0" ALT="Print" onclick="printChat()">
  </td>
  <td width="5%">
    <input type="image" src="../images/icon_ui_exit_on.gif" BORDER="0" ALT="Exit" onclick="exitChat()">
  </td>
 </tr>
</table>



</BODY>
</HTML>
