/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-09 17:03:24 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import com.nortel.applications.ccmm.ci.datatypes.*;
import com.nortel.applications.ccmm.ci.webservices.*;

public final class hidden64_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<HTML>\r\n");
      out.write("\r\n");
      out.write("  <HEAD>\r\n");
      out.write("     <meta http-equiv=\"refresh\" content=\"3\">\r\n");
      out.write("\r\n");
      out.write(" \t<script language=\"JavaScript\">\r\n");
      out.write("\r\n");
      out.write("        String.prototype.trim = function() \r\n");
      out.write("        {\r\n");
      out.write("              // skip leading and trailing whitespace\r\n");
      out.write("              // and return everything in between\r\n");
      out.write("               var x=this;\r\n");
      out.write("               x=x.replace(/^\\s*(.*)/, \"$1\");\r\n");
      out.write("               x=x.replace(/(.*?)\\s*$/, \"$1\");\r\n");
      out.write("               return x;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        function giveWebOnHold()\r\n");
      out.write("        {\r\n");
      out.write("             // If we are already in Web On Hold, do nothing\r\n");
      out.write("             // otherwise redirect our browser to onhold.jsp\r\n");
      out.write("             parent.statuscontrol.document.statusform.inSession.value = \"0\";\r\n");
      out.write("\r\n");
      out.write("             var theurl = \"\"; \r\n");
      out.write("             theurl = '' + parent.maincontrol.location;\r\n");
      out.write("\r\n");
      out.write("             if(document.all)\r\n");
      out.write("             {\r\n");
      out.write("                     // Internet Explorer (all versions)\r\n");
      out.write("\r\n");
      out.write("                     if(theurl.indexOf(\"top.jsp\") > 0)\r\n");
      out.write("                     {\r\n");
      out.write("                        parent.maincontrol.location = 'onhold64.jsp';\r\n");
      out.write("                     }\r\n");
      out.write("             }\r\n");
      out.write("             else\r\n");
      out.write("             {\r\n");
      out.write("                     // Netscape (all versions)\r\n");
      out.write("                     if(theurl.indexOf(\"top.jsp\") > 0)\r\n");
      out.write("                     {\r\n");
      out.write("                        parent.maincontrol.location.href = 'onhold64.jsp';\r\n");
      out.write("                     }\r\n");
      out.write("             }\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        function giveChatTreatment()\r\n");
      out.write("        {\r\n");
      out.write("             // We have retrieved message(s) from our session. Navigate away\r\n");
      out.write("             // from Web On Hold to the inchat64.jsp page\r\n");
      out.write("\r\n");
      out.write("             var theurl = \"\"; \r\n");
      out.write("             theurl = '' + parent.maincontrol.location\r\n");
      out.write("             parent.statuscontrol.document.statusform.status.value = \"Status: Active\";\r\n");
      out.write("             parent.statuscontrol.document.statusform.inSession.value = \"1\";\r\n");
      out.write("\r\n");
      out.write("             if(theurl.indexOf(\"inchat64.jsp\") == -1)\r\n");
      out.write("             {\r\n");
      out.write("                     parent.maincontrol.location = 'inchat64.jsp'\r\n");
      out.write("\r\n");
      out.write("             }\r\n");
      out.write("\r\n");
      out.write("             parent.statuscontrol.document.statusform.expectedWaitTime.value = \"\"\r\n");
      out.write("             parent.statuscontrol.document.statusform.positionInQueue.value =  \"\"\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        function setfocus()\r\n");
      out.write("        {\r\n");
      out.write("            parent.chatwrite.document.chatform.customerchat.focus();\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        function displayPushedPage( str )\r\n");
      out.write("        {\r\n");
      out.write("            \r\n");
      out.write("             if(document.all)\r\n");
      out.write("             {\r\n");
      out.write("                     // Internet Explorer (all versions)\r\n");
      out.write("\r\n");
      out.write("                     var theurl = \"\"; \r\n");
      out.write("                     theurl = '' + parent.maincontrol.location;\r\n");
      out.write("\r\n");
      out.write("                     parent.statuscontrol.document.statusform.inSession.value = \"1\";\r\n");
      out.write("                     parent.maincontrol.location = str;\r\n");
      out.write("\r\n");
      out.write("             }\r\n");
      out.write("             else\r\n");
      out.write("             {\r\n");
      out.write("                     // Netscape (all versions)\r\n");
      out.write("                     parent.statuscontrol.document.statusform.inSession.value = \"1\";\r\n");
      out.write("                     parent.maincontrol.location.href = str;\r\n");
      out.write("\r\n");
      out.write("             }\r\n");
      out.write("        }\r\n");
      out.write("\t   \r\n");
      out.write("        function changeContent(id,shtml) \r\n");
      out.write("        {\r\n");
      out.write("           if (parent.chatdisplay.document.getElementById || parent.chatdisplay.document.all) \r\n");
      out.write("           {\r\n");
      out.write("              var el = parent.chatdisplay.document.getElementById? parent.chatdisplay.document.getElementById(id): parent.chatdisplay.document.all[id];\r\n");
      out.write("              if (el && typeof el.innerHTML != \"undefined\") el.innerHTML = unescape(shtml);\r\n");
      out.write("           }\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  </HEAD>\r\n");
      out.write("  <body onload=setfocus()>\r\n");
      out.write("\r\n");
      out.write("  <FORM name=hiddenForm>\r\n");
      out.write("\r\n");
      out.write("\r\n");


   //Avaya Aura Contact Center Multimedia 
   //Copyright 2014 Avaya Inc. All Rights Reserved

   // This page refreshes every 3 seconds. Its purpose is to check for new messages from
   // the agent. When it retrieves a message, it must distinguish its type i.e. a chat message,
   // page push etc. and react to it. Additionally, it notifies the customer if the agent is 
   // currently writing a message.
    
   // Allow an extra 300 Miliseconds to ensure dependant frames (e.g. Status) have loaded
   Thread.sleep(300);
	
	
