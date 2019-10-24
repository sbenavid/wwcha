<%-- 
    Document   : WebChatLogin
    Created on : 14-Apr-2014, 14:06:20
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<title>Sample Web Chat</title>
		<link rel="stylesheet" type="text/css" href="css/style.css" />
		<link rel="stylesheet" type="text/css" href="css/calendar.css" />
		<link rel="stylesheet" type="text/css" href="css/time.css" />
	</head>
	
	<body onload="Javascript:onLoginLoadDo()" style="margin:0px;" bgcolor="#F3F2EF">
		<div>escribenos</div>
            
            <form name="requestWebChatform"  onsubmit="return processChatRequest()" method="POST" action="RequestWebChat_Redirect.jsp">

		<table id="webchatLogin" class="popover_window" width="430" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="100%">
					<table id="" border="0" cellspacing="0" cellpadding="0">  

						<!--	Header & Logo	-->	

	

						<!--	End Header & Logo	-->	

						<tr>
							<td colspan="2" valign="top">

								<!-- Input Fields -->
								<table id="" cellSpacing="0" cellPadding="0" border="0" width="100%">  
									<tr>
										<td>
										<table id="webchat_user_input" class="input_fields" width="100%" valign="top"  style="display:block;" border="0" cellSpacing="3" cellPadding="0">
											<tr align="left">
												<td width="110">Nombre</td>
												<td></td>
												<td><input type="field" maxlength="50" id="username" name="username" size="30" /></td>
											</tr>
											<tr align="left">
												<td></td>
												<td></td>
												<td id="name_error"></td>
											</tr>
											<tr align="left">
												<td width="110">Telefono:</td>
												<td></td>
												<td><input type="field" maxlength="50" id="phone" name="phone" size="30" onKeyPress="return checkSpace(event)" /></td>
											</tr>
											<tr align="left">
												<td></td>
												<td></td>
												<td id="phone_error"></td>
											</tr>
											<tr align="left">
												<td width="110">Correo Electronico:</td>
												<td></td>
												<td><input type="field" maxlength="50" id="email" name="email" size="30" onKeyPress="return checkSpace(event)" /></td>
											</tr>
											<tr align="left">
												<td></td>
												<td></td>
												<td id="email_error"></td>
											</tr>
											<tr align="left">
												
												<td><input hidden type="field" maxlength="50" id="subject" name="subject" size="30" /></td>
											</tr>
											<tr align="left">
												<td></td>
												<td></td>
												<td id="subject_error"></td>
											</tr>
											<tr align="left">
												
												<td><input hidden type="field" maxlength="50" id="reference" name="reference" size="30"></td>
											</tr>
											<tr align="left">
												<td></td>
												<td></td>
												<td id="reference_error"></td>
											</tr>
											<tr align="left" >
												
												<td>
													<select hidden style="width:205px;" id="skillset" name="skillset">
        													<option value="WC_Default_Skillset">Default</option>
													</select> 
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>

								<!-- End Input Fields -->

								<!-- Please Wait / Error Message Table -->

								<table id="webchat_please_wait" valign="top" class="input_fields" style="display:none;" width="100%" border="0">
									<tr>
										<td id="PleaseWait" height="152" width="438" valign="middle" align="center">Favor de esperar...</td>
									</tr>
								</table> 

								<!-- End Please Wait / Error Message Table -->

							</td>
						</tr>
						<tr>
							<td align="center" style="padding:20px;" colspan ="2"> 
								<input type="submit" class="wc_submit" value="Iniciar Chat"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>

				<!-- Footer -->

				<td colspan="2" class="bottom_gradient" height="50" width="100%">
					<div>
					<span id="status" class="webchat_connection_status"><b><font class="status_color">Status: </font>Activo</b></span>
					<span class="powered_by">Seguros Atlas</span>
					</div>
				</td>

				<!-- End Footer -->

			</tr>
		</table>


<jsp:include page="include/main_pre_body.jsp"/>

<script type="text/javascript"> 
var elementID;

function onLoginLoadDo()
{
	//	On window load resize
	resizeWindow(438, 438, 438, 415, 433, 397, 0);

	//	Set focus to name field
	document.getElementById('username').focus();
}

function replaceWithHTMLEntities(str)
{
	//	Replace certain 'vulnerable' characters with their html entities
	str = str.replace("<", "&#60;");
	str = str.replace(">", "&#62;");
	str = str.replace("$", "&#36;");
	str = str.replace("[", "&#91;");
	str = str.replace("[", "&#93;");
	return str; 
}

function processChatRequest()
{

    	var error = false;
	elementID = 0;

	//	Get input
	var username = replaceWithHTMLEntities(document.getElementById('username').value);
	var email = replaceWithHTMLEntities(document.getElementById('email').value);
	var phone = replaceWithHTMLEntities(document.getElementById('phone').value);

	//	Retrieve platform and browser information to pass to agent
	var WebCommsQuery = "PLATFORM: [" + navigator.platform + "]; BROWSER: [" + navigator.appName + "]; HEADER: [" + navigator.userAgent + "]";

	//	Assign username to first name for creating user in database
	FirstName = username;

	document.getElementById('email_error').innerHTML = "";
	document.getElementById('phone_error').innerHTML = "";
  
	//	Validate given email address
	if(email != "")
	{
		//	If string contains whitespace, trim
		email = whitespaceTrim(email);
		//	 Validate email address
		if(!isValidEmailAddress(email))
		{
			document.getElementById('email_error').innerHTML = "<font color='red'>Invalid Email Address</font>";
			error = true;
			elementID = document.getElementById('email');
		}
	}

	//	Validate given phone number
	if(phone != "")
	{
		//	If string contains whitespace, trim
		phone = whitespaceTrim(phone);
		//	 Validate phone number
		if(!isValidPhoneNumber(phone))
		{
			document.getElementById('phone_error').innerHTML = "<font color='red'>Invalid Phone Number</font>";
			error = true;
			if (elementID == 0)
				elementID = document.getElementById('phone');
		}
	}

	// Check for error
	if(error)
	{
		//	Set element focus
		elementID.focus();
		return false;
	}

	//	Hide user input panel
	document.getElementById('webchat_user_input').style.display = "none";

	//	Show loading panel while we do all the web service calls and it can take a few seconds to complete
	document.getElementById('webchat_please_wait').style.display = "block";

	//	Maintain window size (according to browser used) while wait message is displayed and the chat request is processed
	resizeWindow(438, 438, 438, 415, 408, 381, 0);
        
	return true;
}

</script>
            </form>
	</body>
</html>