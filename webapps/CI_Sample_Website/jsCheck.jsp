<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%

session.setAttribute("testSessionCookies", "enabled");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CCMM CI Sample Web Site</title>
    </head>
    
    <!-- if javascript is enabled the user will be redirected to the login page 
         when this page loads  -->    
    <body onload="location='scCheck.jsp'" >

    <!-- Set up the Main Table for the Web Page -->
    <table width="100%" border="0">
    <tr>
        
        <td height="80" colspan="3">
        <%@include file="header.html"%>
        </td>
    </tr>
    </table>
    <table width="800">
    <tr>
        <td width="200" height="900">            
        <%@include file="menu.jsp" %>
        </td>

        <td width="10"></td>

        <td width="590" height="900" valign="top">  
        
        <noscript>
            <b>
            <br>
            <font color="red"><h3>Javascript is not enabled in your browser</h3></font>
                This website requires Javascript to be enabled<br>
                Please enable Javascript before continuing</b>
            <br><br><br>
        </noscript>
        
        </td>
        
    </tr>       
    </table>            
    </body>
</html>
.