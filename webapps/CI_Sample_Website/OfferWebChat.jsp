<%-- 
    Document   : OfferWebChat.jsp
--%>
<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2014 Avaya Inc. All Rights Reserved
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
        <title>Web Chat Offer Sample</title>
    </head>
    <body onload="Javascript:showQuestionWin()">

        <table id="winDisplay" class="popover_window_confirm" style="display:none;" cellSpacing="0" cellPadding="0" border="0">
            <tr>
                    <td>   
                    <table id="" cellSpacing="0" cellPadding="0" border="0" class="top_gradient">  

                            <!-- Header --> 
                            <tr height="70">
                                <td width="81" style="padding-top:25px;padding-left:50px;" align="right" valign="top" ><img alt="" src="img/smallLogo.png" /></td>
                                <td width="349" style="padding-top:25px;padding-left:15px;" align="left" valign="top"><img alt="" src="img/chat.png"/></td>
                            </tr>
                            <!-- End Header --> 

                            <!-- Question --> 
                            <tr>
                                    <td rowspan="2" style="padding-left:20;" ><img src="img/avaya_agent.png" border="0" class="webchat_agent_image"></td>
                                    <td style="padding-top:30;padding-left:30;">Would you like to chat with an agent?</td>
                            </tr>
                            <tr>
                                    <td style="padding-top:20; padding-bottom:20;" align="middle"><INPUT TYPE="submit"onClick="LoadAgent()" value="Yes"> <INPUT TYPE="submit"onClick="closeQuestionWin()" value="No"></td>
                            </tr>
                            <!-- End Question --> 

                    </table>
                    </td>
            </tr>

            <!-- Footer -->
            <tr height="50">
                    <td class="bottom_gradient" width="100%">
                            <div>
                                    <span class="powered_by">Powered by Avaya Aura Contact Center</span>
                            </div>
                    </td>
            </tr>
            <!-- End Footer -->

    </table>

<script type="text/javascript">

function showQuestionWin() 
{ 
	document.getElementById('winDisplay').style.display = "";
}

function closeQuestionWin() 
{  
	window.close();
}

function LoadAgent()
{
    window.open('WebChatLogin.jsp', 'WebChat', 'width=430, height=400, resizable=0')
}

</script>        
        
    </body>
</html>
