<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CCMM CI Sample Web Site</title>
    </head>
    <body>

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

            <br><br><br><br>
            <b>This Sample Web Site is configured to use the CCMM Server : <br><font color="red"><%= ccmmHostname %></font><br>
            <br>
            <b>To change the default CCMM Server hostname that is used by the Sample Web Site, Edit the 
               CCMM_HOSTNAME entry in the web.xml file</b>
            <br><br><br>
        
        </td>
        
    </tr>       
    </table>            
    </body>
</html>
.