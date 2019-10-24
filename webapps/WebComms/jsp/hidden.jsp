<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>


<HTML>

  <HEAD>
     <meta http-equiv="refresh" content="3">


 	<script language="JavaScript">

	   String.prototype.trim = function() 
	   {

		 // skip leading and trailing whitespace
		 // and return everything in between
		  var x=this;
		  x=x.replace(/^\s*(.*)/, "$1");
		  x=x.replace(/(.*?)\s*$/, "$1");
		  return x;
	   }




	   function giveWebOnHold()
	   
	   {
	   
	   	// If we are already in Web On Hold, do nothing
	   	// otherwise redirect our browser to onhold.jsp
	   
	   	parent.statuscontrol.document.statusform.inSession.value = "0";

		var theurl = ""; 

		theurl = '' + parent.maincontrol.location

	   	if(document.all)
	   	{
	   		// Internet Explorer (all versions)

			if(theurl.indexOf("top.jsp") > 0)
			{
				parent.maincontrol.location = 'onhold.jsp';
	
			}
		}
		else
		{
			// Netscape (all versions)
			if(theurl.indexOf("top.jsp") > 0)
			{
				parent.maincontrol.location.href = 'onhold.jsp';
			}
		}
			

	   }


	   function giveChatTreatment()
	   {
	   
	   	// We have retrieved message(s) from our session. Navigate away
	   	// from Web On Hold to the inchat.jsp page
	   
		var theurl = ""; 
		theurl = '' + parent.maincontrol.location
		parent.statuscontrol.document.statusform.status.value = "Status: Active";
		parent.statuscontrol.document.statusform.inSession.value = "1";

		if(theurl.indexOf("inchat.jsp") == -1)
		{
			parent.maincontrol.location = 'inchat.jsp'

		}

	        parent.statuscontrol.document.statusform.expectedWaitTime.value = ""
        	parent.statuscontrol.document.statusform.positionInQueue.value =  ""
 
	   }


         function setfocus()
         {
      		parent.chatwrite.document.chatform.customerchat.focus();
         }


	   function displayPushedPage( str )
	   {
	   
	   	if(document.all)
	   	{
	   		// Internet Explorer (all versions)

			var theurl = ""; 
			theurl = '' + parent.maincontrol.location;
			parent.statuscontrol.document.statusform.inSession.value = "1";
			parent.maincontrol.location = str;
			
		}
		else
		{
			// Netscape (all versions)
			parent.statuscontrol.document.statusform.inSession.value = "1";
			parent.maincontrol.location.href = str;
			
		}
			
			
			
			
	   }
	   
	   
	   function changeContent(id,shtml) 
	   {
	   
	      if (parent.chatdisplay.document.getElementById || parent.chatdisplay.document.all) 
	      {
	         var el = parent.chatdisplay.document.getElementById? parent.chatdisplay.document.getElementById(id): parent.chatdisplay.document.all[id];
	         if (el && typeof el.innerHTML != "undefined") el.innerHTML = unescape(shtml);
	      }
	      
	   }


        </script>


  </HEAD>
  <body onload=setfocus()>



  <FORM name=hiddenForm>


<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved


String 		strMessage="";
String 		allMessages = "";
String 		lastPageActionUrl = "";
String 		sessionKey;
String 		contactID;
String 		pushUrl="";
int 			length = 0;
boolean		isWriting=false;
String		currentWriteMessage="";
boolean		lastPageActivityByCustomer=true;
boolean		foundQueueInfoFields=false;

String strExpectedWaitTime = "";
String strPositionInQueue = "";
int iExpectedWaitTime = 0;
int iMins = 0;
int iSecs = 0;


String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

request.setCharacterEncoding("utf-8");
sessionKey=request.getParameter("sessionKey");
contactID=request.getParameter("contactID");



// This page refreshes every 3 seconds. Its purpose is to check for new messages from
// the agent. When it retrieves a message, it must distinguish its type i.e. a chat message,
// page push etc. and react to it. Additionally, it notifies the customer if the agent is 
// currently writing a message.


java.util.GregorianCalendar gCalendar = new java.util.GregorianCalendar(2006, 1, 1, 12, 0, 0 );

