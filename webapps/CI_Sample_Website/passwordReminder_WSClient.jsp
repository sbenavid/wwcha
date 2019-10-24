<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>


<%-- Libraries used to handle Soap Exceptions --%>
<%@page import="org.apache.axis.AxisFault"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.namespace.QName"%>

<%

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");
String passwordReminderSkillset = application.getInitParameter("PASSWORD_REMINDER_SKILLSET").toString();

String resultTitle;
String resultDescription;

// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");
String custEmailAddress = request.getParameter("emailAddress").toString();

String username = "";

long contactID = -2;

java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 
CICustomerWs customerWsLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerWsLocator.getCICustomerWsSoap( ciCustomerWsUrl );

try
{
    contactID = customerWs.sendPasswordReminder(custEmailAddress, passwordReminderSkillset);
    
    resultTitle = "Send Password Reminder";
    resultDescription = "Successfully sent a Password Reminder Email to  : " + custEmailAddress + "<br>The Contact ID for this Email is  : " + contactID;
}
catch(AxisFault soapEx) // catch an Axis Fault to check if the Email Address is that of a Registered Customer
{
     // store the Detail of the Soap Exception
     Element soapExDetail = soapEx.lookupFaultDetail(
             new QName("http://webservices.ci.ccmm.applications.nortel.com" ,"Error"));
     
     if ( soapExDetail != null )
     {
         // save the errorNumber
         String strErrorNumber = soapExDetail.getElementsByTagName("ErrorNumber").item(0).getFirstChild().getNodeValue();
         
         // check if the error number signifies that there is no registered Customer with this Email Address - Errornumber 2821
         if( strErrorNumber.equals("2821"))
         {
            resultTitle = "Send Password Reminder";
            resultDescription = "Unable to send Password Reminder<br>There is no Customer Registered with an Email Address of : " + custEmailAddress +
                        "<br><br>You may Register a New Customer <a href='registerNewCustomer.jsp'>here</a>";

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
 

%>

<%@include file="displayResultDescription.jsp"%>






