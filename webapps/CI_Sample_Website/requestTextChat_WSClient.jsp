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

String sessionKey = (String)session.getAttribute("sessionKey");
long custID = Long.parseLong((String)session.getAttribute("custID"));
long contactID = -2;

String resultTitle = "";
String resultDescription = "";

// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");

// customer web service URL
java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 
CICustomerWs customerWsLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerWsLocator.getCICustomerWsSoap( ciCustomerWsUrl );

// skillset web service URL
java.net.URL ciSkillsetWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CISkillsetWs.asmx"); 
CISkillsetWs skillsetWsLocator = new CISkillsetWsLocator();
CISkillsetWsSoap skillsetWs = skillsetWsLocator.getCISkillsetWsSoap( ciSkillsetWsUrl );

CIContactWriteType writeContact = new CIContactWriteType();

String skillsetID = request.getParameter("Skillset");
String priority = request.getParameter("Priority");

writeContact.setSkillsetID(Long.parseLong(skillsetID));
writeContact.setText(request.getParameter("Objective"));
writeContact.setPriority(CIContactPriority.Priority_3_Medium_High);
writeContact.setSubject(request.getParameter("Subject"));

/* 
//Start of Comment block

// The follow commented out section shows how you can add 2 custom fields 
// to the Text Chat Contact called Expected Wait Time and Position in Queue
// These custom fields can be updated from the scripts using the Database 
// Integration Wizard with the correct values for Expected Wait Time and 
// Position in Queue

CICustomFieldWriteType[] customFieldArray = new CICustomFieldWriteType[2]; 

customFieldArray[0] = new CICustomFieldWriteType(); 
customFieldArray[0].setName("Expected Wait Time"); 
customFieldArray[0].setText("0"); 
customFieldArray[0].setIsTextVisible(true); 

customFieldArray[1] = new CICustomFieldWriteType(); 
customFieldArray[1].setName("Position In Queue"); 
customFieldArray[1].setText("0"); 
customFieldArray[1].setIsTextVisible(true); 

writeContact.setCustomFields( customFieldArray ); 

// End of Comment Block
*/

String skillsetName = skillsetWs.getSkillsetByID(Long.parseLong(skillsetID), sessionKey).getName();

// check if the Text Chat Skillset is in Service
if( skillsetWs.isSkillsetInService(Long.parseLong(skillsetID), sessionKey ))
{
    // create a new Text Chat Contact
    contactID = customerWs.requestTextChat(custID, writeContact, false, sessionKey);

    String webCommsHost = application.getInitParameter("WEBCOMMS_HOSTNAME");
    String webCommsPort = application.getInitParameter("WEBCOMMS_PORT");
    String webCommsPath = application.getInitParameter("WEBCOMMS_PATH");

    //Build the Web Comms URL from the above values
    String webCommsURL = "http://" + webCommsHost + ":" + webCommsPort + webCommsPath;

    //Append the SessionKey and ContactID as parameters to the Web Comms URL
    webCommsURL += "?sessionKey=" + sessionKey + "&contactID=" + contactID;

    //redirect to the WebComms URL
    response.sendRedirect(webCommsURL);

}
else //Skillset is not in service, display a message to the user
{
    // create a closed Text Chat contact for reporting purposes
    contactID = customerWs.requestTextChat(custID, writeContact, true, sessionKey);
    
    resultTitle = "<font color='red'>Live Text Chat Not Available</font>";
    resultDescription = "Live Text Chat cannot be requested at this time as the requested Skillset : <font color='green'>" + skillsetName + "</font> is not in Service" + 
                        "<br><br>A Closed Contact ( ID : <a href='readContact_WSClient.jsp?contactID=" + contactID + "'>" + contactID + "</a> ) has been created to record this web transaction" + 
                        "<br><br>Please try to Request a Text Chat again at a later time";

    
}

%>

<%@include file="displayResultDescription.jsp"%>

















