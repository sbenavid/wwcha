<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>

<HTML>
  <HEAD>
     <meta http-equiv="refresh" content="30">
      	
     <script language="JavaScript">

        function setfocus()
        {
           parent.chatwrite.document.chatform.customerchat.focus();
        }
        
     </script>

  </HEAD>
  <Body onload=setfocus()>
  <FORM name="heartbeat">

<%


   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved

   // Allow an extra 300 Miliseconds to ensure dependant frames (e.g. Status) have loaded
   Thread.sleep(300);
   
   String 			sessionKey;
   String 			contactID;
   CIDateTime dt 		= new CIDateTime();
   CIDateTime serverTime 	= new CIDateTime();
   long				theLastAgentPollTime = 0;
   long				theCurrentTime = 0;
   long				dateDifferential = 0;
   
   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");


   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");

   try
   {
   
   
   	// This page is reloaded every 30 seconds. It acts as a heartbeat to determine if
   	// the session is still active i.e. provide notification to the customer if the 
   	// agent has left the session etc. It does this by updating a timer held in the database,
   	// (which is checked by the agent desktop for the same purpose) and retrieving the last time
   	// the agent updated their timer. It then gets the time difference (from the server time).
   	// This method is independant of timezone and Daylight Savings Time - if our customer and agent 
   	// are in different timezones, this method will still work as the time the agent last updated
   	// their timer and the server timer are both returned as the number of milliseconds since
   	// Jan 1, 1970 UTC. All times are taken from the CCMM server, clock discrepencies with the 
   	// webserver will not impact the application.
   

	java.net.URL ciWebCommsWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 
	java.net.URL ciUtilityWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx"); 

	CIWebCommsWs webCommsWsLocator = new CIWebCommsWsLocator();
	CIWebCommsWsSoap webCommsWs = webCommsWsLocator.getCIWebCommsWsSoap( ciWebCommsWsUrl );

	dt = webCommsWs.updateAliveTime(new Long(contactID).longValue(), sessionKey); 
	
	theLastAgentPollTime = dt.getMilliseconds();
	
	
	CIUtilityWs utilWsLocator = new CIUtilityWsLocator();
	CIUtilityWsSoap utilWs = utilWsLocator.getCIUtilityWsSoap( ciUtilityWsUrl );

	serverTime = utilWs.getServerTime();
			
	dateDifferential = (serverTime.getMilliseconds() - theLastAgentPollTime) / 1000;

   }
   catch(java.rmi.RemoteException re)
   {
	if(re.getMessage().indexOf("8756") > -1)
	{
	    dateDifferential = -2; //session completed
	}
	else
	{
	    dateDifferential = -1;  // no agent yet
	}	
   }
   catch(Exception e)
   {
	dateDifferential = -2; // session has completed
   }

%>
    <INPUT TYPE=HIDDEN NAME=dt value="<%=dateDifferential%>">
    <INPUT TYPE=HIDDEN NAME=theLastAgentPollTime value="<%=theLastAgentPollTime%>">
    <INPUT TYPE=HIDDEN NAME=polledServerTime value="<%=serverTime.getMilliseconds()%>">
 

    <script language="Javascript">
	if(heartbeat.dt.value == -1)
	{
   	   // agent has not yet joined the session
		parent.statuscontrol.document.statusform.status.value = "Status: Not Connected";
		parent.statuscontrol.document.statusform.isWriting.value = "";
		parent.statuscontrol.document.statusform.inSession.value = "0";

	}
	else if (heartbeat.dt.value == -2)
	{
	   // agent has disconnected from the session
		parent.statuscontrol.document.statusform.status.value = "Status: Not Connected";
		parent.statuscontrol.document.statusform.isWriting.value = "";
		parent.statuscontrol.document.statusform.inSession.value = "0";


	}
	else if (heartbeat.dt.value > 75)
	{
	   // agent has lost the session
		parent.statuscontrol.document.statusform.status.value = "Status: Not Connected";
		parent.statuscontrol.document.statusform.isWriting.value = "";
		parent.statuscontrol.document.statusform.inSession.value = "0";

	}
	else
	{
	   // agent is active on the session
		parent.statuscontrol.document.statusform.status.value = "Status: Active";
		parent.statuscontrol.document.statusform.inSession.value = "1";
	}
				
   </script>

</body>
</HTML>