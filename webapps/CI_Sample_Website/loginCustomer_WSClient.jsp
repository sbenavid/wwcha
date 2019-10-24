<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%-- CI Web Service Libraries --%>
<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%-- Libraries used to handle Soap Exceptions --%>
<%@page import="org.apache.axis.AxisFault"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.namespace.QName"%>

<%

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");

// Store the Customer's username and password
String username = (String)request.getParameter("username");
String password = (String)request.getParameter("password");

//read the clientClockError parameter if it is set
//this parameter represents an offset in the client clock from the server time
//this value will be stored as a session variable
if( request.getParameter("clientClockError") != null )
{
    //long clientClockError = Long.parseLong(request.getParameter("clientClockError"));
    Long clientClockError = new Long(request.getParameter("clientClockError"));
    session.setAttribute("clientClockError", clientClockError);
}


// this parameter indicates if the customer should be automatically logged off if they are already logged in
boolean forceLogoff = Boolean.parseBoolean(request.getParameter("forceLogoff"));

String sessionKey = "";

// Set up the Utility Web Service URL

java.net.URL ciUtilityWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx"); 

CIUtilityWs utilityLocator = new CIUtilityWsLocator();
CIUtilityWsSoap utilityWs = utilityLocator.getCIUtilityWsSoap( ciUtilityWsUrl);


// Call the CustomerLogin Web Method
try
{
    sessionKey = utilityWs.customerLogin(username, password);
}
catch(AxisFault soapEx) // catch an Axis Fault to check if the Customer is already logged in
{
     // store the Detail of the Soap Exception
     Element soapExDetail = soapEx.lookupFaultDetail(
             new QName("http://webservices.ci.ccmm.applications.nortel.com" ,"Error"));
     
     if ( soapExDetail != null )
     {
         // save the errorNumber
         String strErrorNumber = soapExDetail.getElementsByTagName("ErrorNumber").item(0).getFirstChild().getNodeValue();
         
         // check if the error number signifies that the customer is already logged in - ErrorNumber 2801
         if( strErrorNumber.equals("2801"))
         {
            // check if we should automatically log the customer off, if so log off the customer and log them in again 
            if( forceLogoff )
            {
            utilityWs.customerLogoff(username);
            sessionKey = utilityWs.customerLogin(username, password);
            }
            else
            {
                %>
                <jsp:forward page="customerAlreadyLoggedIn.jsp">
                    <jsp:param name="username" value="<%=username%>"/>
                    <jsp:param name="password" value="<%=password%>"/>
                </jsp:forward>
                <%
            }
         }
         else
         {
            throw soapEx;   // throw the exception to be handled by the SoapErrorPage
         }         
     }
     else
     {
         throw soapEx;  // throw the exception to be handled by the SoapErrorPage
     }
     
}

// Store the session key, username and password as session variables

session.setAttribute("sessionKey", sessionKey);
session.setAttribute("username", username);

%>
<script language='javascript'>

    top.hiddenFrame.document.logoff_form.username.value   = "<%=username%>"
    top.hiddenFrame.document.logoff_form.sessionKey.value = "<%=sessionKey%>"

</script>
<%

//get the customer's ID & EmailAddress and store them as session variables

java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 

CICustomerWs customerLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerLocator.getCICustomerWsSoap( ciCustomerWsUrl );

CICustomerReadType thisCustomer = customerWs.getCustomerByUsername(username, sessionKey);

session.setAttribute("custID", String.valueOf(thisCustomer.getId()));
        
CIEmailAddressReadType emailAddress = customerWs.getDefaultEmailAddress( thisCustomer.getId(), sessionKey);
session.setAttribute("custEmailAddress", emailAddress.getEmailAddress() );

String resultTitle = "Login Customer";
String resultDescription = "Successfully Logged in Customer : " + username;


%>

<%@include file="displayResultDescription.jsp"%>










