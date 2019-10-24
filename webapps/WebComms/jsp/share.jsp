<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@ page import="com.nortel.applications.ccmm.ci.webservices.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page buffer="8kb" %>


<%

   //Avaya Aura Contact Center Multimedia 
   //Copyright © 2010 Avaya Inc. All Rights Reserved



   String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");
   String webServerName  = application.getInitParameter("WEBCOMMS_HOSTNAME");
   String webServerPort  = application.getInitParameter("WEBCOMMS_PORT");
   
   String webCommsUrl = "http://" + webServerName + ":" + webServerPort + "/WebComms/jsp/index.jsp";
   
%>
   
   

<HTML>

  <style type="text/css">

    .table
    {
	position: absolute; top: 10px;
	border: 0px;
    }

  </style>

<HEAD>

<script LANGUAGE="JavaScript">

  NS4 = (document.layers) ? true : false;

  function checkEnter(event)
  { 	
  
  	// if enter key pressed while in the address box,
  	// assume the customer wants to preview the page.
	
	var code = 0;
	
	if (NS4)
		code = event.which;
	else
		code = event.keyCode;
	if (code==13)
		previewUrl();
  }

  function previewUrl()
  {

    // If the customer is in an active session with an agent, load the
    // page in the large frame. Notify the agent that the customer
    // is previewing a page.

    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("You are not in an active session.");
    }
    else
    {
	if(pushform.txturl.value=="")
	{
	  // do nothing as the user has not entered a url

	}
	else
	{

	  var pushurl = pushform.txturl.value;
	  if (pushurl.indexOf("http") < 0)
	  {
		pushform.txturl.value = "http://" + pushurl;
	  }

	  // to prevent recursion, the WebComms url may not be previewed or pushed
	  var fullUrl = pushform.txturl.value;
	  fullUrl = fullUrl.toLowerCase();
	  
	  var wcUrl = parent.pushcontrol.document.pushform.webCommsUrl.value;
	  wcUrl = wcUrl.toLowerCase();
  	  
	  if(fullUrl.indexOf(wcUrl) < 0)	  
	  {
	     parent.chatwrite.document.chatform.message.value = " Customer previewed the page: " + pushform.txturl.value;
	     parent.chatwrite.document.chatform.hiddenMessage.value = pushform.txturl.value;
	     parent.chatwrite.document.chatform.type.value = "Page_Previewed_by_Customer";
	     parent.chatwrite.document.chatform.submit();
	  }
	  else
	  {
	     alert("This page cannot be pushed.");
	  }

	}
    }
  }


  function pushUrl()
  {
  
    // If the customer is in a session with the agent, push the url
    // to the agent.
	
    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("You are not in an active session.");
    }
    else
    {

	if(pushform.txturl.value=="")
	{
	  // do nothing as the user has not entered a url

	}
	else
	{

	    var pushurl = pushform.txturl.value;
	    if (pushurl.indexOf("http") < 0)
	    {
		pushform.txturl.value= "http://" + pushurl;
	    }

	    // to prevent recursion, the WebComms url may not be previewed or pushed
	    var fullUrl = pushform.txturl.value;
	    fullUrl = fullUrl.toLowerCase();
	  
	    var wcUrl = parent.pushcontrol.document.pushform.webCommsUrl.value;
	    wcUrl = wcUrl.toLowerCase();
  	  
	    if(fullUrl.indexOf(wcUrl) < 0)	  
	    {

	      // push the previewed url to an agent

	      parent.chatwrite.document.chatform.message.value = " Customer pushed the page: " + pushurl;
  	      parent.chatwrite.document.chatform.hiddenMessage.value = pushurl;
	      parent.chatwrite.document.chatform.type.value = "Page_Pushed_by_Customer";
	      parent.chatwrite.document.chatform.submit();
	    }
	    else
	    {
	      alert("This page cannot be pushed.");
	    }

	}
    }
  }


  function shareForm()
  {
  
    // Form Sharing.
    

    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("You are not in an active session.");
    }
    else
    {
	
	// push the shared form to an agent
	
	var els = parent.maincontrol.orderForm.elements; 
	var urlParam = "";

	for(var x=0; x<els.length; x++)
	{ 

		switch(els[x].type)
  		{

		   case "select-one" :

			for(indx=0; indx<els[x].length; indx++)
			{

			    if(els[x].selectedIndex == indx) 
			    {					

				urlParam = urlParam + "&" + els[x].name + "=" + els[x].options[indx].text;

			    }
			}


			break;

		   case "text":

			urlParam = urlParam + "&" + els[x].name + "=" + els[x].value;

			break;

		   case "textarea":

			urlParam = urlParam + "&" + els[x].name + "=" + els[x].value;

			break;


		   case "checkbox":

			if(els[x].checked == true)
			{
				urlParam = urlParam + "&" + els[x].name + "=true";
			}
			else
			{
				urlParam = urlParam + "&" + els[x].name + "=false";
			}

			break;

		   case "radio":

			var p = els[x].length;
			do
			{

			   if (els[x].checked == true)
			   {
				urlParam = urlParam + "&" + els[x].name + "=" + els[x].value;					
			   }
			}
			while (p);

			break;

	 	}
		
	}
	
	urlParam = "?" + urlParam.substring (1, urlParam.length);

	parent.chatwrite.document.chatform.message.value = " Customer shared the form: " + parent.maincontrol.location;
	parent.chatwrite.document.chatform.hiddenMessage.value = parent.maincontrol.location + urlParam;
	parent.chatwrite.document.chatform.type.value = "Form_Shared_by_Customer";

	parent.chatwrite.document.chatform.submit();

     }

  }

  function setfocus()
  {
     parent.chatwrite.document.chatform.customerchat.focus();
  }


  function callMe()
  {
  
    // If the customer and agent are in an active session, then allow the customer
    // to request that the agent calls them. Prompt for a telephone number and
    // notify the agent of the request.

    if(parent.statuscontrol.document.statusform.inSession.value=="0")
    {
	alert("You are not in an active session.");
    }
    else
    {

      var someText; 






      someText = prompt("Please enter your phone number for a callback:", ""); 


      if ((someText != null) && (someText.length > 0))
      {
      	 parent.chatwrite.document.chatform.message.value = " Customer requested a callback on: " + someText;
	 parent.chatwrite.document.chatform.hiddenMessage.value = someText;
	 parent.chatwrite.document.chatform.type.value = "CallMe_Request_from_Customer";
      	 parent.chatwrite.document.chatform.submit();
      }
    }

  }

