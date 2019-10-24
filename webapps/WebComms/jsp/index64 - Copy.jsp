<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>
<%@ page info="Chat" %>


<HTML>
 <HEAD>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <title>Sample Web Chat</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    
    <script type="text/javascript"> 
    var elementID;

    // Resize the window to account for advert area & webchat history
    function onLoadDo()
    {
            //	On window load resize
            resizeWindow(1100, 1000, 1000, 692, 633, 606, 0);
    }

    //	Resize pop-up according to browser used, and by possible extending length
    function resizeWindow(ffPixelWidth, crPixelWidth, iePixelWidth, ffPixelLength, crPixelLength, iePixelLength, extendLength)
    {
            if (/Firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent))
                    window.resizeTo(ffPixelWidth, ffPixelLength + extendLength);	//	Firefox
            else if(navigator.userAgent.indexOf("Chrome") != -1)
                    window.resizeTo(crPixelWidth, crPixelLength + extendLength);	//	Chrome
            else if(navigator.appName == "Microsoft Internet Explorer")
            {
                    extendLength -= extendLength/14;
                    window.resizeTo(iePixelWidth, iePixelLength + extendLength);	//	IE
            }
            else 
                    window.resizeTo(iePixelWidth, iePixelLength + extendLength);	//	Resize others as of IE
    }

    // Called by chat frameset to close the chat window when the agent is finished
    function closeChatWindow()
    {
            //	Exit the chat window
            window.close();
    }

    </script>        
        
 </HEAD>
   
  <FORM name=hiddenForm>

<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright � 2014 Avaya Inc. All Rights Reserved


	String 		sessionKey;
	String 		contactID;
        String          telnumber;

	String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

	request.setCharacterEncoding("utf-8");
	sessionKey=request.getParameter("sessionKey");
	contactID=request.getParameter("contactID");
        telnumber=request.getParameter("telnumber");

	// create the session based on passed in session and contact ID's
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

 <FRAMESET onload="Javascript:onLoadDo()" ROWS="10%, 62%, 20%, 8%, 0%, 0%" border="0">

	<FRAME SRC="banner.jsp" name="banner">
        <FRAMESET COLS="40%,60%" border="0">
        	<FRAME SRC="chatdisplay64.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="chatdisplay">
                <FRAME SRC="onhold64.jsp" name="maincontrol">
        </FRAMESET>
 	<FRAMESET COLS="24%,76%" border="0">
		<FRAME SRC="status64.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="statuscontrol" scrolling=none>
                    <FRAME SRC="chatwrite64.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>&telnumber=<%=telnumber%>" name="chatwrite">
	</FRAMESET>
        <FRAME SRC="footer.jsp" name="footer">
	<FRAME SRC="hidden64.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="wcControl"> <!-- Refreshes every 3 seconds to update chat history and agent messages -->
	<FRAME SRC="heartbeat.jsp?sessionKey=<%=sessionKey%>&contactID=<%=contactID%>" name="wcHeartbeat"> <!-- Session heartbeat. Runs every 30 seconds -->

 </FRAMESET>

 </FORM>
       
</HTML>
