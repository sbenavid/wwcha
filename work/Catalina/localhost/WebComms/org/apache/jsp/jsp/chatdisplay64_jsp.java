/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-15 19:42:33 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;

public final class chatdisplay64_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  public java.lang.String getServletInfo() {
    return "Chat";
  }

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
      out.write("  <style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("    .textarea\r\n");
      out.write("    {\r\n");
      out.write("\tcolor: ffffff;\r\n");
      out.write("\tborder: 0px;\r\n");
      out.write("\tbackground-color:transparent;\r\n");
      out.write("\toverflow:auto;\r\n");
      out.write("    }\r\n");
      out.write("  </style>\r\n");
      out.write("\r\n");

   //Avaya Aura Contact Center Multimedia 
   //Copyright � 2014 Avaya Inc. All Rights Reserved
   
   // This page contains an embedded form to manage the reaction
   // to browser close events i.e. abandon queuing the chat request 
   // to an agent if the customer is still holding or send a disconnect 
   // message to the agent if active in a session.


   String 		sessionKey;
   String 		contactID;

   request.setCharacterEncoding("utf-8");
   sessionKey=request.getParameter("sessionKey");
   contactID=request.getParameter("contactID");


      out.write("\r\n");
      out.write("\r\n");
      out.write("<HEAD>\r\n");
      out.write("\r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("\tfunction handleOnClose()\r\n");
      out.write("\t{\r\n");
      out.write("\t    exitform.inSession.value = parent.statuscontrol.document.statusform.inSession.value;    \r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("    </script>\r\n");
      out.write("\r\n");
      out.write("</HEAD>\r\n");
      out.write("\r\n");
      out.write("<BODY onbeforeunload=\"handleOnClose()\">\r\n");
      out.write("    \r\n");
      out.write("    <form name=\"chatform\" method=\"POST\">\r\n");
      out.write("                \r\n");
      out.write("        <table id=\"displayChat\" class=\"chat_window\" width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td width=\"100%\" id=\"webchat_display\">\r\n");
      out.write("\r\n");
      out.write("                        <!-- Chat History Area -->\r\n");
      out.write("                        <table cellSpacing=\"0\" cellPadding=\"0\" border=\"0\"  width=\"100%\" height=\"100%\">  \r\n");
      out.write("\r\n");
      out.write("                                <tr>\r\n");
      out.write("                                        <td valign=\"top\" style=\"padding-left:20px;padding-right:20px;\" >\r\n");
      out.write("                                                <table id=\"\" valign=\"top\" class=\"input_fields\" height=\"100%\" width=\"100%\" border=\"0\">\r\n");
      out.write("                                                        <tr>\r\n");
      out.write("                                                            <td colspan=\"2\" align=\"center\" valign=\"top\">\r\n");
      out.write("                                                                <div align=\"left\" id=\"chatterbox\" name=\"history\" class=\"webchat_history\"><br></br>Esperando la conexion de un agente...</div>\r\n");
      out.write("                                                            </td> \r\n");
      out.write("                                                        </tr>\r\n");
      out.write("                                                </table>\r\n");
      out.write("                                        </td>\r\n");
      out.write("                                </tr>\r\n");
      out.write("\r\n");
      out.write("                        </table>\r\n");
      out.write("                        <!-- End Chat History Area -->\r\n");
      out.write("                </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("        </table>\r\n");
      out.write("                \r\n");
      out.write("    </form>\r\n");
      out.write("    \r\n");
      out.write("<form name=\"exitform\" method=\"POST\" action=\"exitFormImpl64.jsp\">\r\n");
      out.write("\t<INPUT TYPE=\"hidden\" NAME=\"sessionKey\" VALUE=\"");
      out.print(sessionKey);
      out.write("\">\r\n");
      out.write("\t<INPUT TYPE=\"hidden\" NAME=\"contactID\" VALUE=\"");
      out.print(contactID);
      out.write("\">\r\n");
      out.write("\t<INPUT TYPE=\"hidden\" NAME=\"inSession\" VALUE=\"0\">\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      out.write("</BODY>\r\n");
      out.write("\r\n");
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