String 		allMessages = "";
String 		lastPageActionUrl = "";
String 		sessionKey;
String 		contactID;
int 		length = 0;
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

// Customer is typing a message....
//
// Check if the Customer is currently typing a message:
// If the "customerTyping" value has been POSTed to this page from the Chat text area,
// call the updateAliveTimeAndUpdateIsTyping webservice to inform the agent.
//
// Note: When using updateAliveTimeAndUpdateIsTyping with Typing set to True, no further requests should
//       be made for chat messages for a number of seconds to allow the agent to be informed.
//
String isCustomerTyping = "";
Boolean bIsCustomerTyping = false;
isCustomerTyping=request.getParameter("customerTyping");

// isCustomerTyping will be null for any regular page refresh (e.g. 3 second intervals)
// set to "1" by chatwrite64.jsp.
if (isCustomerTyping != null)
{
    if (isCustomerTyping.equals("1"))
    {
        bIsCustomerTyping = true;
        
        java.net.URL ciWebCommsWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 
        
        CIDateTime dt 	= new CIDateTime();
        CIWebCommsWs webCommsWsLocator = new CIWebCommsWsLocator();
        CIWebCommsWsSoap webCommsWs = webCommsWsLocator.getCIWebCommsWsSoap( ciWebCommsWsUrl );

        dt = webCommsWs.updateAliveTimeAndUpdateIsTyping(new Long(contactID).longValue(), sessionKey, bIsCustomerTyping); 
        
    }
}

