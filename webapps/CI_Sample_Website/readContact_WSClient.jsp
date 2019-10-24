<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%@include file="sessiontimeout.jsp"%>

<script language="javascript">

//checks if a digit is less than 10 and if so prepends a "0"
function doubleDigits(i)
{
  if (i<10) 
  {
     i="0" + i;
  }
  
  return i;
}


//this function will return times relative to the local time settings
function getLocalTime(timeInMilliseconds)
{
   var d = new Date(timeInMilliseconds)
	
   //add in the offset due to differences between the client and server clocks
   d.setTime( d.getTime() + <%=session.getAttribute("clientClockError")%>); 
	
   //use string arrays to display the months and days
   var months = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", 
                          "Aug", "Sep", "Oct", "Nov", "Dec");
	                     
    var weekdays = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
    
    //get Date values
    var hh = d.getHours();
    var mm = d.getMinutes();
    var ss = d.getSeconds();
    var dayOfMonth = d.getDate();
    
    //prepend a "0" to values < 10
    hh = doubleDigits(hh);
    mm = doubleDigits(mm);
    ss = doubleDigits(ss);
    dayOfMonth = doubleDigits(dayOfMonth); 
	
    //create a string that represents the Date/Time in the format "Mon Sep 16 2006 18:43:41"
    var strDate = weekdays[d.getDay()] + " " + months[d.getMonth()] + " " + dayOfMonth + " " +
	          d.getFullYear() + " " + hh + ":" + mm + ":" + ss;
		
    return ( strDate )
}

</script>

<%

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

String sessionKey = session.getAttribute("sessionKey").toString();

// ensure we are decoding the request parameters as UTF-8
request.setCharacterEncoding("UTF-8");

long contactID = Long.parseLong(request.getParameter("contactID"));


CIContactReadType contactResult = new CIContactReadType();

String CIContactWsUrl = "http://" + ccmmHostname + "/ccmmwebservices/CIContactWs.asmx"; 

CIContactWs contactLocator = new CIContactWsLocator();
CIContactWsSoap contactWs = contactLocator.getCIContactWsSoap( new java.net.URL(CIContactWsUrl));

contactResult = contactWs.readContact(contactID, sessionKey);

String resultTitle = "Read Customer Contact";
String resultDescription = "Successfully Read Customer Contact : " + contactID;

String subjectLabel = "Subject";
boolean outboundContact = false;


if ( contactResult.getContactType() == CIContactType.Outbound )
{
    subjectLabel = "Campaign Name";
    outboundContact = true;
}


