<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="sessiontimeout.jsp"%>

<%
String form_To = (String)application.getInitParameter("HTML_FORM_TO_ADDRESS");
String form_Subject = (String)application.getInitParameter("HTML_FORM_SUBJECT");
String fromAddress = (String)session.getAttribute("custEmailAddress");
%>


<SCRIPT LANGUAGE="JavaScript">

function validateForm(form)
{
   
   if (form.To.value.length == 0)
   {
      alert("Please enter a To Address");
      return false;
   }
   if ((form.To.value.indexOf("@") == -1 ) ||
       (form.To.value.indexOf(".") == -1 ))
   {
      alert("Email Address is not valid");
      return false;
   }
   if (form.Subject.value.length == 0)
   {
      alert("Please enter a Subject");
      return false;
   }   
   if (form.textField1.value.length == 0)
   {
      alert("Please enter text in Text Field 1");
      return false;
   }
   if (form.textField2.value.length == 0)
   {
      alert("Please enter text in Text Field 2");
      return false;
   }
   if (form.TxtArea.value.length == 0)
   {
      alert("Please enter text in the Text Area");
      return false;
   }
   
   
   return true;
}

</SCRIPT>

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
            
            <form name="submitEmailContact" onsubmit="return validateForm(this)" method="POST" action="sendmail.jsp">
            
            <input type="hidden" name="From" value="<%=fromAddress%>">            

            <table cellspacing="15">
            <tr>
                <td colspan="2" height = "50" class="bold">Submit an HTML Form as an Email</td>
            </tr> 
            <tr>
                <td class="formlabel">Mail To</td>
                <td>
                <input name="To" size="47" maxlength="47" value="<%=form_To%>">&nbsp;<font class="formlabel" color="red">*</font>                
                </td>
            </tr>
            <tr>
                <td class="formlabel">Subject</td>
                <td>
                <input name="Subject" size="47" maxlength="47" value="<%=form_Subject%>">&nbsp;<font class="formlabel" color="red">*</font>                
                </td>
            </tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr>
                <td class="formlabel">Text Field 1</td>
                <td>
                <input name="textField1" size="47" maxlength="47">&nbsp;<font class="formlabel" color="red">*</font>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Text Field 2</td>
                <td>
                <input name="textField2" size="47" maxlength="47">&nbsp;<font class="formlabel" color="red">*</font>                
                </td>
            </tr>
            <tr>
                <td class="formlabel">Choice 1</td>
                <td>
                <input type="radio" name="choice1" value="Option1" checked="true">Option 1
                <input type="radio" name="choice1" value="Option2">Option 2
                <input type="radio" name="choice1" value="Option3">Option 3
                </td>                
            </tr>
            <tr>
                <td class="formlabel">Choice 2</td>
                <td>
                <select name="choice2">
                <option value="selection1">Selection 1
                <option value="selection2">Selection 2
                <option value="selection3">Selection 3
                </td>
            </tr>
            </table>
            
            <table cellspacing="0">
            <tr>
                <td width="25"></td>
                <td class="formlabel" valign=top>Text Area</td>
                <td width="15"></td>
                <td>
                <textarea name="TxtArea" rows="7" cols="45" wrap="virtual"></textarea>
                </td>
                <td valign="top">&nbsp;<font class="formlabel" color="red">*</font></td>
            </tr>          
            
            <tr><td><br></td></tr> 
            
            <tr>
                <td width="25"></td>
                <td><br><br></td>
                <td width="15"></td>
                <td><input type=submit value="Submit">
            </tr>            
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>

