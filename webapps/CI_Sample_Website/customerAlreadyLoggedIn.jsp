<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%

    session.removeAttribute("username");
    session.removeAttribute("sessionKey");
    
    // ensure we are decoding the request parameters as UTF-8
    request.setCharacterEncoding("UTF-8");
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");
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
            
        <%-- this form is used to forward the parameter to the loginCustomer_WSClient page if the
             customer chooses to continue --%>
        <form name="loginCustForm" action="loginCustomer_WSClient.jsp" method="POST">
            <input type="hidden" name="username" value="<%=username%>">
            <input type="hidden" name="password" value="<%=password%>">
            <input type="hidden" name="forceLogoff" value="true">
        </form>
        
            <table cellspacing="5">
            <tr>
                <td colspan="4" height = "50" class="bold">Customer Already Logged In</td>
            </tr>            
            <tr>
                <td colspan="4" class="infotext">
                Customer <font color="green"><%=username%></font> is already logged in<br>if you continue this customer will be first logged off and then logged in again
                <br><br><br>Do you wish to continue ?
                </td>
            </tr>
            <tr><td colspan="4">&nbsp;</td></tr>
            <tr>
                <td width="35%">&nbsp;</td>
                <td><input type="button" value="  Yes  "  onClick="javascript:document.loginCustForm.submit()"></td>
                <td><input type="button" value="  No   "  onclick="location.href='loginCustomer.jsp'" ></td>
                <td width="35%">&nbsp;</td>
            </tr>            
            </table>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>
