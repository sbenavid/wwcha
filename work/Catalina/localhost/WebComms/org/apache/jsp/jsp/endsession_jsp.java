/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-09 16:39:18 UTC
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

public final class endsession_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("  <Body>\r\n");
      out.write("  <FORM name=\"endSession\">\r\n");
      out.write("\r\n");



   //Avaya Aura Contact Center Multimedia 
   //Copyright � 2010 Avaya Inc. All Rights Reserved

   String webServerName  = application.getInitParameter("WEBCOMMS_HOSTNAME");
   String webServerPort  = application.getInitParameter("WEBCOMMS_PORT");
   String homePath = application.getInitParameter("HOME_PATH");

   //Session close is already handled in the chatdsiplay.jsp on "onbeforeunload" of chat page.
   //no need to close te session twice.
   

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<HTML>\r\n");
      out.write("<BODY background=\"../images/bg2.gif\">\r\n");
      out.write("  \r\n");
      out.write("<BR><BR><BR>\r\n");
      out.write("\r\n");
      out.write("<p class=MsoNormal align=center style='text-align:center'><span\r\n");
      out.write("style='font-size:20.0pt;font-family:\"Comic Sans MS\"'><o:p>Your Session has now terminated.</o:p></span></p>\r\n");
      out.write("\r\n");
      out.write("<p class=MsoNormal align=center style='text-align:center'><span\r\n");
      out.write("style='font-size:15.0pt;font-family:\"Comic Sans MS\"'>Thank you for visiting us.</span></p>\r\n");
      out.write("\r\n");
      out.write("<h1 align=center><A href=javascript:top.mainFrame.location=\"http://");
      out.print(webServerName);
      out.write(':');
      out.print(webServerPort);
      out.print(homePath);
      out.write("\">Home</A></h1> \r\n");
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