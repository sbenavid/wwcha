<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->


<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@include file="sessiontimeout.jsp"%>

<SCRIPT language="JavaScript">

function validateCallback(form)
{
   var currentDateTime = new Date;
   var cbHour=0;
   var cbMin=0;
   var cbSec=0;
   var cbDay=0;
   var cbMon=0;
   var cbYear=0;
   var cbDateTime=0;
   
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
   
   if (form.callback_time_hour.value != "none")
   {
      cbHour = form.callback_time_hour.options[form.callback_time_hour.selectedIndex].value;
   }
   else
   {
      alert("Please select Callback Hour");
      return false;
   }
   
   if (form.callback_time_minute.value != "none")
   {
      cbMin = form.callback_time_minute.options[form.callback_time_minute.selectedIndex].value;
   }
   else
   {
      alert("Please select Callback Minute");
      return false;
   }
   
   if (form.callback_date_day.value != "none")
   {
      cbDay = form.callback_date_day.options[form.callback_date_day.selectedIndex].value;
   }
   else
   {
      alert("Please select Callback Day");
      return false;
   }
   
   if (form.callback_date_month.value != "none")
   {
      cbMon = form.callback_date_month.options[form.callback_date_month.selectedIndex].value;
   }
   else
   {
      alert("Please select Callback Month");
      return false;
   }
   
   if (form.callback_date_year.value != "none")
   {
      cbYear = form.callback_date_year.options[form.callback_date_year.selectedIndex].value;
   }
   else
   {
      alert("Please select Callback Year");
      return false;
   }
   
   var cbDateTime = new Date(cbYear, cbMon, cbDay, cbHour, cbMin, cbSec);
   
   if ((cbDateTime != 0) && (cbDateTime < currentDateTime))
   {
      alert("Callback Date and Time is earlier than the Current Date and Time");
      return false;
   }
   
   //subtract the offset due to errors on the client clock
   cbDateTime.setTime( cbDateTime.getTime() - <%=session.getAttribute("clientClockError")%>); 
   
   //assign the number of Milliseconds in cbDateTime to the hidden input field callbackTimeInMilliseconds
   form.callback_time_milliseconds.value = cbDateTime.getTime();
  
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
            
            <form name="requestScheduledCBform"  onsubmit="return validateCallback(this)" method="POST" action="requestScheduledCallback_WSClient.jsp">
            <input type="hidden" name="callback_time_milliseconds" value="0" >
            <table cellspacing="15">
            <tr>
                <td colspan="3" height = "50" class="bold">Request Scheduled Callback</td>
            </tr>            
            <tr>
                <td width="25"></td>
                <td class="formlabel">Skillset</td>          
                <td>
                <%@include file="getOutboundSkillsets_WSClient.jsp"%>
                </td>
            </tr>
            <tr>
                <td width="25"></td>
                <td class="formlabel">Subject</td>                
                <td><input name="Subject" size="47" maxlength="47">&nbsp;<font class="label" color="red">*</font></td> 
            </tr>
            </table>
            
            <table cellspacing="0">
            <tr>
                <td width="40"></td>
                <td class="formlabel" valign=top>Objective</td>    
                <td width="15"></td>
                <td>
                <textarea name="Objective" rows="7" cols="45" wrap="virtual"></textarea>
                </td>
                <td valign="top">&nbsp;<font class="label" color="red">*</font></td>
            </tr>
            </table>
            
            <table cellspacing="15">
            <tr>
            <td class="formlabel">Callback Time</td>
            <td align=left >
            <SELECT name="callback_time_hour">
            <OPTION selected value="none">(hour)</OPTION>
            <OPTION value=0>00</OPTION>
            <OPTION value=1>01</OPTION>
            <OPTION value=2>02</OPTION>
            <OPTION value=3>03</OPTION>
            <OPTION value=4>04</OPTION>
            <OPTION value=5>05</OPTION>
            <OPTION value=6>06</OPTION>
            <OPTION value=7>07</OPTION>
            <OPTION value=8>08</OPTION>
            <OPTION value=9>09</OPTION>
            <OPTION value=10>10</OPTION>
            <OPTION value=11>11</OPTION>
            <OPTION value=12>12</OPTION>
            <OPTION value=13>13</OPTION>
            <OPTION value=14>14</OPTION>
            <OPTION value=15>15</OPTION>
            <OPTION value=16>16</OPTION>
            <OPTION value=17>17</OPTION>
            <OPTION value=18>18</OPTION>
            <OPTION value=19>19</OPTION>
            <OPTION value=20>20</OPTION>
            <OPTION value=21>21</OPTION>
            <OPTION value=22>22</OPTION>
            <OPTION value=23>23</OPTION>
            </SELECT>

            <SELECT name="callback_time_minute">
            <OPTION selected value="none">(minute)</OPTION>
            <OPTION value=0>00</OPTION>
            <OPTION value=5>05</OPTION>
            <OPTION value=10>10</OPTION>
            <OPTION value=15>15</OPTION>
            <OPTION value=20>20</OPTION>
            <OPTION value=25>25</OPTION>
            <OPTION value=30>30</OPTION>
            <OPTION value=35>35</OPTION>
            <OPTION value=40>40</OPTION>
            <OPTION value=45>45</OPTION>
            <OPTION value=50>50</OPTION>
            <OPTION value=55>55</OPTION>
            </SELECT>
            <font class="label" color="red">*</font>
            
            </td>
            </tr>

            <tr>
            <td class="formlabel">Callback Date</td>
            <td align=centre>
            <SELECT name="callback_date_day">
            <OPTION selected value="none">(day)</OPTION>
            <OPTION value=1>1</OPTION>
            <OPTION value=2>2</OPTION>
            <OPTION value=3>3</OPTION>
            <OPTION value=4>4</OPTION>
            <OPTION value=5>5</OPTION>
            <OPTION value=6>6</OPTION>
            <OPTION value=7>7</OPTION>
            <OPTION value=8>8</OPTION>
            <OPTION value=9>9</OPTION>
            <OPTION value=10>10</OPTION>
            <OPTION value=11>11</OPTION>
            <OPTION value=12>12</OPTION>
            <OPTION value=13>13</OPTION>
            <OPTION value=14>14</OPTION>
            <OPTION value=15>15</OPTION>
            <OPTION value=16>16</OPTION>
            <OPTION value=17>17</OPTION>
            <OPTION value=18>18</OPTION>
            <OPTION value=19>19</OPTION>
            <OPTION value=20>20</OPTION>
            <OPTION value=21>21</OPTION>
            <OPTION value=22>22</OPTION>
            <OPTION value=23>23</OPTION>
            <OPTION value=24>24</OPTION>
            <OPTION value=25>25</OPTION>
            <OPTION value=26>26</OPTION>
            <OPTION value=27>27</OPTION>
            <OPTION value=28>28</OPTION>
            <OPTION value=29>29</OPTION>
            <OPTION value=30>30</OPTION>
            <OPTION value=31>31</OPTION>
            </SELECT>
            
            <SELECT name="callback_date_month">
            <OPTION selected value="none">(month)</OPTION>
            <OPTION value=0>January</OPTION>
            <OPTION value=1>February</OPTION>
            <OPTION value=2>March</OPTION>
            <OPTION value=3>April</OPTION>
            <OPTION value=4>May</OPTION>
            <OPTION value=5>June</OPTION>
            <OPTION value=6>July</OPTION>
            <OPTION value=7>August</OPTION>
            <OPTION value=8>September</OPTION>
            <OPTION value=9>October</OPTION>
            <OPTION value=10>November</OPTION>
            <OPTION value=11>December</OPTION>
            </SELECT>
            
            <SELECT name="callback_date_year">
            <OPTION selected value="none">(year)</OPTION>
            <OPTION value=2014>2014</OPTION>
            <OPTION value=2015>2015</OPTION>
            </SELECT>
            <font class="label" color="red">*</font>
            
            </td>
            </tr>
            
            <tr>
                <td><br><br></td>
                <td><input type=submit value="Submit">
            </tr>            
            </table>
            </form>
        </td>
    </tr>
        
    </table>  
    
    </body>
</html>

