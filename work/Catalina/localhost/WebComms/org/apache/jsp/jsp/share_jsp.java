/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2019-10-09 16:36:51 UTC
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

public final class share_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\r\n");


   //Avaya Aura Contact Center Multimedia 
   //Copyright � 2010 Avaya Inc. All Rights Reserved



   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");
   String webServerName  = application.getInitParameter("WEBCOMMS_HOSTNAME");
   String webServerPort  = application.getInitParameter("WEBCOMMS_PORT");
   
   String webCommsUrl = "http://" + webServerName + ":" + webServerPort + "/WebComms/jsp/index.jsp";
   

      out.write("\r\n");
      out.write("   \r\n");
      out.write("   \r\n");
      out.write("\r\n");
      out.write("<HTML>\r\n");
      out.write("\r\n");
      out.write("  <style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("    .table\r\n");
      out.write("    {\r\n");
      out.write("\tposition: absolute; top: 10px;\r\n");
      out.write("\tborder: 0px;\r\n");
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
      out.write("  \r\n");
      out.write("  \t// if enter key pressed while in the address box,\r\n");
      out.write("  \t// assume the customer wants to preview the page.\r\n");
      out.write("\t\r\n");
      out.write("\tvar code = 0;\r\n");
      out.write("\t\r\n");
      out.write("\tif (NS4)\r\n");
      out.write("\t\tcode = event.which;\r\n");
      out.write("\telse\r\n");
      out.write("\t\tcode = event.keyCode;\r\n");
      out.write("\tif (code==13)\r\n");
      out.write("\t\tpreviewUrl();\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  function previewUrl()\r\n");
      out.write("  {\r\n");
      out.write("\r\n");
      out.write("    // If the customer is in an active session with an agent, load the\r\n");
      out.write("    // page in the large frame. Notify the agent that the customer\r\n");
      out.write("    // is previewing a page.\r\n");
      out.write("\r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"You are not in an active session.\");\r\n");
      out.write("    }\r\n");
      out.write("    else\r\n");
      out.write("    {\r\n");
      out.write("\tif(pushform.txturl.value==\"\")\r\n");
      out.write("\t{\r\n");
      out.write("\t  // do nothing as the user has not entered a url\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("\telse\r\n");
      out.write("\t{\r\n");
      out.write("\r\n");
      out.write("\t  var pushurl = pushform.txturl.value;\r\n");
      out.write("\t  if (pushurl.indexOf(\"http\") < 0)\r\n");
      out.write("\t  {\r\n");
      out.write("\t\tpushform.txturl.value = \"http://\" + pushurl;\r\n");
      out.write("\t  }\r\n");
      out.write("\r\n");
      out.write("\t  // to prevent recursion, the WebComms url may not be previewed or pushed\r\n");
      out.write("\t  var fullUrl = pushform.txturl.value;\r\n");
      out.write("\t  fullUrl = fullUrl.toLowerCase();\r\n");
      out.write("\t  \r\n");
      out.write("\t  var wcUrl = parent.pushcontrol.document.pushform.webCommsUrl.value;\r\n");
      out.write("\t  wcUrl = wcUrl.toLowerCase();\r\n");
      out.write("  \t  \r\n");
      out.write("\t  if(fullUrl.indexOf(wcUrl) < 0)\t  \r\n");
      out.write("\t  {\r\n");
      out.write("\t     parent.chatwrite.document.chatform.message.value = \" Customer previewed the page: \" + pushform.txturl.value;\r\n");
      out.write("\t     parent.chatwrite.document.chatform.hiddenMessage.value = pushform.txturl.value;\r\n");
      out.write("\t     parent.chatwrite.document.chatform.type.value = \"Page_Previewed_by_Customer\";\r\n");
      out.write("\t     parent.chatwrite.document.chatform.submit();\r\n");
      out.write("\t  }\r\n");
      out.write("\t  else\r\n");
      out.write("\t  {\r\n");
      out.write("\t     alert(\"This page cannot be pushed.\");\r\n");
      out.write("\t  }\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function pushUrl()\r\n");
      out.write("  {\r\n");
      out.write("  \r\n");
      out.write("    // If the customer is in a session with the agent, push the url\r\n");
      out.write("    // to the agent.\r\n");
      out.write("\t\r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"You are not in an active session.\");\r\n");
      out.write("    }\r\n");
      out.write("    else\r\n");
      out.write("    {\r\n");
      out.write("\r\n");
      out.write("\tif(pushform.txturl.value==\"\")\r\n");
      out.write("\t{\r\n");
      out.write("\t  // do nothing as the user has not entered a url\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("\telse\r\n");
      out.write("\t{\r\n");
      out.write("\r\n");
      out.write("\t    var pushurl = pushform.txturl.value;\r\n");
      out.write("\t    if (pushurl.indexOf(\"http\") < 0)\r\n");
      out.write("\t    {\r\n");
      out.write("\t\tpushform.txturl.value= \"http://\" + pushurl;\r\n");
      out.write("\t    }\r\n");
      out.write("\r\n");
      out.write("\t    // to prevent recursion, the WebComms url may not be previewed or pushed\r\n");
      out.write("\t    var fullUrl = pushform.txturl.value;\r\n");
      out.write("\t    fullUrl = fullUrl.toLowerCase();\r\n");
      out.write("\t  \r\n");
      out.write("\t    var wcUrl = parent.pushcontrol.document.pushform.webCommsUrl.value;\r\n");
      out.write("\t    wcUrl = wcUrl.toLowerCase();\r\n");
      out.write("  \t  \r\n");
      out.write("\t    if(fullUrl.indexOf(wcUrl) < 0)\t  \r\n");
      out.write("\t    {\r\n");
      out.write("\r\n");
      out.write("\t      // push the previewed url to an agent\r\n");
      out.write("\r\n");
      out.write("\t      parent.chatwrite.document.chatform.message.value = \" Customer pushed the page: \" + pushurl;\r\n");
      out.write("  \t      parent.chatwrite.document.chatform.hiddenMessage.value = pushurl;\r\n");
      out.write("\t      parent.chatwrite.document.chatform.type.value = \"Page_Pushed_by_Customer\";\r\n");
      out.write("\t      parent.chatwrite.document.chatform.submit();\r\n");
      out.write("\t    }\r\n");
      out.write("\t    else\r\n");
      out.write("\t    {\r\n");
      out.write("\t      alert(\"This page cannot be pushed.\");\r\n");
      out.write("\t    }\r\n");
      out.write("\r\n");
      out.write("\t}\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function shareForm()\r\n");
      out.write("  {\r\n");
      out.write("  \r\n");
      out.write("    // Form Sharing.\r\n");
      out.write("    \r\n");
      out.write("\r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"You are not in an active session.\");\r\n");
      out.write("    }\r\n");
      out.write("    else\r\n");
      out.write("    {\r\n");
      out.write("\t\r\n");
      out.write("\t// push the shared form to an agent\r\n");
      out.write("\t\r\n");
      out.write("\tvar els = parent.maincontrol.orderForm.elements; \r\n");
      out.write("\tvar urlParam = \"\";\r\n");
      out.write("\r\n");
      out.write("\tfor(var x=0; x<els.length; x++)\r\n");
      out.write("\t{ \r\n");
      out.write("\r\n");
      out.write("\t\tswitch(els[x].type)\r\n");
      out.write("  \t\t{\r\n");
      out.write("\r\n");
      out.write("\t\t   case \"select-one\" :\r\n");
      out.write("\r\n");
      out.write("\t\t\tfor(indx=0; indx<els[x].length; indx++)\r\n");
      out.write("\t\t\t{\r\n");
      out.write("\r\n");
      out.write("\t\t\t    if(els[x].selectedIndex == indx) \r\n");
      out.write("\t\t\t    {\t\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t\turlParam = urlParam + \"&\" + els[x].name + \"=\" + els[x].options[indx].text;\r\n");
      out.write("\r\n");
      out.write("\t\t\t    }\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\tbreak;\r\n");
      out.write("\r\n");
      out.write("\t\t   case \"text\":\r\n");
      out.write("\r\n");
      out.write("\t\t\turlParam = urlParam + \"&\" + els[x].name + \"=\" + els[x].value;\r\n");
      out.write("\r\n");
      out.write("\t\t\tbreak;\r\n");
      out.write("\r\n");
      out.write("\t\t   case \"textarea\":\r\n");
      out.write("\r\n");
      out.write("\t\t\turlParam = urlParam + \"&\" + els[x].name + \"=\" + els[x].value;\r\n");
      out.write("\r\n");
      out.write("\t\t\tbreak;\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t   case \"checkbox\":\r\n");
      out.write("\r\n");
      out.write("\t\t\tif(els[x].checked == true)\r\n");
      out.write("\t\t\t{\r\n");
      out.write("\t\t\t\turlParam = urlParam + \"&\" + els[x].name + \"=true\";\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\telse\r\n");
      out.write("\t\t\t{\r\n");
      out.write("\t\t\t\turlParam = urlParam + \"&\" + els[x].name + \"=false\";\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\r\n");
      out.write("\t\t\tbreak;\r\n");
      out.write("\r\n");
      out.write("\t\t   case \"radio\":\r\n");
      out.write("\r\n");
      out.write("\t\t\tvar p = els[x].length;\r\n");
      out.write("\t\t\tdo\r\n");
      out.write("\t\t\t{\r\n");
      out.write("\r\n");
      out.write("\t\t\t   if (els[x].checked == true)\r\n");
      out.write("\t\t\t   {\r\n");
      out.write("\t\t\t\turlParam = urlParam + \"&\" + els[x].name + \"=\" + els[x].value;\t\t\t\t\t\r\n");
      out.write("\t\t\t   }\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\twhile (p);\r\n");
      out.write("\r\n");
      out.write("\t\t\tbreak;\r\n");
      out.write("\r\n");
      out.write("\t \t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\turlParam = \"?\" + urlParam.substring (1, urlParam.length);\r\n");
      out.write("\r\n");
      out.write("\tparent.chatwrite.document.chatform.message.value = \" Customer shared the form: \" + parent.maincontrol.location;\r\n");
      out.write("\tparent.chatwrite.document.chatform.hiddenMessage.value = parent.maincontrol.location + urlParam;\r\n");
      out.write("\tparent.chatwrite.document.chatform.type.value = \"Form_Shared_by_Customer\";\r\n");
      out.write("\r\n");
      out.write("\tparent.chatwrite.document.chatform.submit();\r\n");
      out.write("\r\n");
      out.write("     }\r\n");
      out.write("\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("  function setfocus()\r\n");
      out.write("  {\r\n");
      out.write("     parent.chatwrite.document.chatform.customerchat.focus();\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  function callMe()\r\n");
      out.write("  {\r\n");
      out.write("  \r\n");
      out.write("    // If the customer and agent are in an active session, then allow the customer\r\n");
      out.write("    // to request that the agent calls them. Prompt for a telephone number and\r\n");
      out.write("    // notify the agent of the request.\r\n");
      out.write("\r\n");
      out.write("    if(parent.statuscontrol.document.statusform.inSession.value==\"0\")\r\n");
      out.write("    {\r\n");
      out.write("\talert(\"You are not in an active session.\");\r\n");
      out.write("    }\r\n");
      out.write("    else\r\n");
      out.write("    {\r\n");
      out.write("\r\n");
      out.write("      var someText; \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      someText = prompt(\"Please enter your phone number for a callback:\", \"\"); \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      if ((someText != null) && (someText.length > 0))\r\n");
      out.write("      {\r\n");
      out.write("      \t parent.chatwrite.document.chatform.message.value = \" Customer requested a callback on: \" + someText;\r\n");
      out.write("\t parent.chatwrite.document.chatform.hiddenMessage.value = someText;\r\n");
      out.write("\t parent.chatwrite.document.chatform.type.value = \"CallMe_Request_from_Customer\";\r\n");
      out.write("      \t parent.chatwrite.document.chatform.submit();\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("  }\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</HEAD>\r\n");
      out.write("<BODY  bgcolor=\"E0E0E0\" text=\"CC0000\" onload=setfocus()>\r\n");
      out.write("<form name=\"pushform\">\r\n");
      out.write("<input type=\"hidden\" name=\"webCommsUrl\" value=\"");
      out.print(webCommsUrl);
      out.write("\">\r\n");
      out.write("<table class=\"table\">\r\n");
      out.write(" <tr>\r\n");
      out.write("  <td width=\"7%\">\r\n");
      out.write("  Address: \r\n");
      out.write("  </td>\r\n");
      out.write("  <td width=\"74%\">\r\n");
      out.write("  <INPUT style=\"WIDTH: 100%; HEIGHT: 22px\" size=255 name=\"txturl\" onKeyPress=\"checkEnter(event)\">\r\n");
      out.write("  </td>\r\n");
      out.write("  <td width=\"11%\">\r\n");
      out.write("\r\n");
      out.write("\t<input type=\"image\" src=\"../images/icon_ui_preview_on.gif\" BORDER=\"0\" ALT=\"Preview Website\" onclick=\"previewUrl()\">\r\n");
      out.write("\t<input type=\"image\" src=\"../images/icon_ui_pushpg_on.gif\" border=\"0\" ALT=\"Push Displayed Page\" onclick=\"pushUrl()\">\r\n");
      out.write("\t<!-- <input type=\"image\" src=\"../images/icon_ui_shform_on.gif\" border=\"0\" ALT=\"Share Form\" onclick=\"shareForm()\"> -->\r\n");
      out.write("  </td>\r\n");
      out.write("  <td width=\"1%\">\r\n");
      out.write("  </td>\r\n");
      out.write("  <td width=\"3%\">\r\n");
      out.write("\t<input type=\"image\" src=\"../images/icon_ui_tel_on.gif\" BORDER=\"0\" ALT=\"Call Me\" onclick=\"callMe()\">\r\n");
      out.write("  </td>\r\n");
      out.write(" </tr>\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      out.write("  <script language=\"JavaScript\">\r\n");
      out.write("\r\n");
      out.write("\tfunction getQueryString() \r\n");
      out.write("\t{\r\n");
      out.write("  \t   var args = new Object();\r\n");
      out.write("  \t   // Get Query String\r\n");
      out.write("  \t   var query = location.search.substring(1);\r\n");
      out.write("  \t   // Split query at the comma\r\n");
      out.write("  \t   var pairs = query.split(\"&\");\r\n");
      out.write("  \r\n");
      out.write("  \t   var counter = 0;\r\n");
      out.write("  \r\n");
      out.write("  \t   // Begin loop through the querystring\r\n");
      out.write("  \t   for(var i = 0; i < pairs.length; i++) \r\n");
      out.write("\t   {\r\n");
      out.write("\r\n");
      out.write("    \t\t// Look for \"name=value\"\r\n");
      out.write("    \t\tvar pos = pairs[i].indexOf('=');\r\n");
      out.write("\r\n");
      out.write("    \t\t// if not found, skip to next\r\n");
      out.write("    \t\tif (pos == -1) continue;\r\n");
      out.write("\r\n");
      out.write("    \t\t// Extract the name\r\n");
      out.write("    \t\tvar argname = pairs[i].substring(0,pos);\r\n");
      out.write("    \r\n");
      out.write("    \t\t// Extract the value\r\n");
      out.write("    \t\tvar value = pairs[i].substring(pos+1); \r\n");
      out.write("\r\n");
      out.write("    \t\t// Store as a property\r\n");
      out.write("    \t\tif (!args[argname]) \r\n");
      out.write("\t\t{\r\n");
      out.write("      \t\t    args[argname] = unescape(value);\r\n");
      out.write("    \t\t}\r\n");
      out.write("    \t\telse \r\n");
      out.write("\t\t{\r\n");
      out.write("      \t\t    args[argname] += (\"&\" + argname + \"=\" + unescape(value));\r\n");
      out.write("    \t\t}\r\n");
      out.write("  \t  }\r\n");
      out.write("  \r\n");
      out.write("  \t  return args; // Return the Object\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\tvar oQS = getQueryString();\r\n");
      out.write("\r\n");
      out.write("\tvar theurl = oQS['txturl'];\r\n");
      out.write("\r\n");
      out.write("\tif(theurl != undefined)\r\n");
      out.write("\t\tpushform.txturl.value = theurl;\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</BODY>\r\n");
      out.write("</HTML>");
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
