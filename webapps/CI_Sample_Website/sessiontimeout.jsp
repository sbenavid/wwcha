<!--
Avaya Aura Contact Center Multimedia 
Copyright © 2010 Avaya Inc. All Rights Reserved
-->

<%

if( session.getAttribute("username") == null )
{
%>
    <jsp:forward page="loginCustomer_timeout.jsp"></jsp:forward>
<%
}

%>