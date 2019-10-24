<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

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
        
        <%
        if( session.getAttribute("testSessionCookies") == null )
        {
        %>
        <b>
        <br>
        <font color="red"><h3>Cookies are not enabled in your browser</h3></font>
        This website uses temporary Session Cookies and will not function correctly if cookies are
        disabled<br>
        Please enable Cookies for this website before continuing</b>
        <br><br><br>
        
        <%		
        } else {
        %>
        
        <script language="javascript">
        	location='loginCustomer.jsp';
        </script>
        
        <% } %>
       
        </td>
        
    </tr>       
    </table>            
    </body>
</html>
.