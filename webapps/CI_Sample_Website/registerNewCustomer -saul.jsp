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

  var pwd = document.getElementsByName("username");
  form.password.value = pwd;
  form.confPassword.value = pwd;
  form.emailAddress.value = pwd;

  var nombre = document.getElementsByName("firstName");
  form.lastName.value = nombre;

   
   if (form.username.value.length == 0)
   {
      alert("Escribir tu nombre");
      return false;
   }

   if ((form.username.value.indexOf("@") == -1 ) ||
       (form.username.value.indexOf(".") == -1 ))
   {
      alert("Se requiere una direccion de correo electronico valida.");
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
        <title>Seguros Atlas</title>
    </head>
    <body>

    <!-- Set up the Main Table for the Web Page -->
    <table width="800">
    <tr>
        <td width="10"></td>

        <td width="590" height="900" valign="top">  
            
            <form name="registerform" onsubmit="return validateRegister(this)" method="POST" action="registerNewCustomer_WSClient.jsp">
            
            <script language="javascript">
                        
                document.write("<input type='hidden' name='clientClockError' value='" + localClockError + "'>");
                                    
            </script>
            
            <table cellspacing="5" class="bold">
            <tr>
                <td class="formlabel">Nombre</td>
                <td><input name="firstName" size="20" maxlength="50" tabindex="1"></td>                                
            </tr>
            <tr>
                <td class="formlabel">Correo Electronico</td>
                <td><input name="username" size="20" maxlength="50"  tabindex="2"></td>                
      
                <td><input type=password hidden="" name="password" size="20" maxlength="50" tabindex="5"></td>
            </tr>
            <tr>
                <td><input name="emailAddress" hidden readonly=true size="20" maxlength="50" tabindex="6"></td>  

                <td><input type=password name="confPassword" hidden size="20" maxlength="50" tabindex="5"></td>
            </tr>
            <tr><td></td></tr>
            <tr>
                <td class="formlabel">Telefono</td>
                <td><input name="phoneNumber" size="15" maxlength="50" tabindex="3" ></td>                
            </tr>
            <tr>
                <td colspan="2"><hr></td>
                <td width="20"></td>
                <td colspan="2"></td>                
            </tr>       
            <tr>
                
                <td><input type="checkbox" name="loginCustomer" hidden="true" checked="true" tabindex="18"></td>               
            </tr>            
            <tr>
                <td><br><br></td>
                <td><input type=submit value="     Iniciar     " tabindex="19">
            </tr>            
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>

