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

String username   = request.getParameter("username").toString();
String sessionKey = request.getParameter("sessionKey").toString();

// strings to be used by the displayResultDescription.jsp page
String resultTitle = "";
String resultDescription = ""; 

// set up URL of CIUtility Web Service
java.net.URL ciUtilityWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx"); 

CIUtilityWs utilityLocator = new CIUtilityWsLocator();
CIUtilityWsSoap utilityWs = utilityLocator.getCIUtilityWsSoap( ciUtilityWsUrl);


try
{
     // use a call to the isContactCenterClosed() web method to check if the current session key is valid
     // if it is not valid a soap exception will be thrown
     utilityWs.isContactCentreClosed(sessionKey);
     
     // if no exception was thrown then continue and call the customer logoff web method
     utilityWs.customerLogoff(username);
     
     resultTitle = "Logoff Customer";
     resultDescription = "Customer : " + username + " logged off successfully";
}
catch(AxisFault soapEx) // catch the Soap Exception as an AxisFault and check if it is an invalid Session Key error
{
     // store the Detail of the Soap Exception
     Element soapExDetail = soapEx.lookupFaultDetail(
             new QName("http://webservices.ci.ccmm.applications.nortel.com" ,"Error"));
     
     if ( soapExDetail != null )
     {
         // save the errorNumber
         String strErrorNumber = soapExDetail.getElementsByTagName("ErrorNumber").item(0).getFirstChild().getNodeValue();
         
         // check if the error number signifies that the session key is invalid - ErrorNumber 2805
         // if so change the result description to indicate this
         if( strErrorNumber.equals("2805"))
         {
             resultTitle = "Logoff Customer";
             resultDescription = "This Session was already Logged Off";
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

// remove the users session variables
session.removeAttribute("sessionKey");
session.removeAttribute("username");
session.removeAttribute("custID");
session.removeAttribute("custEmailAddress");
session.removeAttribute("clientClockError");

%>

<script language='javascript'>

    top.hiddenFrame.document.logoff_form.username.value = "";
    top.hiddenFrame.document.logoff_form.sessionKey.value = "";

</script>


<%@include file="displayResultDescription.jsp"%>
    

