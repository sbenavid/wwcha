<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="sessiontimeout.jsp"%>

<SCRIPT language="JavaScript">

function validateTextChat(form)
{
   if (form.Skillset.value == "none")
   {
      alert("Please select a Skillset");
      return false;
   }
   if (form.Subject.value.length == 0)
   {
      alert("Please enter a Subject");
      return false;
   }
   if (form.Objective.value.length == 0)
   {
      alert("Please enter an Objective");
      return false;
   }
   
   return true;
}

</script>

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
            
            <form name="requestTextChatform"  onsubmit="return validateTextChat(this)" method="POST" action="requestTextChat_WSClient.jsp">
                    
            <table cellspacing="15">
            <tr>
                <td colspan="2" height = "50" class="bold">Request Text Chat</td>
            </tr>            
            <tr>
                <td class="formlabel">Skillset</td>
                <td>
                
                <%@include file="getWebSkillsets_WSClient.jsp"%>
                
                </td>
            </tr>
            <tr>
                <td class="formlabel">Subject</td>
                <td><input name="Subject" size="47" maxlength="47" value="<%=application.getInitParameter("TEXT_CHAT_SUBJECT")%>">&nbsp;<font class="formlabel" color="red">*</font></td> 
            </tr>
            </table>
            
            <table cellspacing="0">
            <tr>
                <td class="formlabel" valign=top>Objective</td>
                <td width="15"></td>
                <td>
                <textarea name="Objective" rows="7" cols="45" wrap="virtual"></textarea>
                </td>
                <td valign="top">&nbsp;<font class="formlabel" color="red">*</font></td>
                
            </tr>          
            <tr><td><br></td></tr> 
            <tr>
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
