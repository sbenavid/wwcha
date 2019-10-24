<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%

    session.removeAttribute("username");
    session.removeAttribute("sessionKey");
    session.removeAttribute("clientClockError");
    
    
    String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");   
   
    // Set up the Utility Web Service URL
    
    java.net.URL ciUtilityWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx"); 
    
    //Axis - Recommended way to call a web service
    CIUtilityWs utilityLocator = new CIUtilityWsLocator();
    CIUtilityWsSoap utilityWs = utilityLocator.getCIUtilityWsSoap( ciUtilityWsUrl); //Pass in the url that was setup above
    
    //get the serverTime, this used later to calculate any differences between client and server time
    CIDateTime serverTime = utilityWs.getServerTime(); //Used to calc the difference between the server and customer time for callbacks
    
    long serverTimeMS = serverTime.getMilliseconds();
    
%>

<SCRIPT LANGUAGE="JavaScript">


// here we find if the client clock is incorrect and by what margin
// by comparing it's (UTC) millisecond value against the CCMM server's (UTC) millisecond value
var clientTime = new Date();
var localClockErrorMS = clientTime.getTime() - <%= serverTimeMS %>;

//find the number of minutes difference
var localClockError = localClockErrorMS / ( 1000 * 60); // Time difference between the Customer and Server (Minutes)

//round this to a whole number
localClockError = Math.round(localClockError);

// convert back to milliseconds, this value will be used to set the value
// of the clientClockError hidden input field in the form below
// this field is then read by loginCustomer_WSClient.jsp and stored in a session variable
localClockError = localClockError * ( 1000 * 60 );

// function to validate the user's input

function validateLogin(form)
{
   if (form.username.value.length == 0)
   {
      alert("Please enter a username");
      return false;
   }
   if (form.password.value.length == 0)
   {
      alert("Please enter a password");
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
            
            <form name="loginform" onsubmit="return validateLogin(this)" method="POST" action="loginCustomer_WSClient.jsp">
            
            <input type="hidden" name="forceLogoff" value="false">
            
            <script language="javascript">
            
            	document.write("<input type='hidden' name='clientClockError' value='" + localClockError + "'>");
                        
            </script>
       
            
            <table cellspacing="5">
            <tr>
                <td colspan="2" height = "50" class="bold">Login Customer</td>
            </tr>            
            <tr>
                <td class="formlabel">Username</td>
                <td><input name="username" size="20" maxlength="50">&nbsp;<font color="red">*</font></td>                
            </tr>
            <tr>
                <td class="formlabel">Password</td>
                <td><input type=password name="password" size="20" maxlength="50">&nbsp;<font color="red">*</font></td>
            </tr>
            <tr>
                <td><br><br></td>
                <td><input type=submit value="  Login  "></td>
            </tr>            
            <tr> 
                <td>&nbsp;</td>
                <td><a  href="passwordReminder.jsp">Login Assistance</a></td>
            </tr>
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>


