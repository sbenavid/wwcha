<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<SCRIPT LANGUAGE="JavaScript">

function validateLogin(form)
{
   if (form.emailAddress.value.length == 0)
   {
      alert("Please enter an Email Address");
      return false;
   }
   if ((form.emailAddress.value.indexOf("@") == -1 ) ||
       (form.emailAddress.value.indexOf(".") == -1 ))
   {
      alert("Email Address is not valid");
      return false;
   }
   return true;
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
            
            <form name="reminderform" onsubmit="return validateLogin(this)" method="POST" action="passwordReminder_WSClient.jsp">
            <table cellspacing="5">
            <tr>
                <td colspan="3" height = "50" class="bold">Password Reminder</td>
            </tr>
            <tr>
                <td colspan="3" height = "50"><b>Please enter your email address below and a password reminder email will be sent to this address</b></td>
            </tr>
            <tr>
                <td class="formlabel">Email Address</td>
                <td><input name="emailAddress" size="20" maxlength="50">&nbsp;<font color="red">*</font></td>                
                <td width="45%">&nbsp;&nbsp;</td>
            </tr>            
            <tr>
                <td><br><br></td>
                <td><input type=submit value="Submit"></td>
                <td width="45%">&nbsp;&nbsp;</td>
            </tr>             
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>


