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

// get the old password from the request object
String oldPassword = request.getParameter("oldPassword");

// get the username and password from the request object
String newUsername = request.getParameter("newUsername");
String newPassword = request.getParameter("newPassword");

String sessionKey = (String)session.getAttribute("sessionKey").toString();
long custID = Long.parseLong((String)session.getAttribute("custID"));

String CICustomerWsUrl = "http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"; 
java.net.URL ciEmailAddressWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIEmailAddressWs.asmx");
CICustomerReadType result = new CICustomerReadType();
CICustomerWs customerLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerLocator.getCICustomerWsSoap( new java.net.URL(CICustomerWsUrl));

CIEmailAddressWs emailAddressLocator = new CIEmailAddressWsLocator();
CIEmailAddressWsSoap emailAddressWs = emailAddressLocator.getCIEmailAddressWsSoap( ciEmailAddressWsUrl );

// default result description, changed in the IF statements below
String resultDescription = "Customer Login Credentials were Not Updated";

if( request.getParameter("updateType").equals("Username") )
{
    customerWs.updateUsername(custID, newUsername, sessionKey );
    session.setAttribute("username", newUsername);
    resultDescription = "Successfully Updated Customer Username for Customer ID : " + custID;

    result = customerWs.getCustomerByUsername(newUsername, sessionKey);

    CIEmailAddressReadType defaultEmailAddress = customerWs.getDefaultEmailAddress(result.getId(), sessionKey);
    long defaultEmailAddressID;
    defaultEmailAddressID = defaultEmailAddress.getId();

    //if updating username, update e-mail address also
    CIEmailAddressWriteType custEmailAddress = new CIEmailAddressWriteType();
    custEmailAddress.setEmailAddress(newUsername);
    emailAddressWs.updateEmailAddress( defaultEmailAddressID,custEmailAddress, sessionKey); 
    
}
else if( request.getParameter("updateType").equals("Password") )
{
    customerWs.updatePassword(custID, oldPassword, newPassword, sessionKey);
    session.setAttribute("password", newPassword);
    resultDescription = "Successfully Updated Customer Password for Customer ID : " + custID;
}

String resultTitle = "Update Customer Login Credentials";


%>


<%@include file="displayResultDescription.jsp"%>