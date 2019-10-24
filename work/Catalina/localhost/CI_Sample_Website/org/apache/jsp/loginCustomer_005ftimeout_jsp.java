/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-14 18:37:38 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.nortel.applications.ccmm.ci.datatypes.*;
import com.nortel.applications.ccmm.ci.webservices.*;
import com.nortel.applications.ccmm.ci.datatypes.*;
import com.nortel.applications.ccmm.ci.webservices.*;

public final class loginCustomer_005ftimeout_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/menu.jsp", Long.valueOf(1421176080000L));
    _jspx_dependants.put("/header.html", Long.valueOf(1282782278000L));
  }

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
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!--\r\n");
      out.write("Avaya Aura Contact Center Multimedia \r\n");
      out.write("Copyright © 2010 Avaya Inc. All Rights Reserved\r\n");
      out.write("-->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");


    session.removeAttribute("username");
    session.removeAttribute("sessionKey");
    session.removeAttribute("clientClockError");
    
    
    String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");   
   
    // Set up the Utility Web Service URL
    
    java.net.URL ciUtilityWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIUtilityWs.asmx"); 
    
    CIUtilityWs utilityLocator = new CIUtilityWsLocator();
    CIUtilityWsSoap utilityWs = utilityLocator.getCIUtilityWsSoap( ciUtilityWsUrl);
    
    CIDateTime serverTime = utilityWs.getServerTime();
    
    long serverTimeMS = serverTime.getMilliseconds();
    

      out.write("\r\n");
      out.write("\r\n");
      out.write("<SCRIPT LANGUAGE=\"JavaScript\">\r\n");
      out.write("\r\n");
      out.write("// here we find if the client clock is incorrect and by what margin\r\n");
      out.write("// by comparing it's (UTC) millisecond value against the CCMM server's (UTC) millisecond value\r\n");
      out.write("var clientTime = new Date();\r\n");
      out.write("var localClockErrorMS = clientTime.getTime() - ");
      out.print( serverTimeMS );
      out.write(";\r\n");
      out.write("\r\n");
      out.write("//find the number of minutes difference\r\n");
      out.write("var localClockError = localClockErrorMS / ( 1000 * 60);\r\n");
      out.write("\r\n");
      out.write("//round this to a whole number\r\n");
      out.write("localClockError = Math.round(localClockError);\r\n");
      out.write("\r\n");
      out.write("// convert back to milliseconds, this value will be used to set the value\r\n");
      out.write("// of the clientClockError hidden input field in the form below\r\n");
      out.write("// this field is then read by loginCustomer_WSClient.jsp and stored in a session variable\r\n");
      out.write("localClockError = localClockError * ( 1000 * 60 );\r\n");
      out.write("\r\n");
      out.write("// function to validate the user's input\r\n");
      out.write("\r\n");
      out.write("function validateLogin(form)\r\n");
      out.write("{\r\n");
      out.write("   if (form.username.value.length == 0)\r\n");
      out.write("   {\r\n");
      out.write("      alert(\"Please enter a username\");\r\n");
      out.write("      return false;\r\n");
      out.write("   }\r\n");
      out.write("   if (form.password.value.length == 0)\r\n");
      out.write("   {\r\n");
      out.write("      alert(\"Please enter a password\");\r\n");
      out.write("      return false;\r\n");
      out.write("   }\r\n");
      out.write("   return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</SCRIPT>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("        <title>CCMM CI Sample Web Site</title>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("\r\n");
      out.write("    <!-- Set up the Main Table for the Web Page -->\r\n");
      out.write("    <table width=\"100%\" border=\"0\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        \r\n");
      out.write("        <td height=\"80\" colspan=\"3\">\r\n");
      out.write("        ");
      out.write("<!--\n");
      out.write("Avaya Aura Contact Center Multimedia \n");
      out.write("Copyright © 2010 Avaya Inc. All Rights Reserved\n");
      out.write("-->\n");
      out.write("\n");
      out.write("<link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("<table width=\"100%\" bgcolor=\"#FFFFFF\">\n");
      out.write("<tr>\n");
      out.write("<td>\n");
      out.write("&nbsp\n");
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("<tr>\n");
      out.write("<td width=\"10\" >\n");
      out.write("&nbsp\n");
      out.write("</td>\n");
      out.write("<td align=\"right\" width=\"139\" >\n");
      out.write("<img src=\"images/avayaLogo.gif\" width=\"139\" height=\"40\">\n");
      out.write("</td>\n");
      out.write("<td width=\"41\" >\n");
      out.write("&nbsp\n");
      out.write("</td>\n");
      out.write("<td align=\"center\" >\n");
      out.write("<!--<img src=\"images/title_img.gif\" width=\"590\" height=\"50\">-->\n");
      out.write("<font class=\"title\">Customer Interface Sample Web Site</font>\n");
      out.write("</td>\n");
      out.write("<td width=\"180\" >\n");
      out.write("<td></td>\n");
      out.write("&nbsp\n");
      out.write("</td>\n");
      out.write("</tr>\n");
      out.write("\n");
      out.write("\n");
      out.write("</table>\n");
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("    <table width=\"800\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td width=\"200\" height=\"900\">            \r\n");
      out.write("        ");
      out.write("<!--\r\n");
      out.write("Avaya Aura Contact Center Multimedia \r\n");
      out.write("Copyright © 2010 Avaya Inc. All Rights Reserved\r\n");
      out.write("-->\r\n");
      out.write("    \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");


    // ensure we are decoding the request parameters as UTF-8
    request.setCharacterEncoding("UTF-8");
    
    String ccmmname = application.getInitParameter("CCMM_HOSTNAME");
    String chatSkillsetName = application.getInitParameter("WEBCOMMS_SKILLSET");
   
    String inService = "0"; // Default skillset to being out of service.
    
    // Skillset web service URL
    java.net.URL SkillsetUrl = new java.net.URL("http://" + ccmmname + "/ccmmwebservices/CISkillsetWs.asmx"); 
    CISkillsetWs skillsetLocatorObj = new CISkillsetWsLocator();
    CISkillsetWsSoap skillsetWsObj = skillsetLocatorObj.getCISkillsetWsSoap( SkillsetUrl );
        
    // check if the Text Chat Skillset is in Service
    if( skillsetWsObj.isSkillsetNameInService(chatSkillsetName))
    {
        // Display the webchat icon on the main menu:
        inService = "1";
    }
    else //Skillset is not in service, display a message to the user
    {
        // Offer alternative options to cusomter - Web Chat is unavailable...
        // Example, Offer the customer the opertunity to send an email.
    }


      out.write("    \r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("<script LANGUAGE=\"JavaScript\">    \r\n");
      out.write("    // Launch a web-chat prompt\r\n");
      out.write("    \r\n");
      out.write("    var anonymousChatLaunched = \"0\";\r\n");
      out.write("    \r\n");
      out.write("    function launchWebchatQuestion()\r\n");
      out.write("    {\r\n");
      out.write("        if (\"0\" == anonymousChatLaunched)\r\n");
      out.write("        {\r\n");
      out.write("            // Check if the csutomer has alreday requested a web chat session since the timer began...\r\n");
      out.write("            window.open('OfferWebChat.jsp', 'WebChat', 'width=430, height=232, resizable=0, status=0, toolbar=0, menubar=0');\r\n");
      out.write("        }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    // Launch an anonymous web chat session\r\n");
      out.write("    function launchWebChatSession()\r\n");
      out.write("    {\r\n");
      out.write("        window.open('WebChatLogin.jsp', 'WebChat', 'width=430, height=400, resizable=0');\r\n");
      out.write("        anonymousChatLaunched = \"1\";\r\n");
      out.write("    }\r\n");
      out.write("    \r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<table width=\"100%\" height=\"100%\" cellspacing=\"10\" cellpadding=\"10\" bgcolor=\"#C0C0C0\">\r\n");
      out.write("<tr>\r\n");
      out.write("<td valign=\"top\">\r\n");
      out.write("\r\n");
 if( session.getAttribute("sessionKey") == null ) { 
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table cellspacing=\"1\">\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td class=\"infotext\">Status</td>\r\n");
      out.write("    <td class=\"infotext\"> : </td>\r\n");
      out.write("    <td class=\"infotext\"><font color=\"#EA0437\">Logged Off</font></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td class=\"infotext\">&nbsp;</td><td></td><td></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<table cellspacing=\"1\">\r\n");
      out.write("    <font color=\"#003399\">\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <br>\r\n");
      out.write("        <img src=\"images/home.gif\" alt=\"Home\" onclick=\"location='home.jsp'\">\r\n");
      out.write("        <br>\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/loginCustomer.gif\" alt=\"Login Customer\" onclick=\"location='loginCustomer.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/registerNewCustomer.gif\" alt=\"Register New Customer\" onclick=\"location='registerNewCustomer.jsp'\">\r\n");
      out.write("        <br>\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    ");
 if(inService.equals("1")) { 
      out.write("\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <a href=\"javascript:void(0)\" onclick=\"launchWebChatSession();\"><img title=\"Web Chat\" alt=\"Chat icon.\" border=\"0\" height=\"50\" width=\"50\" src=\"img/webchat.gif\" /></a>\r\n");
      out.write("        <br>\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>    \r\n");
      out.write("    \r\n");
      out.write("    <script LANGUAGE=\"JavaScript\">\r\n");
      out.write("        \r\n");
      out.write("        // *** Offer Web Chat session ***\r\n");
      out.write("        // Check if the skillset is in service, offer the customer a web chat session.\r\n");
      out.write("        // In this sample, the offer window is triggered by a timer mechanism e.g. after 5 seconds.\r\n");
      out.write("        // Customer must be logged out:\r\n");
      out.write("        \r\n");
      out.write("        if(location.href.indexOf(\"home.jsp\") > -1 || location.href.indexOf(\"registerNewCustomer.jsp\") > -1 || location.href.indexOf(\"passwordReminder.jsp\") > -1 )\r\n");
      out.write("        {\r\n");
      out.write("            // Do not offer anonymous chat if the Customer is registering a new customer,\r\n");
      out.write("            // requesting password reminder OR navigating to the main home location...\r\n");
      out.write("        }\r\n");
      out.write("        else\r\n");
      out.write("        {\r\n");
      out.write("            // Offer chat session after 5 seconds... Interval can be re-set here (milseconds)\r\n");
      out.write("            setTimeout('launchWebchatQuestion()', 5000);\r\n");
      out.write("        }\r\n");
      out.write("        \r\n");
      out.write("    </script>\r\n");
      out.write("    \r\n");
      out.write("    ");
 } 
      out.write(" <!-- Offer Alternative options to customer -->\r\n");
      out.write("    <tr><td></td></tr>\r\n");
      out.write("    </font>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<br><br>\r\n");
      out.write("\r\n");
 } else { 
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<table cellspacing=\"1\">\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td class=\"infotext\">Status</td>\r\n");
      out.write("    <td class=\"infotext\"> : </td>\r\n");
      out.write("    <td class=\"infotext\"><font color=\"#12AD2B\">Logged In</font></td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td class=\"infotext\">User</td>\r\n");
      out.write("    <td class=\"infotext\">: </td>\r\n");
      out.write("    <td><input type=\"text\"  size=\"15\" readonly=\"true\" class=\"username\" value=\"");
      out.print( session.getAttribute("username"));
      out.write("\"></td>        \r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<table cellspacing=\"1\">\r\n");
      out.write("<font color=\"#003399\">\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <br>\r\n");
      out.write("        <img src=\"images/home.gif\" alt=\"Home\" onclick=\"location='home.jsp'\">\r\n");
      out.write("        <br>\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/logoffCustomer.gif\" alt=\"Logoff Customer\" onclick=\"location='logoffCustomer.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/readCustomerDetails.gif\" alt=\"Display Customer Details\" onclick=\"location='readCustomerDetails_WSClient.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/updateCustLogin.gif\" alt=\"Update Customer Login Credentials\" onclick=\"location='updateCustomerLogin.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/readCustomerContactHistory.gif\" alt=\"Read Customer Contact History\" onclick=\"location='readCustContactHist_WSClient.jsp?pageControl=last'\">\r\n");
      out.write("        <br>\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/requestTextChat.gif\" alt=\"Request Text Chat\" onclick=\"location='requestTextChat.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/requestScheduledCallback.gif\" alt=\"Request Scheduled Callback\" onclick=\"location='requestScheduledCallback.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/requestImmediateCallback.gif\" alt=\"Request Immediate Callback\" onclick=\"location='requestImmediateCallback.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("    <td>\r\n");
      out.write("        <img src=\"images/submitHTMLForm.gif\" alt=\"Submit HTML Form\" onclick=\"location='submitHTMLForm.jsp'\">\r\n");
      out.write("    </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr><td></td></tr>    \r\n");
      out.write("</font>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
 } 
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</font>\r\n");
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("</table>");
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("        <td width=\"10\"></td>\r\n");
      out.write("\r\n");
      out.write("        <td width=\"590\" height=\"900\" valign=\"top\">  \r\n");
      out.write("            \r\n");
      out.write("            <form name=\"loginform\" onsubmit=\"return validateLogin(this)\" method=\"POST\" action=\"loginCustomer_WSClient.jsp\">\r\n");
      out.write("            \r\n");
      out.write("            <!-- this hidden parameter will force logoff a customer if their session has timed out -->\r\n");
      out.write("            <!-- the logoff is done in the loginCustomer_WSClient.jsp page -->\r\n");
      out.write("            <input type=\"hidden\" name=\"forceLogoff\" value=\"true\">  \r\n");
      out.write("            \r\n");
      out.write("            <script language=\"javascript\">\r\n");
      out.write("            \r\n");
      out.write("            \tdocument.write(\"<input type='hidden' name='clientClockError' value='\" + localClockError + \"'>\");\r\n");
      out.write("                        \r\n");
      out.write("            </script>  \r\n");
      out.write("                \r\n");
      out.write("            <table cellspacing=\"5\">            \r\n");
      out.write("            <tr>\r\n");
      out.write("                <td height = \"50\" class=\"bold\"><font color=\"red\">Customer Session has Timed Out<br>Please Login Again</font></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("            <table cellspacing=\"5\">            \r\n");
      out.write("            <tr>\r\n");
      out.write("                <td class=\"formlabel\">Username</td>\r\n");
      out.write("                <td><input name=\"username\" size=\"20\" maxlength=\"50\">&nbsp;<font color=\"red\">*</font></td>                \r\n");
      out.write("             </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td class=\"formlabel\">Password</td>\r\n");
      out.write("                <td><input type=password name=\"password\" size=\"20\" maxlength=\"50\">&nbsp;<font color=\"red\">*</font></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td><br><br></td>\r\n");
      out.write("                <td><input type=submit value=\"Login\">\r\n");
      out.write("            </tr>            \r\n");
      out.write("            </table>            \r\n");
      out.write("            </form>            \r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("        \r\n");
      out.write("    </table>  \r\n");
      out.write("    \r\n");
      out.write("    </body>\r\n");
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
