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

// this parameter specifies how many contacts will be displayed on the page
// and is set in the web.xml configuration file
String strNumContacts = application.getInitParameter("NO_OF_CONTACTS_TO_DISPLAY");

// set a default value of 20
int numContactsToDisplay = 20;

// ensure the web.xml value is not null and assign it to numContactsToDisplay
if( strNumContacts != null )
{
	numContactsToDisplay = Integer.parseInt(strNumContacts);
}

String username = session.getAttribute("username").toString();
long custID = Long.parseLong(session.getAttribute("custID").toString());
String sessionKey = session.getAttribute("sessionKey").toString();

// this variable are used for paging the contacts on this page
int numOfContacts = 0;
long firstContactID = 0;
long lastContactID = 0;
long startContactID = 0;


// read the pageControl request parameter, can be 'first', 'prev', 'next' or 'last'
String pageControl = (String)request.getParameter("pageControl");

// the startContactID request parameter specifies what the startContact ID will be
// when calling the web methods readPreviousBlockOfContacts and readNextBlockOfContacts
if( request.getParameter("startContactID") != null )
{
	startContactID = Long.parseLong(request.getParameter("startContactID"));
}

// create the variable for reading back the contacts
CIContactReadType[] listOfContacts = null;
CIContactBlockReadType blockOfContacts = new CIContactBlockReadType();

String CICustomerWsUrl = "http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"; 

CICustomerWs customerLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerLocator.getCICustomerWsSoap( new java.net.URL(CICustomerWsUrl));

// here we call one of readFirstBlockOfContacts, readNextBlockOfContacts, readPreviousBlockOfContacts
// or readLastBlockOfContacts depending on the value of the pageControl variable

// *** Note: Array of contacts is in decending order (latest contact to arrive (in time) is the first in the list)
if( pageControl.equals("first"))
{
	// Gets the oldest block of contacts
	blockOfContacts = customerWs.readFirstBlockOfContacts(custID, numContactsToDisplay, sessionKey);
}

if( pageControl.equals("next"))
{
	//Goes to an earlier contact in the list
	blockOfContacts = customerWs.readNextBlockOfContacts(custID, numContactsToDisplay, startContactID, sessionKey);
}

if( pageControl.equals("prev"))
{
	//Goes to a later contact in the list
	blockOfContacts = customerWs.readPreviousBlockOfContacts(custID, numContactsToDisplay, startContactID, sessionKey);
}

if( pageControl.equals("last"))
{
	// Gets the most recent  block of contacts
	blockOfContacts = customerWs.readLastBlockOfContacts(custID, numContactsToDisplay, sessionKey);
}

// these variable are used to display the line : contacts 10 - 19 of 30
// 10 - displayNumber1 - Block start
// 19 - displayNumber2 - Block End
// of 30 - displayNumber3 (Total Number of Contacts)
long displayNumber1 = 0;
long displayNumber2 = 0;
long displayNumber3 = 0;

// read the nuber of contacts Before and After the current block
long contactsBefore = blockOfContacts.getContactsRemainingBefore(); // Number of Contacts that arrived (in time) before the current block
long contactsAfter = blockOfContacts.getContactsRemainingAfter();// Number of Contacts that arrived (in time) after the current block

// if the list of returned contacts is not empty, then populate the variables
// required below
if( blockOfContacts.getContactsList() != null )
{
    listOfContacts = blockOfContacts.getContactsList();
    numOfContacts = listOfContacts.length;
    firstContactID = listOfContacts[0].getId();
    lastContactID = listOfContacts[numOfContacts -1].getId();
    displayNumber1 = contactsAfter + 1; //Block Start.
    displayNumber2 = contactsAfter + numOfContacts;
    displayNumber3 = contactsBefore + contactsAfter + numOfContacts;
}

String resultTitle = "Read Customer Contact History";
String resultDescription = "Successfully Read Customer Contact History for username : " + username;

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
        <td width="200" height="900">            
        <%@include file="menu.jsp" %>
        </td>

        <td width="10"></td>

        <td width="590" height="900" valign="top">  
        
            <table cellspacing="5" class="bold" width="100%">
            <tr>
                <td colspan="3" height = "50" class="bold"><%= resultTitle %></td>
            </tr>              
            
            <tr>                
                <td colspan="3"><%= resultDescription %><br><br></td>
            </tr>
            <font size="12" color="#003399">
            <b> 
            <tr>                
            	<td colspan="3" align="center">
            	<%-- this section displays the paging arrows and the number of contacts 
                     if there are no contacts before/after the current block of contacts
                     then the right/left arrows are disabled
                 --%>
            	<img  align="middle" align="left" src="images/startArrow.gif" onclick="window.location='readCustContactHist_WSClient.jsp?pageControl=last'"/>
            	
            	<% if ( contactsAfter != 0) { %>
            		<img  align="middle" align="left" src="images/leftArrow.gif" onclick="window.location='readCustContactHist_WSClient.jsp?pageControl=next&startContactID=<%=lastContactID %>'"/>            	
            	<% } else { %>            	
            		<img  align="middle" align="left" src="images/leftArrow.gif" />
            	<% } %> 
            	
            	&nbsp;contacts <%= displayNumber1 %> - <%= displayNumber2 %> of <%= displayNumber3 %>&nbsp;
            	
            	<% if ( contactsBefore != 0) { %>
	           		<img  align="middle" align="right" src="images/rightArrow.gif" onclick="window.location='readCustContactHist_WSClient.jsp?pageControl=prev&startContactID=<%=firstContactID %>'"/>
	           	<% } else { %>            	
            		<img  align="middle" align="right" src="images/rightArrow.gif" />            	
            	<% } %>
           		
           		<img  align="middle" align="right" src="images/endArrow.gif" onclick="window.location='readCustContactHist_WSClient.jsp?pageControl=first'"/>
           	</td>            		
            </tr>         
            <tr>
                <td width="60">Contact<br> ID</td>
                <td width="30">Type</td>
                <td width="30">Submitted</td>
            </tr>
            <tr>
                <td colspan="3"><hr></td>
            </tr>
            <%
            for(int i=numOfContacts-1; i>=0; i--)
            {
            long timeInMilliseconds = listOfContacts[i].getArrivalTime().getMilliseconds();
            %>
            <script language="javascript">            
            	var localTime = getLocalTime(<%=timeInMilliseconds%>)                                  
            </script>
            
            <tr>               
                <td class="label"><a href="readContact_WSClient.jsp?contactID=<%= listOfContacts[i].getId()%>"><%= listOfContacts[i].getId()%></a></td>                
                <td class="label"><%= listOfContacts[i].getContactType().getValue()%></td>
                <td class="label"><script language="javascript"> document.write(localTime)</script></td>
            </tr>      
            
            <%
            }
            %>
            
            </b>
            </font>
            </table>       
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>
    

