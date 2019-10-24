<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>

<%-- Libraries used to handle Soap Exceptions --%>
<%@page import="org.apache.axis.AxisFault"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="javax.xml.namespace.QName"%>

<%
    // declare variables
    AxisFault soapEx = new AxisFault();
    boolean bCISoapException = false; 
    boolean bCISoapExceptionNoDetail = false;
    String errorMessage = "";
    String errorSource = "";
    String actor = "";
    String faultCode = "";
    String strErrorNumber = "";
    String strUnknownHost = "java.net.UnknownHostException";
    //get the exception from the request object attribute
    Throwable e = (Throwable)request.getAttribute("javax.servlet.error.exception");
        
    //get the exception type from the request object attribute
    Class exception_type = (Class)request.getAttribute("javax.servlet.error.exception_type");
        
    //check if the exception is a Soap Exception ( of type org.apache.axis.AxisFault )
    if( soapEx.getClass().isAssignableFrom( exception_type ) )
    {
        // Store the Axis Fault as the variable soapEx
        soapEx = (AxisFault)e; 
        
        // save the Actor property of the Soap Exception
        actor = soapEx.getFaultActor();

        // save the FaultCode property of the Soap Exception
        faultCode = soapEx.getFaultCode().getLocalPart();
         
        // store the Detail of the Soap Exception
        Element soapExDetail = soapEx.lookupFaultDetail(
                 new QName("http://webservices.ci.ccmm.applications.nortel.com" ,"Error"));
         
        // check if there is detail in the soap exception
        if ( soapExDetail != null )
        {
            //set this flag to true to indicate that this is a Soap Exception with details 
            bCISoapException = true; 
            
            // save the errorNumber, errorMessage and errorSource
            strErrorNumber = soapExDetail.getElementsByTagName("ErrorNumber").item(0).getFirstChild().getNodeValue();
            errorMessage = soapExDetail.getElementsByTagName("ErrorMessage").item(0).getFirstChild().getNodeValue();
            errorSource = soapExDetail.getElementsByTagName("ErrorSource").item(0).getFirstChild().getNodeValue();
             
            //check if this is an Invalid Session Key Error signified by Error Number 2805
            //if so remove the session variables, this will force the customer to login again
            if(strErrorNumber.equals("2805"))
            {
                // remove the users session variables
                session.removeAttribute("sessionKey");
                session.removeAttribute("username");
                session.removeAttribute("custID");
                session.removeAttribute("custEmailAddress");
                session.removeAttribute("clientClockError");
            }
        }
        else
        {
           // no detail in the exception, just set the errorMessage         
           errorMessage = soapEx.getFaultString();
		if(errorMessage.indexOf(strUnknownHost)!=-1)
		{
			errorMessage=errorMessage+". Ensure that the CCMM server name is correct and that the server is running.";
		}
           
           // set this flag to true to indicate that this is a Soap Exception with no detail 
           bCISoapExceptionNoDetail = true;
        }
    }
    else
    {
        // this is the case where it is not a soap exception, just set the errorMessage
        errorMessage = e.getMessage();
    }
      

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CCMM CI Sample Web Site</title>
    </head>
    <body>

    <!-- Set up the Main Table for the Web Page -->
    <table width="100%" border="0">
    <tr>
        
        <td height="80" colspan="3">
        <%@include file="header.html"%>
        </td>
    </tr>
    </table>
    <table width="800">
    <tr>
        <td width="200" height="900">            
        <%@include file="menu.jsp" %>
        </td>

        <td width="10"></td>

        <td width="590" height="900" valign="top">  
           
            <table cellspacing="5" class="bold">
            <tr>
                <td colspan="3" height = "50" class="bold">An Error Occurred</td>
            </tr>  
            <tr valign="top">
                <td>Error Message</td>
                <td>&nbsp; : &nbsp;</td>
                <td><%=errorMessage%></td>
            </tr> 
            
            <% if (bCISoapExceptionNoDetail) {  %>
            <tr valign="top">
                <td>Fault Code</td>
                <td>&nbsp; : &nbsp;</td>
                <td><%=faultCode%></td>
            </tr>
                                  
            <% } if (bCISoapException) { %>
            <tr valign="top">
                <td>Error Number</td>
                <td>&nbsp; : &nbsp;</td>
                <td><%=strErrorNumber%></td>
            </tr>
            <tr valign="top">
                <td>Actor</td>
                <td>&nbsp; : &nbsp;</td>
                <td ><%=actor%></td>                
            </tr>              
            <tr valign="top">
                <td>Error Source</td>
                <td>&nbsp; : &nbsp;</td>
                <td><%=errorSource%></td>
            </tr>  
            <% } %>
            </table>
        </td>
     </tr>       
  </table>            
</body>
</html>
