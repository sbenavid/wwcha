<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

long customerID = -2;

CICustomerWriteType custDetails          = new CICustomerWriteType();
CIEmailAddressWriteType custEmailAddress = new CIEmailAddressWriteType();
CIPhoneNumberWriteType custPhoneNumber   = new CIPhoneNumberWriteType();
CIAddressWriteType custAddress           = new CIAddressWriteType();


// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");

custDetails.setTitle    (  request.getParameter("title")        );
custDetails.setFirstName(  request.getParameter("firstName")    );
custDetails.setLastName (  request.getParameter("lastName")     );
custDetails.setUsername (  request.getParameter("username")     );
custDetails.setPassword (  request.getParameter("password")     );

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

CICustomerWs customerLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerLocator.getCICustomerWsSoap( ciCustomerWsUrl );

customerID = customerWs.registerNewCustomer(custDetails, custPhoneNumber,
                               custAddress, custEmailAddress);

if( request.getParameter("loginCustomer") != null )
{
%>
    <jsp:forward page="loginCustomer_WSClient.jsp">
        <jsp:param name="username" value="<%=request.getParameter(\"username\")%>"/>
        <jsp:param name="password" value="<%=request.getParameter(\"password\")%>"/>
        <jsp:param name="clientClockError" value="<%=request.getParameter(\"clientClockError\")%>"/>
        <jsp:param name="forceLogoff" value="true"/>
    </jsp:forward>
<%
}

String resultTitle = "Register a New Customer";
String resultDescription = "Successfully Created Customer with ID : " + customerID;

%>

<%@include file="displayResultDescription.jsp"%>






