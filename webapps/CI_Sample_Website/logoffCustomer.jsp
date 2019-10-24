<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="sessiontimeout.jsp"%>

<SCRIPT LANGUAGE="JavaScript">

function validateLogoff(form)
{
   if (form.username.value.length == 0)
   {
      alert("Please enter a username");
      return false;
   }
}

</SCRIPT>

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
            
            <form name="logoffform" onsubmit="return validateLogoff(this)" method="POST" action="logoffCustomer_WSClient.jsp">

            <input type="hidden" name="sessionKey" value="<%=session.getAttribute("sessionKey") %>" >
           
            <table cellspacing="5">
            <tr>
                <td colspan="2" height = "50" class="bold">Logoff Customer</td>
            </tr>            
                                   
            <%-- we have already checked for the case of the username being null by including sessiontimeout.jsp at the
                 top of this page, the sessiontimeout.jsp page checks for this condition --%>
            <tr>
                <td class="formlabel">Username</td>
                <td><input name="username" size="20" maxlength="50" readonly="true" value="<%=session.getAttribute("username")%>"></td>                
            </tr>
            
            <tr>
                <td><br><br></td>
                <td><input type=submit value="Logoff">
            </tr>            
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>