</script>


</HEAD>
<BODY  bgcolor="E0E0E0" text="CC0000" onload=setfocus()>
<form name="pushform">
<input type="hidden" name="webCommsUrl" value="<%=webCommsUrl%>">
<table class="table">
 <tr>
  <td width="7%">
  Address: 
  </td>
  <td width="74%">
  <INPUT style="WIDTH: 100%; HEIGHT: 22px" size=255 name="txturl" onKeyPress="checkEnter(event)">
  </td>
  <td width="11%">

	<input type="image" src="../images/icon_ui_preview_on.gif" BORDER="0" ALT="Preview Website" onclick="previewUrl()">
	<input type="image" src="../images/icon_ui_pushpg_on.gif" border="0" ALT="Push Displayed Page" onclick="pushUrl()">
	<!-- <input type="image" src="../images/icon_ui_shform_on.gif" border="0" ALT="Share Form" onclick="shareForm()"> -->
  </td>
  <td width="1%">
  </td>
  <td width="3%">
	<input type="image" src="../images/icon_ui_tel_on.gif" BORDER="0" ALT="Call Me" onclick="callMe()">
  </td>
 </tr>
</table>
</form>

  <script language="JavaScript">

	function getQueryString() 
	{
  	   var args = new Object();
  	   // Get Query String
  	   var query = location.search.substring(1);
  	   // Split query at the comma
  	   var pairs = query.split("&");
  
  	   var counter = 0;
  
  	   // Begin loop through the querystring
  	   for(var i = 0; i < pairs.length; i++) 
	   {

    		// Look for "name=value"
    		var pos = pairs[i].indexOf('=');

    		// if not found, skip to next
    		if (pos == -1) continue;

    		// Extract the name
    		var argname = pairs[i].substring(0,pos);
    
    		// Extract the value
    		var value = pairs[i].substring(pos+1); 

    		// Store as a property
    		if (!args[argname]) 
		{
      		    args[argname] = unescape(value);
    		}
    		else 
		{
      		    args[argname] += ("&" + argname + "=" + unescape(value));
    		}
  	  }
  
  	  return args; // Return the Object
	}

	var oQS = getQueryString();

	var theurl = oQS['txturl'];

	if(theurl != undefined)
		pushform.txturl.value = theurl;


  </script>


</BODY>
</HTML>