// Continue as normal and read any chat messages if the customer is NOT typing.
// If the customer is typing delay this procedure and it will be executed in the next
// refresh cycle e.g. approx 3 seconds (as configured in the HEAD of this file.
if (bIsCustomerTyping.equals(false))
{
    
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
       
      out.write("<script language=\"Javascript\">\r\n");
      out.write("           parent.statuscontrol.document.statusform.isWriting.value = \"Agent is writing a message....\";      \r\n");
      out.write("      </script>");

    }
    else
    {
       
      out.write("<script language=\"Javascript\">\r\n");
      out.write("       if (parent.statuscontrol.document.statusform.isWriting.value != null)\r\n");
      out.write("\t   {\r\n");
      out.write("           parent.statuscontrol.document.statusform.isWriting.value = \"\";\r\n");
      out.write("       }\r\n");
      out.write("      </script>");

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

            // ** Session_Disconnected_by_Agent **
            // Inform the customer that the agent has left the conversation:
            else if (lastPageActionType == CIChatMessageType.Session_Disconnected_by_Agent)
            {
                    allMessages = allMessages + "<br><font color=black>" + lastMessage;
            }            
            
            // we now escape all characters
            allMessages = allMessages.replaceAll("\"","&quot;");
           
            
         }

         // when the first message is recieved from the agent, produce an audible alert
         if(i==1)
         {
            
      out.write("\r\n");
      out.write("\r\n");
      out.write("               <script language=\"JavaScript\">\r\n");
      out.write("               if(parent.statuscontrol.document.statusform.inSession.value == \"0\")\r\n");
      out.write("               {\r\n");
      out.write("                 document.write(\"<bgsound src=\" + \"../sounds/Bell.wav\" +\" volume=\" +\"-1000\" +\"></bgsound>\");\r\n");
      out.write("\r\n");
      out.write("               }\r\n");
      out.write("\r\n");
      out.write("               </script>\r\n");
      out.write("            ");

         }

         
      out.write("\r\n");
      out.write("\r\n");
      out.write("         <input type=\"hidden\" name=\"theReadMessage\" value=\"");
      out.print(allMessages);
      out.write("\">\r\n");
      out.write("         <input type=\"hidden\" name=\"thePushedPage\" value=\"");
      out.print(lastPageActionUrl);
      out.write("\">\r\n");
      out.write("         <input type=\"hidden\" name=\"msgCount\" value=\"");
      out.print(i);
      out.write("\">\r\n");
      out.write("\r\n");
      out.write("         <script language=\"JavaScript\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("         if(parent.wcControl.document.hiddenForm.theReadMessage.value != \"\")\r\n");
      out.write("         {\r\n");
      out.write("                    if (parent.wcControl.document.hiddenForm.thePushedPage.value == \"\")\r\n");
      out.write("                    {\r\n");
      out.write("                            giveChatTreatment();\r\n");
      out.write("                    }\r\n");
      out.write("                    else\r\n");
      out.write("                    {\r\n");
      out.write("                            var t = parent.chatdisplay.document.getElementById('chatterbox').innerHTML;\r\n");
      out.write("                            var lastHttpPos = t.lastIndexOf(\"http\");\t\t\t\r\n");
      out.write("                            var pushedUrlPos = t.indexOf(parent.wcControl.document.hiddenForm.thePushedPage.value, lastHttpPos);\r\n");
      out.write("\r\n");
      out.write("                            if (pushedUrlPos > -1) \r\n");
      out.write("                            {\r\n");
      out.write("                                    // do nothing as the page is already loaded\r\n");
      out.write("                            }\r\n");
      out.write("                            else\r\n");
      out.write("                            {\r\n");
      out.write("                                    // page is not currently loaded\r\n");
      out.write("                                    displayPushedPage(parent.wcControl.document.hiddenForm.thePushedPage.value);\r\n");
      out.write("                            }\r\n");
      out.write("\r\n");
      out.write("                    }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    changeContent(\"chatterbox\",escape(parent.wcControl.document.hiddenForm.theReadMessage.value) + \"<br><a id=endOfStream></a>\");\r\n");
      out.write("                    parent.chatdisplay.document.getElementById('endOfStream').scrollIntoView(false); \r\n");
      out.write("         }\r\n");
      out.write("         </script> \r\n");
      out.write("\r\n");
      out.write("         ");

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


                    
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    <input type=hidden name=iMins value=");
      out.print(iMins);
      out.write(">\r\n");
      out.write("                    <input type=hidden name=iSecs value=");
      out.print(iSecs);
      out.write(">\r\n");
      out.write("\r\n");
      out.write("                    <script language=\"javascript\">\r\n");
      out.write("                       parent.statuscontrol.document.statusform.expectedWaitTime.value = \"Expected Wait Time : \"\r\n");
      out.write("                       parent.statuscontrol.document.statusform.positionInQueue.value =  \"Position In Queue  : \" + ");
      out.print(strPositionInQueue);
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    </script>\r\n");
      out.write("\r\n");
      out.write("                    ");


            }
            else if( foundQueueInfoFields )
            {

                    
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    <script language=\"javascript\">\r\n");
      out.write("\r\n");
      out.write("                       parent.statuscontrol.document.statusform.expectedWaitTime.value = \"Expected Wait Time : \" + ");
      out.print(iMins);
      out.write(" + \" m \" + ");
      out.print(iSecs);
      out.write(" + \" s\"\r\n");
      out.write("                       parent.statuscontrol.document.statusform.positionInQueue.value =  \"Position In Queue  : \" + ");
      out.print(strPositionInQueue);
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    </script>\r\n");
      out.write("\r\n");
      out.write("                    ");


            }
        }


         
      out.write("\r\n");
      out.write("         <script language=\"JavaScript\">\r\n");
      out.write("            giveWebOnHold();\r\n");
      out.write("         </script>\r\n");
      out.write("         ");


    }
} // End Check if the Customer is typing...
    

      out.write("\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("</BODY>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}