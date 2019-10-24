/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-15 22:01:13 UTC
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

public final class chatwrite_jsp extends org.apache.jasper.runtime.HttpJspBase
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
   //Copyright � 2010 Avaya Inc. All Rights Reserved


   String 		sessionKey;
   String 		contactID;
   String		message;
   String 		chatbox="";
   String		hiddenMessage="";
   String 		type="";

   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");
   message=request.getParameter("message");
   chatbox=request.getParameter("chatbox");
   hiddenMessage=request.getParameter("hiddenMessage");
   type=request.getParameter("type");



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
		
		String custLabel = webCommsWs.getCustomerTextChatLabel(sessionKey);

		// CICustomerChatNameReadType customerName = webCommsWs.getCustomerTextChatName(new Long(contactID).longValue(), sessionKey);
		// String custLabel = "[" + customerName.getFirstName() + " " + customerName.getLastName() + "]";


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
      out.write("\r\n");
      out.write("<HEAD>\r\n");
      out.write("\r\n");
      out.write("<script LANGUAGE=\"JavaScript\">\r\n");
      out.write("\r\n");
      out.write("  NS4 = (document.layers) ? true : false;\r\n");
      out.write("\r\n");
      out.write("  function checkEnter(event)\r\n");
      out.write("  { \t\r\n");
      out.write("\t\r\n");
      out.write("\t// If the enter key was pressed, send the message or assume a page preview.\r\n");
      out.write("\t\r\n");
      out.write("\tvar code = 0;\r\n");
      out.write("\t\r\n");
      out.write("\tif (NS4)\r\n");
      out.write("\t\tcode = event.which;\r\n");
      out.write("\telse\r\n");
      out.write("\t\tcode = event.keyCode;\r\n");
      out.write("\tif (code==13)\r\n");
      out.write("\t{\r\n");
      out.write("\t\tsendChat();\r\n");
      out.write("\t\tparent.chatwrite.document.chatform.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("  }\r\n");
      out.write("  \r\n");
      out.write("  function setfocus()\r\n");
      out.write("  {\r\n");
      out.write("  \tdocument.chatform.customerchat.focus();\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function sendChat()\r\n");
      out.write("  {\r\n");
      out.write("\r\n");
      out.write("    // Send the chat message only if there is an active session and there is a message to send.\r\n");
      out.write("\r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"El mensaje no puede ser enviado, pues no hay un agente activo en la conversacion.\");\r\n");
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
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\t  parent.chatwrite.document.chatform.customerchat.value = \" \" + parent.chatwrite.document.chatform.customerchat.value;\r\n");
      out.write("\t  parent.chatwrite.document.chatform.message.value = parent.chatwrite.document.chatform.customerchat.value;\r\n");
      out.write("\t  parent.chatwrite.document.chatform.type.value = \"Chat_Message_from_Customer\";\r\n");
      out.write("\t  parent.chatwrite.document.chatform.hiddenMessage.value = \"\";\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t  parent.chatwrite.document.chatform.customerchat.value = \"\";\r\n");
      out.write("\t  message = null;\r\n");
      out.write("\t\r\n");
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
      out.write("  \r\n");
      out.write("  \t// Terminate the session if the user confirms.\r\n");
      out.write("  \r\n");
      out.write("  \tvar isSessionActive = parent.statuscontrol.document.statusform.inSession.value;\r\n");
      out.write("\tvar answer = confirm (\"This will close your Web Communications session. Are you sure?\") \r\n");
      out.write("\tif (answer) \r\n");
      out.write("\t{\r\n");
      out.write("\t\tparent.statuscontrol.document.statusform.inSession.value=\"2\";\r\n");
      out.write("\r\n");
      out.write("\t\ttop.mainFrame.location=\"endsession.jsp?sessionKey=");
      out.print(sessionKey);
      out.write("&contactID=");
      out.print(contactID);
      out.write("&inSession=\" + isSessionActive;\t   \r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("</HEAD>\r\n");
      out.write("\r\n");
      out.write("<body background=\"../images/bg2.gif\" onload=setfocus()>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" height=\"70%\" class=\"table\">\r\n");
      out.write(" <tr>\r\n");
      out.write("  <td width=\"90%\">\r\n");
      out.write("    <form name=\"chatform\" method=\"POST\">\r\n");
      out.write("      <textarea name=\"customerchat\" class=\"customerchat\" cols=65 rows=2 onKeyPress=\"checkEnter(event)\"></textarea>\r\n");
      out.write("      <input type=\"image\" src=\"../images/icon_ui_send_on.gif\" BORDER=\"0\" ALT=\"Send\" onclick=\"sendChat()\">\r\n");
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
      out.write("  </form>\r\n");
      out.write("  </td>\r\n");
      out.write("  <td width=\"5%\">\r\n");
      out.write("    <input type=\"image\" src=\"../images/icon_ui_print_on.gif\" BORDER=\"0\" ALT=\"Print\" onclick=\"printChat()\">\r\n");
      out.write("  </td>\r\n");
      out.write("  <td width=\"5%\">\r\n");
      out.write("    <input type=\"image\" src=\"../images/icon_ui_exit_on.gif\" BORDER=\"0\" ALT=\"Exit\" onclick=\"exitChat()\">\r\n");
      out.write("  </td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
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