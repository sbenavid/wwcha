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

// customer Web Service URL
java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 
CICustomerWs customerWsLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerWsLocator.getCICustomerWsSoap( ciCustomerWsUrl );

// skillset web service URL
java.net.URL ciSkillsetWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CISkillsetWs.asmx"); 
CISkillsetWs skillsetWsLocator = new CISkillsetWsLocator();
CISkillsetWsSoap skillsetWs = skillsetWsLocator.getCISkillsetWsSoap( ciSkillsetWsUrl );


//ensure the customer has a default phone number before submitting the callback request
if( customerWs.getDefaultPhoneNumber( custID, sessionKey ).getNumber().length() != 0 )
{

    CIContactWriteType writeContact = new CIContactWriteType();

    String skillsetID = request.getParameter("Skillset");
    String priority = request.getParameter("Priority");

    writeContact.setSkillsetID(Long.parseLong(skillsetID));
    writeContact.setPriority(CIContactPriority.Priority_3_Medium_High);
    writeContact.setText(request.getParameter("Objective"));
    writeContact.setSubject(request.getParameter("Subject"));
    
    String skillsetName = skillsetWs.getSkillsetByID(Long.parseLong(skillsetID), sessionKey).getName();

    if( skillsetWs.isSkillsetInService(Long.parseLong(skillsetID), sessionKey))
    {
        contactID = customerWs.requestImmediateCallback(custID, writeContact, sessionKey);

        resultTitle = "Request Immediate Callback";
        resultDescription = "Successfully Created Contact : <a href='readContact_WSClient.jsp?contactID=" + contactID + "'/>" + contactID + "</a> for Customer ID : " + custID;
    }
    else
    {
        contactID = customerWs.requestImmediateCallback(custID, writeContact, sessionKey);
        
        resultTitle = "<font color='red'>Request Immediate Callback</font>";
        resultDescription = "Successfully Created Contact : <a href='readContact_WSClient.jsp?contactID=" + contactID + "'/>" + contactID + "</a> for Customer ID : " + custID + 
                            "<br><br> However the requested skillset : <font color='green'>" + skillsetName + "</font> is not in Service" +
                            "<br><br> Your request may not be handled immediately";
        
    }

}
else
{
    resultTitle = "Request Immediate Callback";
    resultDescription = "Cannot Submit Callback Request for Customer ID : " + custID + "<br><br>There is no Phone Number Configured for this Customer" +
                        "<br><br>Please <a href='readCustomerDetails_WSClient.jsp'>Update Customer Details</a> with a Phone Number";
}

%>

<%@include file="displayResultDescription.jsp"%>






