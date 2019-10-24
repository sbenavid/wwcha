<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%@include file="sessiontimeout.jsp"%>

<%

String username = session.getAttribute("username").toString();

%>

<SCRIPT LANGUAGE="JavaScript">

function validateUsername(form)
{
   if (form.newUsername.value.length == 0)
   {
      alert("Please enter a username");
      return false;
   }
   else if ((form.newUsername.value.indexOf("@") == -1 ) ||
       (form.newUsername.value.indexOf(".") == -1 ))
   {
      alert("Username must be an e-mail address");
      return false;
   }

   return true;
}

function validatePassword(form)
{
   if (form.oldPassword.value.length == 0)
   {
      alert("Please enter your old password");
      return false;
   }
   if (form.newPassword.value.length == 0)
   {
      alert("Please enter a new password");
      return false;
   }
   if (form.newPasswordConf.value.length == 0)
   {
      alert("Please confirm your new password");
      return false;
   }
   if (form.newPassword.value != form.newPasswordConf.value)
   {
      alert("Passwords do not match. Please re-enter your new password");
      form.newPassword.value = "";
      form.newPasswordConf.value = "";
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
        
            <form name="updateUsername" onsubmit="return validateUsername(this)" method="POST" action="updateCustomerLogin_WSClient.jsp">
           
            <input type="hidden" name="updateType" value="Username">
 
            <table cellspacing="5" class="bold">
            <tr>
                <td colspan="5" height = "50" class="bold">Update Customer Login Credentials</td>
            </tr>              
            
            <tr><td><br>&nbsp;</td></tr>
            <tr>
                <td class="formlabel">New Username</td>
                <td><input name="newUsername" size="20" maxlength="50" tabindex="1" value="<%=username%>">&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr><td></td></tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Update" tabindex="2"></td>                
            </tr>            
            <tr><td colspan="5"><br><hr><br></td></tr>
            </form>
            
            <form name="updatePassword" onsubmit="return validatePassword(this)" method="POST" action="updateCustomerLogin_WSClient.jsp">
            
            <input type="hidden" name="updateType" value="Password">
            
            <tr>
                <td class="formlabel">Old Password</td>
                <td><input name="oldPassword" type="password" size="20" maxlength="50" tabindex="3">&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr>
                <td class="formlabel">New Password</td>
                <td><input name="newPassword" type="password" size="20" maxlength="50" tabindex="4">&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr>
                <td class="formlabel">Confirm New Password</td>
                <td><input name="newPasswordConf" type="password" size="20" maxlength="50" tabindex="5">&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr><td></td></tr>
          
            <tr>
                <td></td>
                <td><input type="submit" value="Update" tabindex="7"></td>                
            </tr>
            
            </table>  
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>
    

