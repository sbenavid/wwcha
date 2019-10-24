<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.nortel.applications.ccmm.ci.datatypes.*"%>
<%@page import="com.nortel.applications.ccmm.ci.webservices.*"%>

<%@include file="sessiontimeout.jsp"%>

<%

String ccmmHostname  = application.getInitParameter("CCMM_HOSTNAME");

String username = session.getAttribute("username").toString();
String sessionKey = session.getAttribute("sessionKey").toString();


CICustomerReadType result = new CICustomerReadType();

String CICustomerWsUrl = "http://" + ccmmHostname + "/ccmmwebservices/CICustomerWs.asmx"; 

CICustomerWs customerLocator = new CICustomerWsLocator();
CICustomerWsSoap customerWs = customerLocator.getCICustomerWsSoap( new java.net.URL(CICustomerWsUrl));

result = customerWs.getCustomerByUsername(username, sessionKey);

CIEmailAddressReadType defaultEmailAddress = customerWs.getDefaultEmailAddress(result.getId(), sessionKey);
CIAddressReadType defaultAddress = customerWs.getDefaultAddress(result.getId(), sessionKey);
CIPhoneNumberReadType defaultPhoneNumber = customerWs.getDefaultPhoneNumber(result.getId(), sessionKey);

// Initialise variables that will store default IDs of address, email address and phone number
// -1 will be the default value
long defaultEmailAddressID = -1;
long defaultAddressID = -1;
long defaultPhoneNumberID = -1;

if( defaultEmailAddress != null )
{
    defaultEmailAddressID = defaultEmailAddress.getId();
}
if( defaultAddress != null )
{
    defaultAddressID = defaultAddress.getId();
}
if( defaultPhoneNumber != null )
{
    defaultPhoneNumberID = defaultPhoneNumber.getId();
}

String resultTitle = "Read Customer Details";
String resultDescription = "Successfully Read Customer Details for username : " + username;

%>



<script language = "JavaScript">


