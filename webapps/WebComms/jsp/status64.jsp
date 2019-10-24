<%
//Avaya Aura Contact Center Multimedia 
//Copyright 2014 Avaya Inc. All Rights Reserved.
    
String 		sessionKey;
String 		contactID;

sessionKey=request.getParameter("sessionKey");
contactID=request.getParameter("contactID");
%>

<HTML>
    <head>
  <style type="text/css">

    .status
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
	font-weight: bold;
    }

    .queue
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
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
	position: absolute; top: 1px;
    }

  </style>
  
  <script language="JavaScript">

        // This function is called from the customer chat window.
        // It sets a "customerTyping" hidden field and POSTS to the
        // hiden64.jsp file. Based on this value, the AACC server is
        // notified of the customer typing status.
        function InformCustomerIsTyping(bIsTyping)
        {
            if (bIsTyping)
            {
                document.statusform.customerTyping.value = "1";
            }
            else       
            {
                document.statusform.customerTyping.value = "0";
            }
            
            document.statusform.submit();
        }
        
        // This function is used to reload the hidden64.jsp page.
        // Typically called afater a Customer submits a chat text from
        // the chat text area.
        function RefreshChatHistory()
        {
            // Ensure that customerTyping is not set.
            document.statusform.customerTyping.value = "0";
            // submit and POST to hidden64.jsp.
            document.statusform.submit();
        }
        
  </script>
    </head>

<body background="../images/bg2.gif">
<!-- On Submit POST hidden data to hidden64.jsp -->
<form name="statusform" method="POST" action="hidden64.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" target="wcControl">

<table width="70%" height="95%" class="table">
 <tr>
  <td width="100%">
    <input type=text name="status" class="status" value="Status: Not Connected" size=20><br>
    <input type=text name="isWriting"  size=30 class="isWriting">
    <input type=text name="expectedWaitTime" size=32 class="queue"><br>
    <input type=text name="positionInQueue" size=20 class="queue">
    <input type=hidden name="inSession">
    <input type=hidden name="customerTyping" value="0">
  </td>
 </tr>
</table>
</form>

</BODY>
</HTML>
