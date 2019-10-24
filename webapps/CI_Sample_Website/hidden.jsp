<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->
<script language="javascript">

// this function delays execution by a number of milliseconds
function doWait(millis) 
{
    var refDate = new Date();
    var currentDate = null;

    do 
    { 
        currentDate = new Date(); 
    } 
    while( (currentDate - refDate) < millis);
} 


// this function is executed when the Customer exits the browser or navigates 
// away from the Sample Website
function doUnload()
{
    // if the customer is on the web on hold page and exits the browser
    // we must allow time for the chat page to call the AbandonQueuingWebCommsContact 
    // web service
    doWait(1500);

    // logoff the customer by loading the logoffCustomer_WSClient.jsp page
    
	// No requirement to logout user for Annonymous Chat sessions:
	// Otherwise logoff the customer by loading the logoffCustomer_WSClient.jsp page
	if (logoff_form.sessionKey.value.length > 0)
	{
		parent.location = "logoffCustomer_WSClient.jsp";	   
	}
    
    // insert a delay of 500 milliseconds to allow enough time for the customerLogoff
    // web service to be executed    
    doWait(500);
}



</script>

<html>
<body onunload="doUnload()">
<form name='logoff_form' method="POST" target="_self" action='logoffCustomer_WSClient.jsp'>
    <input type="hidden" name="username">
    <input type="hidden" name="sessionKey">
</form>

</body>
</html>

