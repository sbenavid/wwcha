/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-24 16:02:35 UTC
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

public final class chatwrite64_jsp extends org.apache.jasper.runtime.HttpJspBase
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


   //Avaya Aura Contact Center Multimedia 
   //Copyright � 2014 Avaya Inc. All Rights Reserved

   String 		sessionKey;
   String 		contactID;
   String		message;
   String 		chatbox="";
   String		hiddenMessage="";
   String 		type="";
   String               telnumber="";
   
   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");
   message=request.getParameter("message");
   chatbox=request.getParameter("chatbox");
   hiddenMessage=request.getParameter("hiddenMessage");
   type=request.getParameter("type");
   telnumber = request.getParameter("telnumber");
   
   // Customer Question
   // String onHoldQuestion="";
   // onHoldQuestion = request.getParameter("onHoldQuestion");
   
   String newnumber = "";
   newnumber = request.getParameter("newnumber");
   
   
   if (telnumber == null)
   {
       telnumber = "";
   }
   
   if (newnumber == null)
   {
       newnumber = "";
   }
      
   // If this is an anonymous connection/session, set the phone number to empty.
   if (telnumber.equals("NONE"))
   {
       telnumber = "";
   }
   
   
   if (chatbox == null)
   {
	chatbox ="";
   }

   if (message == null)
   {
   	message = "null";
   }

   if (message.indexOf("null") == -1)
   {
	try
   	{
	
		java.net.URL ciWebCommsWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 

		CIWebCommsWs webCommsWsLocator = new CIWebCommsWsLocator();
		CIWebCommsWsSoap webCommsWs = webCommsWsLocator.getCIWebCommsWsSoap( ciWebCommsWsUrl );

		// We can either prefix the written message with a generic customer prefix
		// as configured in the CCMM Administrator or alternatively we can choose to
		// prefix the message by the customer name
		
                // Option1: Uncomment the section below to use the default [Customer] tag, as per CCMM Admin:
		/// String custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);

                // Option2: Get the name based on the contact ID:
                // Note: This can be empty/null in the case of a an anonymous chat implementation.
                
                String custLabel = "";
		CICustomerChatNameReadType customerName = webCommsWs.getCustomerTextChatName(new Long(contactID).longValue(), sessionKey);
                
                if(customerName.getFirstName() != null) // This may not be set if the session is an anonymous chat session:
                {
                    // Set the Customer label to be the Customer first name:
                    custLabel = "[" + customerName.getFirstName() + "]";
                }
                else
                {
                    custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);
                }
                                
		message = custLabel + " " + message;

   		// We must write the correct message type with the text. This allows the agent to correctly process
   		// the message e.g. display pushed page. The hiddenMessage is the URL of a pushed page.

		if(type.equals("Chat_Message_from_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, "", CIChatMessageType.Chat_Message_from_Customer, sessionKey);    
		}
		else if (type.equals("Page_Pushed_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Page_Pushed_by_Customer, sessionKey);    
		}
		else if (type.equals("Form_Shared_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Form_Shared_by_Customer, sessionKey);    
		}
		else if (type.equals("CallMe_Request_from_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.CallMe_Request_from_Customer, sessionKey);    
		}
		else if (type.equals("Page_Previewed_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Page_Previewed_by_Customer, sessionKey);    
		}
		else if (type.equals("Session_Disconnected_by_Customer"))
		{
			long status = webCommsWs.writeChatMessage(new Long(contactID).longValue(), message, hiddenMessage, CIChatMessageType.Session_Disconnected_by_Customer, sessionKey);    
		}

	}
   	catch(Exception e)
   	{
   	
   		// We caught an exception while trying to write a chat message. The session has been disconnected. 
   		// Inform the customer that the agent has left the conversation and update the status.
   	
		
      out.write("<script language=\"Javascript\">\r\n");
      out.write("\t\t\tparent.chatdisplay.document.chatform.chatterbox.value = parent.chatdisplay.document.chatform.chatterbox.value + \"\\n\" + \"Agent has left the conversation.\";\r\n");
      out.write("\t\t\tparent.chatdisplay.document.chatform.chatterbox.scrollTop = parent.chatdisplay.document.chatform.chatterbox.scrollHeight;\r\n");
      out.write("\t\t\tparent.statuscontrol.document.statusform.status.value = \"Session Disconnected\";\r\n");
      out.write("\t\t\tparent.statuscontrol.document.statusform.inSession.value = \"0\";\r\n");
      out.write("\r\n");
      out.write("\t\t</script>");

	}
   }


      out.write("\r\n");
      out.write("\r\n");
      out.write("<HTML>\r\n");
      out.write("\r\n");
      out.write("  <style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("    .textarea\r\n");
      out.write("    {\r\n");
      out.write("\tcolor: ffffff;\r\n");
      out.write("\tborder: 0px;\r\n");
      out.write("\tbackground-color:transparent;\r\n");
      out.write("\toverflow:auto;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .customerchat\r\n");
      out.write("    {\r\n");
      out.write("\toverflow:auto;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .status\r\n");
      out.write("    {\r\n");
      out.write("\tbackground-color:transparent;\r\n");
      out.write("\tborder: 0px;\r\n");
      out.write("\tcolor: CC0000;\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .isWriting\r\n");
      out.write("    {\r\n");
      out.write("\tbackground-color:transparent;\r\n");
      out.write("\tborder: 0px;\r\n");
      out.write("\tcolor: CC0000;\r\n");
      out.write("\tfont-style: italic;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .table\r\n");
      out.write("    {\r\n");
      out.write("\tposition: absolute; top: 10px;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("  </style>\r\n");
      out.write("  <link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\" />\r\n");
      out.write("<HEAD>\r\n");
      out.write("\r\n");
      out.write("<script LANGUAGE=\"JavaScript\">\r\n");
      out.write("\r\n");
      out.write("  NS4 = (document.layers) ? true : false;\r\n");
      out.write("\r\n");
      out.write("  function checkEnter(event)\r\n");
      out.write("  { \t\r\n");
      out.write("\t// If the enter key was pressed, send the message or assume a page preview.\r\n");
      out.write("\tvar code = 0;\r\n");
      out.write("       \r\n");
      out.write("\tif (NS4)\r\n");
      out.write("\t\tcode = event.which;\r\n");
      out.write("\telse\r\n");
      out.write("\t\tcode = event.keyCode;\r\n");
      out.write("            \r\n");
      out.write("\tif (code==13)\r\n");
      out.write("\t{\r\n");
      out.write("\t\tsendChat();\r\n");
      out.write("\t\tparent.chatwrite.document.chatform.submit();\r\n");
      out.write("                //parent.statuscontrol.RefreshChatHistory();\r\n");
      out.write("\t}\r\n");
      out.write("        else\r\n");
      out.write("        {\r\n");
      out.write("           // NOTE: This exmaple implements the \"Customer Is Typing\"  feature\r\n");
      out.write("           // each time a key is pressed. To reduce the load on the server, this can\r\n");
      out.write("           // be reduced by only allowing this once per 'pre-submit' time interval.\r\n");
      out.write("            \r\n");
      out.write("           // Check if the customer is typing in the chat text-area: \r\n");
      out.write("           // If text remmains in the text-area inform the agent that the\r\n");
      out.write("           // customer is typing a message:\r\n");
      out.write("           if (document.chatform.customerchat.value.length > 0)\r\n");
      out.write("           {\r\n");
      out.write("               parent.statuscontrol.InformCustomerIsTyping(true);\r\n");
      out.write("           }\r\n");
      out.write("           else // Customer has removed any text and is no longer typing: \r\n");
      out.write("           {\r\n");
      out.write("               parent.statuscontrol.InformCustomerIsTyping(false);\r\n");
      out.write("           }\r\n");
      out.write("        }\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  \r\n");
      out.write("  function setfocus()\r\n");
      out.write("  {\r\n");
      out.write("  \tdocument.chatform.customerchat.focus();\r\n");
      out.write("        \r\n");
      out.write("        var origTelNumber = \"");
      out.print(telnumber);
      out.write("\";\r\n");
      out.write("        var updatedTelNumber = \"");
      out.print(newnumber);
      out.write("\";\r\n");
      out.write("       \r\n");
      out.write("        // The page is reloaded everytime a message is sent.\r\n");
      out.write("        // Update the phone number field to be the correct value.\r\n");
      out.write("        if (updatedTelNumber.length > 0)\r\n");
      out.write("        {\r\n");
      out.write("            document.getElementById('phonenumber').value = updatedTelNumber;\r\n");
      out.write("        }\r\n");
      out.write("        else\r\n");
      out.write("        {\r\n");
      out.write("            document.getElementById('phonenumber').value = origTelNumber;\r\n");
      out.write("        }\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function sendChat()\r\n");
      out.write("  {\r\n");
      out.write("    // Send the chat message only if there is an active session and there is a message to send.\r\n");
      out.write("\r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"El mensaje no puede enviarse debido a que no hay un agente activo para esta conversacion.\");\r\n");
      out.write("    }\r\n");
      out.write("    else\r\n");
      out.write("    {\r\n");
      out.write("    \t\r\n");
      out.write("\tif(parent.chatwrite.document.chatform.customerchat.value==\"\")\r\n");
      out.write("\t{\r\n");
      out.write("\t\r\n");
      out.write("\t  // do nothing as the user has not entered a chat message\r\n");
      out.write("\t  parent.chatwrite.document.chatform.message.value = \"null\";\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("\telse\r\n");
      out.write("\t{\r\n");
      out.write("\t  parent.chatwrite.document.chatform.customerchat.value = \" \" + parent.chatwrite.document.chatform.customerchat.value;\r\n");
      out.write("\t  parent.chatwrite.document.chatform.message.value = parent.chatwrite.document.chatform.customerchat.value;\r\n");
      out.write("\t  parent.chatwrite.document.chatform.type.value = \"Chat_Message_from_Customer\";\r\n");
      out.write("\t  parent.chatwrite.document.chatform.hiddenMessage.value = \"\";\r\n");
      out.write("\t  parent.chatwrite.document.chatform.customerchat.value = \"\";\r\n");
      out.write("          \r\n");
      out.write("          // Keep a copy of the latest customer Telephone number:\r\n");
      out.write("          parent.chatwrite.document.chatform.newnumber.value = document.getElementById('phonenumber').value;\r\n");
      out.write("          \r\n");
      out.write("\t  message = null;\r\n");
      out.write("\t}\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  function printChat()\r\n");
      out.write("  {\r\n");
      out.write("     window.parent.chatdisplay.focus();\r\n");
      out.write("     window.print();\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  function exitChat()\r\n");
      out.write("  {\r\n");
      out.write("  \t// Terminate the session if the user confirms.\r\n");
      out.write("  \r\n");
      out.write("  \tvar isSessionActive = parent.statuscontrol.document.statusform.inSession.value;\r\n");
      out.write("\tvar answer = confirm (\"This will close your Web Chat session. Do you wish to continue?\") \r\n");
      out.write("\tif (answer) \r\n");
      out.write("\t{\r\n");
      out.write("\t\t// Close the session:\r\n");
      out.write("\t\t// Session cleanup code is contained in exitFormImpl64.jsp\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tparent.location=\"exitFormImpl64.jsp?sessionKey=");
      out.print(sessionKey);
      out.write("&contactID=");
      out.print(contactID);
      out.write("&inSession=\" + isSessionActive;\t   \r\n");
      out.write("\t}\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function checkSpace(event)\r\n");
      out.write("  { \t\r\n");
      out.write("\treturn event.which !== 32;\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function callMeBack()\r\n");
      out.write("  {\r\n");
      out.write("  \r\n");
      out.write("    // If the customer and agent are in an active session, then allow the customer\r\n");
      out.write("    // to request that the agent calls them. Prompt for a telephone number and\r\n");
      out.write("    // notify the agent of the request.\r\n");
      out.write("   \r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"Opcion no disponible debido a que no se encuentra en sesion de chat activa.\");\r\n");
      out.write("    }\r\n");
      out.write("    else\r\n");
      out.write("    {\r\n");
      out.write("\r\n");
      out.write("      var customerNumber = \"\";\r\n");
      out.write("      customerNumber = document.getElementById('phonenumber').value;\r\n");
      out.write("      \r\n");
      out.write("      if (0 == customerNumber.length)\r\n");
      out.write("      {\r\n");
      out.write("          // Ask the customer for their number\r\n");
      out.write("          customerNumber = prompt(\"Proporcione un numero al cual podeamos llamarle:\", \"\"); \r\n");
      out.write("          document.getElementById('phonenumber').value = customerNumber;\r\n");
      out.write("      }\r\n");
      out.write("            \r\n");
      out.write("      // Note: In this example, no validation of entered values are done...\r\n");
      out.write("      // Ensure the number you are passing to the agent is forrectly formatted\r\n");
      out.write("      \r\n");
      out.write("      if ((customerNumber != null) && (customerNumber.length > 0))\r\n");
      out.write("      {\r\n");
      out.write("      \t document.chatform.message.value = \" El cliente solicito llamarle: \" + customerNumber;\r\n");
      out.write("\t document.chatform.hiddenMessage.value = customerNumber;\r\n");
      out.write("\t document.chatform.type.value = \"CallMe_Request_from_Customer\";\r\n");
      out.write("         \r\n");
      out.write("         parent.chatwrite.document.chatform.newnumber.value = customerNumber;\r\n");
      out.write("         \r\n");
      out.write("      \t document.chatform.submit();\r\n");
      out.write("      }\r\n");
      out.write("      else\r\n");
      out.write("      {\r\n");
      out.write("         alert(\"Favor de proporcionar su telefono\");\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("</HEAD>\r\n");
      out.write("\r\n");
      out.write("<body background=\"../images/bg2.gif\" onload=setfocus()>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" height=\"70%\" class=\"table\">\r\n");
      out.write(" <tr>\r\n");
      out.write("  <td width=\"60%\">\r\n");
      out.write("    <form name=\"chatform\" method=\"POST\">\r\n");
      out.write("      <textarea name=\"customerchat\" class=\"customerchat\" cols=65 rows=2 onkeypress=\"checkEnter(event)\"></textarea>\r\n");
      out.write("      <input type=\"submit\" id='enterButton' class=\"wc_submit\" style=\"vertical-align:bottom;\" value=\"Submit\" onClick=\"sendChat();\" />\r\n");
      out.write("      <input type=\"hidden\" name=\"message\" value=\"");
      out.print(message);
      out.write("\">\r\n");
      out.write("      <input type=\"hidden\" name=\"chatbox\" value=\"");
      out.print(chatbox);
      out.write("\">\r\n");
      out.write("      <input type=\"hidden\" name=\"type\" value=\"");
      out.print(type);
      out.write("\">\r\n");
      out.write("      <input type=\"hidden\" name=\"hiddenMessage\" value=\"");
      out.print(hiddenMessage);
      out.write("\">\r\n");
      out.write("      <input type=\"hidden\" name=\"telnumber\" value=\"");
      out.print(telnumber);
      out.write("\"><!-- Telephone number passed in by WebChat login screen -->\r\n");
      out.write("      <input type=\"hidden\" name=\"newnumber\" value=\"");
      out.print(newnumber);
      out.write("\">\r\n");
      out.write("  </form>\r\n");
      out.write(" </tr>\r\n");
      out.write(" <tr>\r\n");
      out.write("   <td width=\"60%\" >\r\n");
      out.write("       <input class=\"customerchat\" align=\"right\" type=\"field\" maxlength=\"24\" disabled id=\"phonenumber\" name=\"phonenumber\" size=\"30\" onKeyPress=\"return checkSpace(event)\" />\r\n");
      out.write("       <input type=\"image\" style=\"cursor:hand;padding-top:5px;padding-left:15px;padding-bottom:2px;padding-right:15px;vertical-align:bottom;\" src=\"../images/icon_callme_small.gif\" height=\"20\" width=\"20\" border=\"0\" title=\"Ask the agent to call you\" id='CallMeButton' onclick=\"callMeBack();\"/>\r\n");
      out.write("       <input type=\"image\" style=\"cursor:hand;padding-top:5px;padding-left:15px;padding-bottom:2px;padding-right:15px;vertical-align:bottom;\" src=\"../images/close.png\" height=\"20\" width=\"20\" border=\"0\" title=\"Close my chat session\" id='closeButton' onclick=\"exitChat();\"/>       \r\n");
      out.write("   </td>\r\n");
      out.write(" </tr>\r\n");
      out.write(" \r\n");
      out.write("</table>\r\n");
      out.write("  \r\n");
      out.write("</BODY>\r\n");
      out.write("</HTML>\r\n");
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
