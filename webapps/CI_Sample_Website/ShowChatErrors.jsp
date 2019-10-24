<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright 2014 Avaya Inc. All Rights Reserved
   
   //This page is displayed if it was not possible to connect the customer to a web chat agent.
   
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String errCode = "0";
    String errMessage = "No Errors report";
    errCode = request.getParameter("errCode");
    
    if(errCode.equals("webchat_max_concurrent_per_customer"))
    {
        // Display the following message:
        errMessage = "Unable to connect chat session: You have reached a maximum of concurrent chat sessions.";
    }
    else if (errCode.equals("webchat_max_concurrent_per_skillset"))
    {
        errMessage = "Unable to connect chat session: There are currently no agents available to answer your chat.";
    }
    else if (errCode.equals("webchat_no_agents"))
    {
        errMessage = "Unable to connect chat session: There are no agents available to answer your chat at this time.";
    }
    else if (errCode.equals("webchat_skillset_oos"))
    {
        errMessage = "Unable to connect chat session: There are no agents available to answer your chat at this time.";
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<link rel="stylesheet" type="text/css" href="css/style.css" />
                
                <script type="text/javascript"> 
                    
                function onLoadDo()
                {
                        //	On window load resize
                        resizeWindow(438, 438, 438, 415, 433, 397, 0);
                }
                
                //	Resize pop-up according to browser used, and by possible extending length
                function resizeWindow(ffPixelWidth, crPixelWidth, iePixelWidth, ffPixelLength, crPixelLength, iePixelLength, extendLength)
                {
                        if (/Firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent))
                                window.resizeTo(ffPixelWidth, ffPixelLength + extendLength);	//	Firefox
                        else if(navigator.userAgent.indexOf("Chrome") != -1)
                                window.resizeTo(crPixelWidth, crPixelLength + extendLength);	//	Chrome
                        else if(navigator.appName == "Microsoft Internet Explorer")
                        {
                                extendLength -= extendLength/14;
                                window.resizeTo(iePixelWidth, iePixelLength + extendLength);	//	IE
                        }
                        else 
                                window.resizeTo(iePixelWidth, iePixelLength + extendLength);	//	Resize others as of IE
                }

                </script>
                
                
                
	</head>

	<body onload="Javascript:onLoadDo()" style="margin:0px;">
            
            <table id="banner" class="top_gradient" width="100%" border="0" cellspacing="0" cellpadding="0">
            
                <!--	Header & Logo	-->	
                <tr>
                        <td width="81" style="padding-top:25px;padding-left:50px;" align="right" valign="top" ><img alt="" src="img/smallLogo.png" /></td>
                        <td width="349" style="padding-top:25px;padding-left:15px;" align="left" valign="top"><img alt="" src="img/chat.png"/></td>
                        <td/> </td>
                </tr>
                
                <!-- Goodbye Message -->
                <tr height="200">
                    <td colspan="3" align="center"><label style="font-size:13.0pt; padding-left:35px; padding-right:35px;"><%=errMessage%></label></td>
                </tr>
               
            </table>
	</body>
</html>