CIDateTime tm = new CIDateTime();
tm.setMilliseconds(gCalendar.getTimeInMillis());

java.net.URL ciWebCommsWsUrlHidden = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 

CIWebCommsWs webCommsWsLocatorHidden = new CIWebCommsWsLocator();
CIWebCommsWsSoap webCommsWsHidden = webCommsWsLocatorHidden.getCIWebCommsWsSoap( ciWebCommsWsUrlHidden );




CIMultipleChatMessageReadType chatMessages = new CIMultipleChatMessageReadType();

chatMessages = webCommsWsHidden.readChatMessage(new Long(contactID).longValue(), tm, false, sessionKey);



if(chatMessages.isIsWriting())
{
   %><script language="Javascript">
       parent.statuscontrol.document.statusform.isWriting.value = "Agent is writing a message....";      
  </script><%
}
else
{
   %><script language="Javascript">
       parent.statuscontrol.document.statusform.isWriting.value = "";
  </script><%
}


CIChatMessageReadType[] arrayOfMessages = chatMessages.getListOfChatMessages();

if(arrayOfMessages != null)
{
	
     length = arrayOfMessages.length;
	 
     CIChatMessageType lastPageActionType;

     int i;
     for(i=0; i<length; i++)
     {

     	String lastMessage = arrayOfMessages[i].getChatMessage();
     	
	lastPageActionType = arrayOfMessages[i].getChatMessageType();

	if (lastPageActionType == CIChatMessageType.Page_Pushed_by_Customer) 
	{
		allMessages = allMessages + "<br><font color=black>" + lastMessage;
		lastPageActionUrl = arrayOfMessages[i].getHiddenMessage(); 
		lastPageActivityByCustomer = true;
	}
       	else if (lastPageActionType == CIChatMessageType.Page_Pushed_by_Agent)
	{
		allMessages = allMessages + "<br><font color=CC0000>" + lastMessage;
		lastPageActionUrl = arrayOfMessages[i].getHiddenMessage(); 
		lastPageActivityByCustomer = false;
	}
    	else if (lastPageActionType == CIChatMessageType.Form_Shared_by_Customer)
	{  	
		allMessages = allMessages + "<br><font color=black>" + lastMessage;
		lastPageActionUrl = arrayOfMessages[i].getHiddenMessage(); 
		lastPageActivityByCustomer = true;
	}
      	else if (lastPageActionType == CIChatMessageType.Form_Shared_by_Agent)
	{ 	
		allMessages = allMessages + "<br><font color=CC0000>" + lastMessage;
		lastPageActionUrl = arrayOfMessages[i].getHiddenMessage(); 
		lastPageActivityByCustomer = false;
	}
       	else if (lastPageActionType == CIChatMessageType.Page_Previewed_by_Customer)
	{
		allMessages = allMessages + "<br><font color=black>" + lastMessage;
		lastPageActionUrl = arrayOfMessages[i].getHiddenMessage(); 
		lastPageActivityByCustomer = true;
        }
       	else if (lastPageActionType == CIChatMessageType.Chat_Message_from_Customer)
	{
		// the message from the customer will have html tags invalidated so that they render rather than are intrepreted
		allMessages = allMessages + "<br><font color=black>" + lastMessage.replaceAll("<","< ");
        }
       	else if (lastPageActionType == CIChatMessageType.Chat_Message_from_Agent)
	{
		// the message from the agent will have html tags invalidated so that they render rather than are intrepreted
		allMessages = allMessages + "<br><font color=CC0000>" + lastMessage.replaceAll("<","< ");
        }
       	else if (lastPageActionType == CIChatMessageType.CallMe_Request_from_Customer)
	{
		allMessages = allMessages + "<br><font color=black>" + lastMessage;
        }
        
        
        // we now escape all characters
        allMessages = allMessages.replaceAll("\"","&quot;");
        
        

     }

     // when the first message is recieved from the agent, produce an audible alert
     if(i==1)
     {
	%>

	   <script language="JavaScript">
	   if(parent.statuscontrol.document.statusform.inSession.value == "0")
	   {
             document.write("<bgsound src=" + "../sounds/Bell.wav" +" volume=" +"-1000" +"></bgsound>");

	   }

	   </script>
	<%
     }

     %>

     <input type="hidden" name="theReadMessage" value="<%=allMessages%>">
     <input type="hidden" name="thePushedPage" value="<%=lastPageActionUrl%>">
     <input type="hidden" name="msgCount" value="<%=i%>">

     <script language="JavaScript">


     if(parent.wcControl.document.hiddenForm.theReadMessage.value != "")
     {
		if (parent.wcControl.document.hiddenForm.thePushedPage.value == "")
		{
			giveChatTreatment();

		}
		else
		{
			var t = parent.chatdisplay.document.getElementById('chatterbox').innerHTML;
			var lastHttpPos = t.lastIndexOf("http");			
			var pushedUrlPos = t.indexOf(parent.wcControl.document.hiddenForm.thePushedPage.value, lastHttpPos);
						
			if (pushedUrlPos > -1) 
			{
				// do nothing as the page is already loaded
			}
			else
			{
				// page is not currently loaded
				displayPushedPage(parent.wcControl.document.hiddenForm.thePushedPage.value);

			}

		}
		
  
		changeContent("chatterbox",escape(parent.wcControl.document.hiddenForm.theReadMessage.value) + "<br><a id=endOfStream></a>");
		parent.chatdisplay.document.getElementById('endOfStream').scrollIntoView(false);  
			

     }
     </script> 

     <%
}
else
{

     // no messages yet, agent has not joined
	 

    java.net.URL ciContactWsUrlHidden = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIContactWs.asmx"); 
    CIContactWs ciContactWsLocatorHidden = new CIContactWsLocator();
    CIContactWsSoap contactWsHidden = ciContactWsLocatorHidden.getCIContactWsSoap( ciContactWsUrlHidden );


    CIContactReadType theContact = new CIContactReadType();
    theContact = contactWsHidden.readContact(new Long(contactID).longValue(), sessionKey);
    
    if (theContact.getCustomFieldList() != null)
    {

    	for( int i=0; i < theContact.getCustomFieldList().length; i++ )
    	{
   		if( theContact.getCustomFieldList()[i].getName().equals("Expected Wait Time") )
    		{
    			foundQueueInfoFields = true;
        		strExpectedWaitTime = theContact.getCustomFieldList()[i].getText();
        		iExpectedWaitTime = new Integer(strExpectedWaitTime).intValue();
    		    	if(iExpectedWaitTime > 60)
    		    	{
				iSecs = (iExpectedWaitTime % 60);
    		    		iMins = (iExpectedWaitTime / 60) ;
	
			}
			else
			{
    		    		iMins = 0;
				iSecs = iExpectedWaitTime;		
			}
    		}
    
    		if( theContact.getCustomFieldList()[i].getName().equals("Position In Queue") )
    		{
    			foundQueueInfoFields = true;
    		    	strPositionInQueue = theContact.getCustomFieldList()[i].getText();
    		}
    	}

    	if( strExpectedWaitTime.equals("0") )
    	{
	
	
		%>
	
		<input type=hidden name=iMins value=<%=iMins%>>
		<input type=hidden name=iSecs value=<%=iSecs%>>
	
		<script language="javascript">
	
		   parent.statuscontrol.document.statusform.expectedWaitTime.value = "Expected Wait Time : "
		   parent.statuscontrol.document.statusform.positionInQueue.value =  "Position In Queue  : " + <%=strPositionInQueue%>
   
		</script>

		<%

    	}
    	else if( foundQueueInfoFields )
    	{

		%>
	
	
		<script language="javascript">

		   parent.statuscontrol.document.statusform.expectedWaitTime.value = "Expected Wait Time : " + <%=iMins%> + " m " + <%=iSecs%> + " s"
		   parent.statuscontrol.document.statusform.positionInQueue.value =  "Position In Queue  : " + <%=strPositionInQueue%>
   
		</script>

		<%

    	}
    }


     %>
     <script language="JavaScript">
	giveWebOnHold();
     </script>
     <%

            
}


%>

</form>
</BODY>
</html>