function validateCustDetails(form)
{
   if (form.firstName.value.length == 0)
   {
      alert("Please enter a First name");
      return false;
   }
   if (form.lastName.value.length == 0)
   {
      alert("Please enter a last name");
      return false;
   }
   if (form.emailAddress.value.length == 0)
   {
      alert("Please enter an Email Address");
      return false;
   }
   if ((form.emailAddress.value.indexOf("@") == -1 ) ||
       (form.emailAddress.value.indexOf(".") == -1 ))
   {
      alert("Email Address is not valid");
      return false;
   }
   if (form.phoneNumber.value.length == 0)
   {
      alert("Please enter a Phone Number");
      return false;
   }
  
   
   return true;
}
</script>



    <%-- The following html code displays the Customer Details --%>

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
        
            <form name="updateForm" onsubmit="return validateCustDetails(this)" method="POST" action="updateCustomer_WSClient.jsp">
            <table cellspacing="5" class="bold">
            <tr>
                <td colspan="5" height = "50" class="bold"><%= resultTitle %></td>
            </tr>              
            
            <tr>                
                <td colspan="5"><%= resultDescription %></td>
            </tr>
            <tr><td><br>&nbsp;</td></tr>
            <tr>
                <td class="formlabel">Title</td>
                <td><input name="title" size="5" maxlength="10" tabindex="1" <%if ( result.getTitle() != null ) {%>value="<%=result.getTitle()%>"<%}%>></td>                
            </tr>
            <tr>
                <td class="formlabel">First Name</td>
                <td><input name="firstName" size="20" maxlength="50" tabindex="2" value="<%=result.getFirstName()%>">&nbsp;<font class="formlabel" color="red">*</font></td>                
                <td width="20"></td>
                <td class="formlabel"><font color="#C0C0C0">Username</font></td>
                <td><input name="username" readonly="true" size="20" maxlength="50" tabindex="2" value="<%=result.getUsername()%>"></td>                                                
            <tr>
                <td class="formlabel">Last Name</td>
                <td><input name="lastName" size="20" maxlength="50" tabindex="3" value="<%=result.getLastName()%>">&nbsp;<font class="formlabel" color="red">*</font></td>
                <td></td><td></td><td></td>
            </tr>  
            <tr>
                <td colspan="5"></td>                
            </tr>
            <tr>
                <td class="formlabel"><font color="#C0C0C0">Email Address</font></td>
                <td><input name="emailAddress" readonly=true size="20" maxlength="50" tabindex="6" value="<%=defaultEmailAddress.getEmailAddress()%>">&nbsp;<font class="formlabel" color="red">*</font></td>                                
            </tr>          
            <tr><td></td></tr>
            <tr>
                <td colspan="2"><hr>Postal Address</td>
                <td width="20"></td>
                <td colspan="2"><hr>Phone Number</td>                
            </tr>
            <tr><td></td></tr>
            <tr>
                <td class="formlabel">Line 1</td>
                <td><input name="line1" size="20" maxlength="50" tabindex="7" value="<%=defaultAddress.getLine1()%>"></td>
                <td width="20"></td>
                <td class="formlabel">International Code</td>
                <td><input name="intCode" size="5" maxlength="10" tabindex="14" value="<%=defaultPhoneNumber.getInternationalCode()%>"></td>                
            </tr>
            <tr>
                <td class="formlabel">Line 2</td>
                <td><input name="line2" size="20" maxlength="50" tabindex="8" value="<%=defaultAddress.getLine2()%>"></td>
                <td width="20"></td>
                <td class="formlabel">Area Code</td>
                <td><input name="areaCode" size="5" maxlength="10" tabindex="15" value="<%=defaultPhoneNumber.getAreaCode()%>"></td>                
            </tr>
            <tr>
                <td class="formlabel">Line 3</td>
                <td><input name="line3" size="20" maxlength="50"  tabindex="9" value="<%=defaultAddress.getLine3()%>"></td>
                <td width="20"></td>
                <td class="formlabel">Number</td>
                <td><input name="phoneNumber" size="15" maxlength="30" tabindex="16" value="<%=defaultPhoneNumber.getNumber()%>">&nbsp;<font class="formlabel" color="red">*</font></td>                
            </tr>
            <tr>
                <td class="formlabel">Line 4</td>
                <td><input name="line4" size="20" maxlength="50" tabindex="10" value="<%=defaultAddress.getLine4()%>"></td>
                <%
                CIPhoneNumberType phoneNumType = defaultPhoneNumber.getPhoneNumberType();                
                %>
                <td width="20"></td>
                <td class="formlabel">Type</td>
                <td><select name="phoneType" tabindex="17" >
                <option value="Home" <% if(phoneNumType == CIPhoneNumberType.Home) {%> selected="true" <%}%> >Home
                <option value="Business" <% if(phoneNumType == CIPhoneNumberType.Business) {%> selected="true" <%}%> >Business
                <option value="Fax" <% if(phoneNumType == CIPhoneNumberType.Fax) {%> selected="true" <%}%> >Fax
                <option value="Mobile" <% if(phoneNumType == CIPhoneNumberType.Mobile) {%> selected="true" <%}%> >Mobile
                <option value="Other" <% if(phoneNumType == CIPhoneNumberType.Other) {%> selected="true" <%}%> >Other
                </select></td>
            </tr>
            <tr>
                <td class="formlabel">Line 5</td>
                <td><input name="line5" size="20" maxlength="50" tabindex="11" value="<%=defaultAddress.getLine5()%>"></td>
            </tr>
            <tr>
                <td class="formlabel">Zip Code</td>
                <td><input name="zipCode" size="20" maxlength="50" tabindex="12" value="<%=defaultAddress.getZipcode()%>"></td>
            </tr>
            <tr>
                <td class="formlabel">Country</td>
                <td><input name="country" size="20" maxlength="50" tabindex="13" value="<%=defaultAddress.getCountry()%>"></td>
            </tr> 
            <tr>
            <td>
                <input type="hidden" name="addressID" value="<%=defaultAddressID%>">
                <input type="hidden" name="phoneNumberID" value="<%=defaultPhoneNumberID%>">
                <input type="hidden" name="emailAddressID" value="<%=defaultEmailAddressID%>">
                <input type="hidden" name="custID" value="<%=result.getId()%>">
            </td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Update Details" tabindex="18"></td>                
            </tr>
            
            </table>  
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>
    

