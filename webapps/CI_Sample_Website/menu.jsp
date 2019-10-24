<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->
    
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%

    // ensure we are decoding the request parameters as UTF-8
    request.setCharacterEncoding("UTF-8");
    
    String ccmmname = application.getInitParameter("CCMM_HOSTNAME");
    String chatSkillsetName = application.getInitParameter("WEBCOMMS_SKILLSET");
   
    String inService = "0"; // Default skillset to being out of service.
    
    // Skillset web service URL
    java.net.URL SkillsetUrl = new java.net.URL("http://" + ccmmname + "/ccmmwebservices/CISkillsetWs.asmx"); 
    CISkillsetWs skillsetLocatorObj = new CISkillsetWsLocator();
    CISkillsetWsSoap skillsetWsObj = skillsetLocatorObj.getCISkillsetWsSoap( SkillsetUrl );
        
    // check if the Text Chat Skillset is in Service
    if( skillsetWsObj.isSkillsetNameInService(chatSkillsetName))
    {
        // Display the webchat icon on the main menu:
        inService = "1";
    }
    else //Skillset is not in service, display a message to the user
    {
        // Offer alternative options to cusomter - Web Chat is unavailable...
        // Example, Offer the customer the opertunity to send an email.
    }

%>    

<head>
<script LANGUAGE="JavaScript">    
    // Launch a web-chat prompt
    
    var anonymousChatLaunched = "0";
    
    function launchWebchatQuestion()
    {
        if ("0" == anonymousChatLaunched)
        {
            // Check if the csutomer has alreday requested a web chat session since the timer began...
            window.open('OfferWebChat.jsp', 'WebChat', 'width=430, height=232, resizable=0, status=0, toolbar=0, menubar=0');
        }
    }

    // Launch an anonymous web chat session
    function launchWebChatSession()
    {
        window.open('WebChatLogin.jsp', 'WebChat', 'width=430, height=400, resizable=0');
        anonymousChatLaunched = "1";
    }
    
</script>
</head>

<table width="100%" height="100%" cellspacing="10" cellpadding="10" bgcolor="#C0C0C0">
<tr>
<td valign="top">

<% if( session.getAttribute("sessionKey") == null ) { %>

<table cellspacing="1">
    <tr>
    <td class="infotext">Status</td>
    <td class="infotext"> : </td>
    <td class="infotext"><font color="#EA0437">Logged Off</font></td>
    </tr>
    <tr>
    <td class="infotext">&nbsp;</td><td></td><td></td>
    </tr>
</table>

<table cellspacing="1">
    <font color="#003399">
    <tr>
    <td>
        <br>
        <img src="images/home.gif" alt="Home" onclick="location='home.jsp'">
        <br>
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/loginCustomer.gif" alt="Login Customer" onclick="location='loginCustomer.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/registerNewCustomer.gif" alt="Register New Customer" onclick="location='registerNewCustomer.jsp'">
        <br>
    </td>
    </tr>
    <% if(inService.equals("1")) { %>
    <tr>
    <td>
        <a href="javascript:void(0)" onclick="launchWebChatSession();"><img title="Web Chat" alt="Chat icon." border="0" height="50" width="50" src="img/webchat.gif" /></a>
        <br>
    </td>
    </tr>    
    
    <script LANGUAGE="JavaScript">
        
        // *** Offer Web Chat session ***
        // Check if the skillset is in service, offer the customer a web chat session.
        // In this sample, the offer window is triggered by a timer mechanism e.g. after 5 seconds.
        // Customer must be logged out:
        
        if(location.href.indexOf("home.jsp") > -1 || location.href.indexOf("registerNewCustomer.jsp") > -1 || location.href.indexOf("passwordReminder.jsp") > -1 )
        {
            // Do not offer anonymous chat if the Customer is registering a new customer,
            // requesting password reminder OR navigating to the main home location...
        }
        else
        {
            // Offer chat session after 5 seconds... Interval can be re-set here (milseconds)
            setTimeout('launchWebchatQuestion()', 5000);
        }
        
    </script>
    
    <% } %> <!-- Offer Alternative options to customer -->
    <tr><td></td></tr>
    </font>
</table>

<br><br>

<% } else { %> 

<table cellspacing="1">
    <tr>
    <td class="infotext">Status</td>
    <td class="infotext"> : </td>
    <td class="infotext"><font color="#12AD2B">Logged In</font></td>
    </tr>
    <tr>
    <td class="infotext">User</td>
    <td class="infotext">: </td>
    <td><input type="text"  size="15" readonly="true" class="username" value="<%= session.getAttribute("username")%>"></td>        
    </tr>
</table>

<table cellspacing="1">
<font color="#003399">
    <tr>
    <td>
        <br>
        <img src="images/home.gif" alt="Home" onclick="location='home.jsp'">
        <br>
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/logoffCustomer.gif" alt="Logoff Customer" onclick="location='logoffCustomer.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/readCustomerDetails.gif" alt="Display Customer Details" onclick="location='readCustomerDetails_WSClient.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/updateCustLogin.gif" alt="Update Customer Login Credentials" onclick="location='updateCustomerLogin.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/readCustomerContactHistory.gif" alt="Read Customer Contact History" onclick="location='readCustContactHist_WSClient.jsp?pageControl=last'">
        <br>
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/requestTextChat.gif" alt="Request Text Chat" onclick="location='requestTextChat.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/requestScheduledCallback.gif" alt="Request Scheduled Callback" onclick="location='requestScheduledCallback.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/requestImmediateCallback.gif" alt="Request Immediate Callback" onclick="location='requestImmediateCallback.jsp'">
    </td>
    </tr>
    <tr>
    <td>
        <img src="images/submitHTMLForm.gif" alt="Submit HTML Form" onclick="location='submitHTMLForm.jsp'">
    </td>
    </tr>
    <tr><td></td></tr>    
</font>
</table>


<% } %>


</font>

</td>
</tr>

</table>