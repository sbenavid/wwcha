<HTML>

  <style type="text/css">

    .status
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
	font-weight: bold;
    }

    .queue
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
    }

    .isWriting
    {
	background-color:transparent;
	border: 0px;
	color: CC0000;
	font-style: italic;
    }

    .table
    {
	position: absolute; top: 1px;
    }

  </style>


<body background="../images/bg2.gif">

<form name="statusform" method="POST">

<table width="100%" height="95%" class="table">
 <tr>
  <td width="100%">
    <input type=text name="status" class="status" value="Status: Not Connected" size=20><br>
    <input type=text name="isWriting"  size=30 class="isWriting">
    <input type=text name="expectedWaitTime" size=32 class="queue"><br>
    <input type=text name="positionInQueue" size=20 class="queue">
    <input type=hidden name="inSession">
  </td>
 </tr>
</table>
</form>


</BODY>
</HTML>
