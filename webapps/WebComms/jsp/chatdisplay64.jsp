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
   //Copyright � 2014 Avaya Inc. All Rights Reserved
   
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
	}

    </script>

</HEAD>

<BODY onbeforeunload="handleOnClose()">
    
    <form name="chatform" method="POST">
                
        <table id="displayChat" class="chat_window" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="100%" id="webchat_display">

                        <!-- Chat History Area -->
                        <table cellSpacing="0" cellPadding="0" border="0"  width="100%" height="100%">  

                                <tr>
                                        <td valign="top" style="padding-left:20px;padding-right:20px;" >
                                                <table id="" valign="top" class="input_fields" height="100%" width="100%" border="0">
                                                        <tr>
                                                            <td colspan="2" align="center" valign="top">
                                                                <div align="left" id="chatterbox" name="history" class="webchat_history"><br></br>Esperando la conexion de un agente...</div>
                                                            </td> 
                                                        </tr>
                                                </table>
                                        </td>
                                </tr>

                        </table>
                        <!-- End Chat History Area -->
                </td>
            </tr>
        </table>
                
    </form>
    
<form name="exitform" method="POST" action="exitFormImpl64.jsp">
	<INPUT TYPE="hidden" NAME="sessionKey" VALUE="<%=sessionKey%>">
	<INPUT TYPE="hidden" NAME="contactID" VALUE="<%=contactID%>">
	<INPUT TYPE="hidden" NAME="inSession" VALUE="0">
</form>

</BODY>

</HTML>
