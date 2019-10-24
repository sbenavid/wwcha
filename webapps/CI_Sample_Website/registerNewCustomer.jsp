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
    
    String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");   
        
    // Set up the Utility Web Service URL
        
    java.net.URL ciUtilityWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx"); 
        
    CIUtilityWs utilityLocator = new CIUtilityWsLocator();
    CIUtilityWsSoap utilityWs = utilityLocator.getCIUtilityWsSoap( ciUtilityWsUrl);
        
    //get the serverTime, this used later to calculate any differences between client and server time
    CIDateTime serverTime = utilityWs.getServerTime();
        
    long serverTimeMS = serverTime.getMilliseconds();

%>

<script language = "JavaScript">


// here we find if the client clock is incorrect and by what margin
// by comparing it's (UTC) millisecond value against the CCMM server's (UTC) millisecond value
var clientTime = new Date();
var localClockErrorMS = clientTime.getTime() - <%= serverTimeMS %>;

//find the number of minutes difference
var localClockError = localClockErrorMS / ( 1000 * 60);

//round this to a whole number
localClockError = Math.round(localClockError);

// convert back to milliseconds, this value will be used to set the value
// of the clientClockError hidden input field in the form below
// this field is then read by loginCustomer_WSClient.jsp and stored in a session variable
localClockError = localClockError * ( 1000 * 60 );

//Update the read-only email textbox to display the username
function populate_email(form)
{
	form.emailAddress.value=form.username.value;
}

function validateRegister(form)
{	
   
   if (form.username.value.length == 0)
   {
      alert("Please enter a username");
      return false;
   }

   if ((form.username.value.indexOf("@") == -1 ) ||
       (form.username.value.indexOf(".") == -1 ))
   {
      alert("Username must be an e-mail address");
      return false;
   }

   if (form.password.value.length == 0)
   {
      alert("Please enter a password");
      return false;
   }
   if (form.confPassword.value.length == 0)
   {
      alert("Please Confirm your password");
      return false;
   }
   if (form.confPassword.value != form.password.value)
   {
      alert("Passwords do not match. Please re-enter your password");
      form.confPassword.value = "";
      form.password.value = "";
      return false;
   }
   if (form.firstName.value.length == 0)
   {
      alert("Please enter a First name");
      return false;
   }
   if (form.lastName.value.length == 0)
   {
      alert("Please enter a last name");
      return false;
   }


   if (form.phoneNumber.value.length == 0)
   {
      alert("Please enter a Phone Number");
      return false;
   }
   
   return true;
}
</script>

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
            
            <form name="registerform" onsubmit="return validateRegister(this)" method="POST" action="registerNewCustomer_WSClient.jsp">
            
            <script language="javascript">
                        
                document.write("<input type='hidden' name='clientClockError' value='" + localClockError + "'>");
                                    
            </script>
            
            <table cellspacing="5" class="bold">
            <tr>
                <td colspan="2" height = "50" class="bold">Register a New Customer</td>
            </tr>            
            <tr>
                <td class="formlabel">Title</td>
                <td><input name="title" size="5" maxlength="10" tabindex="1"></td>                
            </tr>
            <tr>
                <td class="formlabel">First Name</td>
                <td><input name="firstName" size="20" maxlength="50" tabindex="2">&nbsp;<font class="formlabel" color="red">*</font></td>                
                <td width="20"></td>
                <td class="formlabel">Last Name</td>
                <td><input name="lastName" size="20" maxlength="50" tabindex="3">&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr>
                <td class="formlabel">Username</td>
                <td><input name="username" size="20" maxlength="50" onblur="populate_email(registerform)" tabindex="4">&nbsp;<font class="formlabel" color="red">*</font></td>                
                <td width="20"></td>
                <td class="formlabel">Password</td>
                <td><input type=password name="password" size="20" maxlength="50" tabindex="5">&nbsp;<font class="formlabel" color="red">*</font></td>
            </tr>
            <tr>
                <td class="formlabel">Email Address</td>
                <td><input name="emailAddress" readonly=true size="20" maxlength="50" tabindex="6">&nbsp;<font class="formlabel" color="red">*</font></td>  
                <td width="20"></td>
                <td class="formlabel">Confirm Password</td>
                <td><input type=password name="confPassword" size="20" maxlength="50" tabindex="5">&nbsp;<font class="formlabel" color="red">*</font></td>
            </tr>
            <tr><td></td></tr>
            <tr>
                <td colspan="2"><hr>Postal Address</td>
                <td width="20"></td>
                <td colspan="2"><hr>Phone Number</td>                
            </tr>
            <tr><td></td></tr>
            <tr>
                <td class="formlabel">Line 1</td>
                <td><input name="line1" size="20" maxlength="50" tabindex="7"></td>
                <td width="20"></td>
                <td class="formlabel">International Code</td>
                <td><input name="intCode" size="5" maxlength="10" tabindex="14"></td>                
            </tr>
            <tr>
                <td class="formlabel">Line 2</td>
                <td><input name="line2" size="20" maxlength="50" tabindex="8"></td>
                <td width="20"></td>
                <td class="formlabel">Area Code</td>
                <td><input name="areaCode" size="5" maxlength="10" tabindex="15"></td>                
            </tr>
            <tr>
                <td class="formlabel">Line 3</td>
                <td><input name="line3" size="20" maxlength="50"  tabindex="9"></td>
                <td width="20"></td>
                <td class="formlabel">Number</td>
                <td><input name="phoneNumber" size="15" maxlength="30" tabindex="16" >&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr>
                <td class="formlabel">Line 4</td>
                <td><input name="line4" size="20" maxlength="50" tabindex="10"></td>
                <td width="20"></td>
                <td class="formlabel">Type</td>
                <td><select name="phoneType" tabindex="17">
                <option value="Home">Home
                <option value="Business">Business
                <option value="Fax">Fax
                <option value="Mobile">Mobile
                <option value="Other">Other
               </select></td>
            </tr>
            <tr>
                <td class="formlabel">Line 5</td>
                <td><input name="line5" size="20" maxlength="50" tabindex="11"></td>
            </tr>
            <tr>
                <td class="formlabel">Zip Code</td>
                <td><input name="zipCode" size="20" maxlength="50" tabindex="12"></td>
            </tr>
            <tr>
                <td class="formlabel">Country</td>
                <td><input name="country" size="20" maxlength="50" tabindex="13"></td>
            </tr>
            <tr><td></td></tr>
            <tr>
                <td colspan="2"><hr></td>
                <td width="20"></td>
                <td colspan="2"></td>                
            </tr>       
            <tr>
                <td class="label">Login Customer</td>
                <td><input type="checkbox" name="loginCustomer" checked="true" tabindex="18"></td>               
            </tr>            
            <tr>
                <td><br><br></td>
                <td><input type=submit value="     Register     " tabindex="19">
            </tr>            
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>

