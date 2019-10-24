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

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");

long customerID = Long.parseLong(request.getParameter("custID"));
long addressID = Long.parseLong(request.getParameter("addressID"));
long emailAddressID = Long.parseLong(request.getParameter("emailAddressID"));
long phoneNumberID = Long.parseLong(request.getParameter("phoneNumberID"));

String sessionKey = (String)session.getAttribute("sessionKey");

CICustomerWriteType custDetails          = new CICustomerWriteType();
CIEmailAddressWriteType custEmailAddress = new CIEmailAddressWriteType();
CIPhoneNumberWriteType custPhoneNumber   = new CIPhoneNumberWriteType();
CIAddressWriteType custAddress           = new CIAddressWriteType();

custDetails.setTitle    (  request.getParameter("title")        );
custDetails.setFirstName(  request.getParameter("firstName")    );
custDetails.setLastName (  request.getParameter("lastName")     );
custDetails.setUsername (  request.getParameter("username")     );

//also need to update the session variable holding the username
session.setAttribute("username", custDetails.getUsername());

custEmailAddress.setEmailAddress( request.getParameter("emailAddress") );

custPhoneNumber.setInternationalCode( request.getParameter("intCode")     );
custPhoneNumber.setAreaCode         ( request.getParameter("areaCode")    );
custPhoneNumber.setNumber           ( request.getParameter("phoneNumber") );

String PhoneNumberType = request.getParameter("phoneType");
CIPhoneNumberType phoneType = CIPhoneNumberType.fromString(PhoneNumberType);
custPhoneNumber.setPhoneNumberType( phoneType );
        
custAddress.setLine1  ( request.getParameter("line1") );
custAddress.setLine2  ( request.getParameter("line2") );
custAddress.setLine3  ( request.getParameter("line3") );
custAddress.setLine4  ( request.getParameter("line4") );
custAddress.setLine5  ( request.getParameter("line5") );
custAddress.setZipcode( request.getParameter("zipCode") );
custAddress.setCountry( request.getParameter("country") );

java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 
java.net.URL ciAddressWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIAddressWs.asmx");
java.net.URL ciEmailAddressWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIEmailAddressWs.asmx");
java.net.URL ciPhoneNumberWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIPhoneNumberWs.asmx");

CICustomerWs customerLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerLocator.getCICustomerWsSoap( ciCustomerWsUrl );

CIAddressWs addressLocator = new CIAddressWsLocator();
CIAddressWsSoap addressWs = addressLocator.getCIAddressWsSoap( ciAddressWsUrl );

CIEmailAddressWs emailAddressLocator = new CIEmailAddressWsLocator();
CIEmailAddressWsSoap emailAddressWs = emailAddressLocator.getCIEmailAddressWsSoap( ciEmailAddressWsUrl );

CIPhoneNumberWs phoneNumberLocator = new CIPhoneNumberWsLocator();
CIPhoneNumberWsSoap phoneNumberWs = phoneNumberLocator.getCIPhoneNumberWsSoap( ciPhoneNumberWsUrl );

customerWs.updateCustomer(customerID, custDetails, sessionKey);

// check that the address ID is a valid address ID
if( addressID != -1 )
{
    addressWs.updateAddress( addressID, custAddress, sessionKey);
}
else
{
    customerWs.addAddress( customerID, custAddress, sessionKey );
}

// check that the email address ID is a valid ID
if( emailAddressID != -1 )
{
    emailAddressWs.updateEmailAddress( emailAddressID, custEmailAddress, sessionKey);
}
else
{
    customerWs.addEmailAddress( customerID, custEmailAddress, sessionKey );
}

// check that the phone number ID is a valid ID
if( phoneNumberID != -1 )
{
    phoneNumberWs.updatePhoneNumber( phoneNumberID, custPhoneNumber, sessionKey);
}
else
{
    customerWs.addPhoneNumber( customerID, custPhoneNumber, sessionKey );
}

String resultTitle = "Update Customer Details";
String resultDescription = "Successfully Updated Customer Details for Customer ID : " + customerID;

%>

<%@include file="displayResultDescription.jsp"%>






