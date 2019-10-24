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

String sessionKey = (String)session.getAttribute("sessionKey");

java.net.URL ciSkillsetWsUrl = new java.net.URL("http://" + ccmmHostname + "/ccmmwebservices/CISkillsetWs.asmx"); 

CISkillsetWs skillsetLocator = new CISkillsetWsLocator();
CISkillsetWsSoap skillsetWs = skillsetLocator.getCISkillsetWsSoap( ciSkillsetWsUrl );

CIMultipleSkillsetsReadType skillsetReadResult = new CIMultipleSkillsetsReadType();
skillsetReadResult = skillsetWs.getAllOutboundSkillsets(sessionKey);

int length = skillsetReadResult.getSkillsetList().length;

%>
    <select name="Skillset">
    <option selected value="none">(Please Select)</option>
<%
    for(int i=0; i<length; i++)
    {
        String skillsetName = skillsetReadResult.getSkillsetList()[i].getName();
        long skillsetID = skillsetReadResult.getSkillsetList()[i].getId();
        
        %><option value="<%=skillsetID%>"><%=skillsetName%></option>
    <%
    }

%>
    </select>&nbsp;<font class="formlabel" color="red">*</font>







