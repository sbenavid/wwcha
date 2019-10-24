<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>

<HTML>
  <Body>
  <FORM name="endSession">

<%


   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved

   String webServerName  = application.getInitParameter("WEBCOMMS_HOSTNAME");
   String webServerPort  = application.getInitParameter("WEBCOMMS_PORT");
   String homePath = application.getInitParameter("HOME_PATH");

   //Session close is already handled in the chatdsiplay.jsp on "onbeforeunload" of chat page.
   //no need to close te session twice.
   
%>


<HTML>
<BODY background="../images/bg2.gif">
  
<BR><BR><BR>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:20.0pt;font-family:"Comic Sans MS"'><o:p>Your Session has now terminated.</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span
style='font-size:15.0pt;font-family:"Comic Sans MS"'>Thank you for visiting us.</span></p>

<h1 align=center><A href=javascript:top.mainFrame.location="http://<%=webServerName%>:<%=webServerPort%><%=homePath%>">Home</A></h1> 

</HTML>