%>


    <%-- The following html code displays a list of Customer Contacts --%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CCMM CI Sample Web Site</title>
    </head>
    <body>

    <!-- Set up the Main Table for the Web Page -->
    <table width="100%" border="0">
    <tr>
        
        <td height="80" colspan="3">
        <%@include file="header.html"%>
        </td>
    </tr>
    </table>
    <table width="800">
    <tr>
        <td width="200" height="900" valign="top">            
        <%@include file="menu.jsp" %>
        </td>

        <td width="10"></td>

        <td width="590" height="900" valign="top">  
        
            <table cellspacing="5" class="bold">
            <tr>
                <td colspan="5" height = "50" class="bold"><%= resultTitle %></td>
            </tr>              
            
            <tr>                
                <td colspan="5"><%= resultDescription %></td>
            </tr>
            <tr><td><br>&nbsp;</td></tr>
            <tr>
            <td class="formlabel">Contact Type</td>
            <td><input size="30" readonly="true" value="<%=contactResult.getContactType().getValue()%>"></td>
            <td class="formlabel">Skillset</td>
            <td><input size="30" readonly="true" value="<%if (contactResult.getSkillset().getName() != null ) { %><%= contactResult.getSkillset().getName() %><% } %>">
            </td>
            </tr>
            <tr>
            <td class="formlabel"><%= subjectLabel %></td>
            <td><input size="30" readonly="true" value="<%if (contactResult.getOriginalSubject() != null ) { %><%= contactResult.getOriginalSubject() %><% } %>">
            </td>
            <td class="formlabel">Contact Status</td>
            <td><input size="30" readonly="true" value="<%if (contactResult.getStatus().getValue() != null) { %><%= contactResult.getStatus().getValue() %><% } %>">
            </td>
            </tr>
            <% if ( outboundContact ) { %>
                <tr>
                <td class="formlabel">Submitted</td>
                
                <script language="javascript">
                	var localTime = getLocalTime(<%=contactResult.getArrivalTime().getMilliseconds()%>)
                	document.write("<td><input size='30' readonly='true' value='" + localTime + "'></td>")
                </script>  
                 
                </tr>                
            <% } else { %>
                <tr>            
                <td class="formlabel">Contact Source</td>
                <td><input size="30" readonly="true" value="<% if ( contactResult.getSource().getValue() != null) { %><%= contactResult.getSource().getValue() %><% } %>">
                </td>
                <td class="formlabel">Mail To</td>
                <td><input size="30" readonly="true" value="<% if (contactResult.getMailTo() != null) { %><%= contactResult.getMailTo() %><% } %>">
                </td>
                </tr>
                <tr>
                <td class="formlabel">Submitted</td>
                
                <script language="javascript">
                	var localTime = getLocalTime(<%=contactResult.getArrivalTime().getMilliseconds()%>)
                	document.write("<td><input size='30' readonly='true' value='" + localTime + "'></td>")
                </script>             

                <td class="formlabel">Mail From</td>
                <td><input size="30" readonly="true" value="<% if( contactResult.getMailFrom() != null ) { %><%= contactResult.getMailFrom()%><% } %>">
                </td>
                </tr>
            <% } %>    
            
            
            <%
            if( contactResult.getActionList() != null )
            {
                // Store the List of Actions in an Array
                CIActionReadType[] listOfActions = contactResult.getActionList();

                //Loop through the list of Actions printing the details of each one
                for(int i=listOfActions.length-1; i>=0; i--)
                {
                %>
                <tr>
                <td colspan="4"><br>&nbsp;</td>
                </tr>
                <tr>
                <td colspan="4"><hr></td>
                </tr>
                <tr>
                <td>Action ID : </td>
                <td><%=listOfActions[i].getId() %></td>
                <td></td><td></td>
                </tr>
                <tr>
                <td colspan="4"><hr></td>
                </tr>
                <% if (outboundContact) { %>
                    <tr>                    
                    <td class="formlabel">Action Source</td>
                    <td><input size="30" readonly="true" value="<% if( listOfActions[i].getSource().getValue() != null ) { %><%= listOfActions[i].getSource().getValue() %><% } %>">
                    </td>
                    <td class="formlabel">Call Result</td>
                    <td><input size="30" readonly="true" value="<%= listOfActions[i].getOutboundDispositionCode() %>">
                    </td>
                    </tr>
                    <tr>
                    <td class="formlabel">Creation Time</td>

                    <% if (listOfActions[i].getCreationTime() != null ) { %>
                    
                   <script language="javascript">
	                	var localTime = getLocalTime(<%= listOfActions[i].getCreationTime().getMilliseconds() %>)
	                	document.write("<td><input size='30' readonly='true' value='" + localTime + "'></td>")
                    </script>
                    
                    <% } else { %>
                    
                    <td><input size="30" readonly="true" value=""></td>
                    
                    <% } %>
                    
                    <td class="formlabel">Callback Time</td>    
    
                    <% if( listOfActions[i].getCallbackTime() != null) { %>
                    
                    <script language="javascript">
	                	var localTime = getLocalTime(<%= listOfActions[i].getCallbackTime().getMilliseconds() %>)
	                	document.write("<td><input size='30' readonly='true' value='" + localTime + "'></td>")
                    </script>
                    
                    <% } else { %>

                    <td><input size="30" readonly="true" value=""></td>        

                    <% } %>
                    
                    </td>                    
                    </tr>
                    <tr>
                    <td class="formlabel">Talk Time</td>
                    <td><input size="30" readonly="true" value="<%= listOfActions[i].getOutboundTalkTime() %>">
                    </td>
                    <td class="formlabel">Callback Status</td>
                    <td><input size="30" readonly="true" value="<% if( listOfActions[i].getCallbackStatus() != CICallbackStatus.Unspecified ) { %><%= listOfActions[i].getCallbackStatus().getValue() %><% } %>">
                    </td>
                    </tr>
                    
                
                <% } else { %>
                    <tr>
                    <td class="formlabel">Subject</td>
                    <td><input size="30" readonly="true" value="<% if ( listOfActions[i].getSubject() != null ) { %><%= listOfActions[i].getSubject() %><% } %>">
                    </td>
                    <td class="formlabel">Callback Time</td>    
    
                    <% if( listOfActions[i].getCallbackTime() != null) { %>
                    
                    <script language="javascript">
	                	var localTime = getLocalTime(<%= listOfActions[i].getCallbackTime().getMilliseconds() %>)
	                	document.write("<td><input size='30' readonly='true' value='" + localTime + "'></td>")
                    </script>
                    
                    <% } else { %>

                    <td><input size="30" readonly="true" value=""></td>      

                    <% } %>
                    
                    </td>
                    </tr>
                    <tr>
                    <td class="formlabel">Action Source</td>
                    <td><input size="30" readonly="true" value="<% if( listOfActions[i].getSource().getValue() != null ) { %><%= listOfActions[i].getSource().getValue() %><% } %>">
                    </td>
                    <td class="formlabel">Callback Status</td>
                    <td><input size="30" readonly="true" value="<% if( listOfActions[i].getCallbackStatus() != CICallbackStatus.Unspecified ) { %><%= listOfActions[i].getCallbackStatus().getValue() %><% } %>">
                    </td>
                    </tr>
                    <tr>
                    <td class="formlabel">Creation Time</td>

                    <% if (listOfActions[i].getCreationTime() != null ) { %>
                    
                    <script language="javascript">
	                	var localTime = getLocalTime(<%= listOfActions[i].getCreationTime().getMilliseconds() %>)
	                	document.write("<td><input size='30' readonly='true' value='" + localTime + "'></td>")
                    </script>
                    
                    <% } else { %>
                    
                    <td><input size="30" readonly="true" value=""></td>

                    <% } %>
                    
                    </td>
                    <td class="formlabel">Mail To</td>
                    <td><input size="30" readonly="true" value="<% if (listOfActions[i].getMailTo() != null ) { %><%=listOfActions[i].getMailTo() %><% } %>">
                    </td>            
                    </tr>
                <% } %>
                <tr><td></td></tr>
                <tr>
                <td colspan="4" class="label">
                <br>
                Action Text :
                <textarea cols="90" rows="10" readonly="true"><% if (listOfActions[i].getText() != null) { %><%=listOfActions[i].getText() %><% } %></textarea>            
                </td>
                <td></td>
                </tr>

                <%
                }
            }
%>
            </table>
  
        
    </table>  
    
    </body>
</html>
    

