<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->


<html>

<!-- set up 2 frames :
     hiddenFrame    -   this hidden page will be used to catch the onunload event and logoff the customer
                        if the customer exits the browser or navigates away from the page
     mainFrame      -   this page is used to display the content of the web site
-->
     
<frameset rows="0,*">
    <frame name="hiddenFrame"   frameborder="0" marginheight="0" marginwidth="0" scrolling="no"   src="hidden.jsp">
    <frame name="mainFrame"     frameborder="0" marginheight="0" marginwidth="0" scrolling="auto" src="jsCheck.jsp">
</frameset>

</html>


