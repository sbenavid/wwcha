<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>
<%@ page info="Chat" %>


<HTML>

  <style type="text/css">

    .textarea
    {
	color: ffffff;
	border: 0px;
	background-color:transparent;
	overflow:auto;
    }


  </style>

<%



   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved

   
   // This page contains an embedded form to manage the reaction
   // to browser close events i.e. abandon queuing the chat request 
   // to an agent if the customer is still holding or send a disconnect 
   // message to the agent if active in a session.


   String 		sessionKey;
   String 		contactID;

   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");

%>

<HEAD>

    <script type="text/javascript">

	function handleOnClose()
	{
	    exitform.inSession.value = parent.statuscontrol.document.statusform.inSession.value;    
	    exitform.submit();
	}

    </script>

</HEAD>

<BODY  bgcolor="E0E0E0" text="CC0000" onbeforeunload="handleOnClose()">

<form name="chatform" method="POST">

<table border="0" width="98%">
 <tr>
  <td width="5%">
  </td>
  <td width="90%">
    <DIV id=chatterbox ALIGN=left STYLE="background-color:transparent;
    	font-face:Arial; scrollbar-base-color:#99ccff; overflow:auto;"></DIV>
  </td>
  <td width="5%">
  </td>
 </tr>
</table>


</form>

<form name="exitform" method="POST" action="exitFormImpl.jsp">

	<INPUT TYPE="hidden" NAME="sessionKey" VALUE="<%=sessionKey%>">
	<INPUT TYPE="hidden" NAME="contactID" VALUE="<%=contactID%>">
	<INPUT TYPE="hidden" NAME="inSession" VALUE="0">
	
</form>

</BODY>

</HTML>
