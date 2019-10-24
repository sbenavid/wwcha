<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>
<%@ page info="Chat" %>


<HTML>
 <HEAD>
   <TITLE>Avaya Aura Contact Center</TITLE>
 </HEAD>



  <FORM name=hiddenForm>

<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved


	String 		sessionKey;
	String 		contactID;

	String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

	request.setCharacterEncoding("utf-8");
	sessionKey=request.getParameter("sessionKey");
	contactID=request.getParameter("contactID");


	// create the session 

	try
   	{

		java.net.URL ciWebCommsWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CIWebCommsWs.asmx"); 

		CIWebCommsWs webCommsWsLocator = new CIWebCommsWsLocator();
		CIWebCommsWsSoap webCommsWs = webCommsWsLocator.getCIWebCommsWsSoap( ciWebCommsWsUrl );

		long result = webCommsWs.createWebCommsSession(new Long(contactID).longValue(), sessionKey);    

	}
   	catch(Exception e)
   	{
	     // response.sendRedirect("closed.jsp"); 	
	}



%>


 <FRAMESET ROWS="11%, 1%, 50%, 1%, 21%, 1%, 14%, 1%, 0%, 0%" border="0">

	<FRAME SRC="share.jsp" name="pushcontrol">
	<frame src="sep.jsp" >
	<FRAME SRC="onhold.jsp" name="maincontrol">
	<FRAME SRC="sep.jsp" >
	<FRAME SRC="chatdisplay.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="chatdisplay">
	<FRAME SRC="sep.jsp" >

 	<FRAMESET COLS="23.5%, 0.5%, 76%" border="0">

		<FRAME SRC="status.jsp" name="statuscontrol" scrolling=none>
		<frame src="sep.jsp" >
		<FRAME SRC="chatwrite.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="chatwrite">
	</FRAMESET>
	
	<FRAME SRC="sep.jsp" >

	<FRAME SRC="hidden.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="wcControl">
	<FRAME SRC="heartbeat.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="wcHeartbeat">

 </FRAMESET>

 </FORM>

</HTML>


