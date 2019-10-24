<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->


<%-- The following html code displays the result description --%>

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
        
            <table cellspacing="5" class="bold">
            <tr>
                <td colspan="2" height = "50" class="bold"><%= resultTitle %></td>
            </tr>              
            
            <tr>                
                <td><%= resultDescription %></td>
            </tr>
                            
            
            </table>       
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>