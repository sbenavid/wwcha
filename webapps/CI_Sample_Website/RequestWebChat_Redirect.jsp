<%-- 
    Document   : RequestWebChat_Redirect.jsp
    Created on : 17-Apr-2014, 15:14:12
    Author     : Administrator
--%>
<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2013 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%

    String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");
    String sessionKey;

    // ensure we are decoding the request parameters as UTF-8
    request.setCharacterEncoding("UTF-8");
   
    String webCommsHost = application.getInitParameter("WEBCOMMS_HOSTNAME");
    String webCommsPort = application.getInitParameter("WEBCOMMS_PORT");
    String webCommsPath = application.getInitParameter("WEBCOMMS_PATH_ANONYMOUS");
    String defaultSkillsetName = application.getInitParameter("WEBCOMMS_SKILLSET");
    
    String userName = request.getParameter("username");
    String phoneNumber = request.getParameter("phone");
    String email = request.getParameter("email");
    String chatSubject = request.getParameter("subject");
    String referenceNumber = request.getParameter("reference");
    
    // This sample code uses the default skillset for web chat as defined by the web.xml config file.
    // 
    //  String skillsetName = request.getParameter("skillset");
    String skillsetName = defaultSkillsetName;
    
    // If the customer has entered a reference number, append it to the subject line:
    if(!referenceNumber.equals(""))
    {
        chatSubject += " [" + referenceNumber + "]";
    }
    
    long myCustomerID = 0;
    long contactID = -2;
    
    try
    {
        // CIUtility Web Services:
        java.net.URL ciUtilityWSUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx");
        CIUtilityWs utilityWsLocator = new CIUtilityWsLocator();
        CIUtilityWsSoap utilityWs = utilityWsLocator.getCIUtilityWsSoap( ciUtilityWSUrl );

        // customer web service URL
        java.net.URL ciCustomerWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"); 
        CICustomerWs customerWsLocator = new CICustomerWsLocator();
        CICustomerWsSoap customerWs = customerWsLocator.getCICustomerWsSoap( ciCustomerWsUrl );	

        // skillset web service URL
        java.net.URL ciSkillsetWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CISkillsetWs.asmx"); 
        CISkillsetWs skillsetWsLocator = new CISkillsetWsLocator();
        CISkillsetWsSoap skillsetWs = skillsetWsLocator.getCISkillsetWsSoap( ciSkillsetWsUrl );

        // 1. Get an anonymous sesssion key:
        // ================================
        AnonymousLoginResult result = utilityWs.getAnonymousSessionKey();
        sessionKey = result.getSessionKey();

        // 2. Populate Customer Details:
        // ==============================
        CICustomerReadType ciCustomer = new CICustomerReadType();

        //ciCustomer.setUsername(name);
        ciCustomer.setFirstName(userName); // Set the FirstName as the user name.
        ciCustomer.setLastName(""); 
        // Note: Address list is not required.

        // 2. Build up a customer from the customer entered details:
        myCustomerID = utilityWs.getAndUpdateAnonymousCustomerID(result, email, phoneNumber, ciCustomer);

        // 3. Get the skillset ID:
        CISkillsetReadType myCISkillsetReadType = new CISkillsetReadType();
        myCISkillsetReadType = skillsetWs.getSkillsetByName(skillsetName, result.getSessionKey()); //WC_Default_Skillset

        long mySkillsetID = myCISkillsetReadType.getId(); 

        // 4. Create the contact:
        // --------------------------------------------
        CIContactWriteType writeContact = new CIContactWriteType();
        writeContact.setSkillsetID(mySkillsetID);
        writeContact.setPriority(CIContactPriority.Priority_3_Medium_High);      // Can be read from config file.
        // writeContact.setTimezone(-999);
        writeContact.setSubject(chatSubject);
        writeContact.setTextHTML("");                                             // Text can be blank

        // Ensure we have a phone number specified before adding as a paramater:
        if (phoneNumber != null)
        {
            if(phoneNumber.equals(""))
            {
                phoneNumber = "NONE";
            }
        }
        else
        {
            phoneNumber = "NONE";
        }

        // check if the Text Chat Skillset is in Service
        if( skillsetWs.isSkillsetInService(mySkillsetID, result.getSessionKey()))
        {
            // create a new Text Chat Contact
            contactID = customerWs.requestTextChat(myCustomerID, writeContact, false, result.getSessionKey());
            
            // Check for max limits:
            // This section cheks for connection maximum limits. Also re-confirms that teh skillset is in service
            if(contactID != -1)
            {
                    //	Check if a text chat session has failed due to max concurrent sessions
                    if(contactID == -2)
                    {
                            //	Establishing a text chat session has failed: display message and close
                            response.sendRedirect("ShowChatErrors.jsp?errCode=" + "webchat_max_concurrent_per_customer");
                    } 
                    else if(contactID == -3)
                    {
                            //	Establishing a text chat session has failed: display message and close
                            response.sendRedirect("ShowChatErrors.jsp?errCode=" + "webchat_max_concurrent_per_skillset");                        
                    } 
                    else
                    {
                        // Redirect to the Web Chat Application:
                        //Build the Web Comms URL from the above values
                        String webCommsURL = "http://" + webCommsHost + ":" + webCommsPort + webCommsPath;

                        //Append the SessionKey and ContactID as parameters to the Web Comms URL
                        webCommsURL += "?sessionKey=" + sessionKey + "&contactID=" + contactID + "&telnumber=" + phoneNumber;

                        //redirect to the WebComms URL
                        response.sendRedirect(webCommsURL);
                    }
            }
            else
            {
                    //	Skillset not in use: display message and close
                    response.sendRedirect("ShowChatErrors.jsp?errCode=" + "webchat_no_agents");                                        
            }

        }
        else //Skillset is not in service, display a message to the user
        {
            // create a closed Text Chat contact for reporting purposes
            contactID = customerWs.requestTextChat(myCustomerID, writeContact, true, result.getSessionKey());
            response.sendRedirect("ShowChatErrors.jsp?errCode=" + "webchat_skillset_oos");                                        
        }

    }
    catch(Exception e)
    {
        // Hanlde exceptions...
    }
    
%>