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

String resultTitle;
String resultDescription;

// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");

String sessionKey = (String)session.getAttribute("sessionKey");
long custID = Long.parseLong((String)session.getAttribute("custID"));
long contactID = -2;

java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 

CICustomerWs customerWsLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerWsLocator.getCICustomerWsSoap( ciCustomerWsUrl );

//ensure the customer has a default phone number before submitting the callback request
if( customerWs.getDefaultPhoneNumber( custID, sessionKey ).getNumber().length() != 0 )
{
    CIContactWriteType writeContact = new CIContactWriteType();

    String skillsetID = request.getParameter("Skillset");
    
    //read the callback time from the hidden field on the request scheduled callback form
    long cbTimeInMillis = Long.parseLong(request.getParameter("callback_time_milliseconds"));

    //create a new CIDateTime object and assign the callback time to it
    CIDateTime cbTime = new CIDateTime();
    cbTime.setMilliseconds(cbTimeInMillis);
    
    //then set the callback time on the contact
    writeContact.setCallbackTime(cbTime);

    //set the other fields on the writeContact object
    writeContact.setSkillsetID(Long.parseLong(skillsetID));
    writeContact.setText(request.getParameter("Objective"));
    writeContact.setPriority(CIContactPriority.Priority_3_Medium_High);
    writeContact.setText(request.getParameter("Objective"));
    writeContact.setSubject(request.getParameter("Subject"));


    contactID = customerWs.requestScheduledCallback(custID, writeContact, sessionKey);

    resultTitle = "Request Scheduled Callback";
    resultDescription = "Successfully Created Contact ID : <a href='readContact_WSClient.jsp?contactID=" + contactID + "'/>" + contactID + "</a> for Customer ID : " + custID;
}
else
{
    resultTitle = "Request Scheduled Callback";
    resultDescription = "Cannot Submit Callback Request for Customer ID : " + custID + "<br><br>There is no Phone Number Configured for this Customer" +
                        "<br><br>Please <a href='readCustomerDetails_WSClient.jsp'>Update Customer Details</a> with a Phone Number";
}


%>

<%@include file="displayResultDescription.jsp"%>







