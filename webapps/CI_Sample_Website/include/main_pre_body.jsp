<%-- 
    Document   : main_pre_body.jsp
    Created on : 14-Apr-2014, 14:06:20
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">

//	Globally used functions

function sound(surl)
{
	document.getElementById("NewMessageBeepHolder").innerHTML = "<embed src=\""+surl+"\" hidden=\"true\" autostart=\"true\" loop=\"false\" />";
}

//	Resize pop-up according to browser used, and by possible extending length
function resizeWindow(ffPixelWidth, crPixelWidth, iePixelWidth, ffPixelLength, crPixelLength, iePixelLength, extendLength)
{
	if (/Firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent))
		window.resizeTo(ffPixelWidth, ffPixelLength + extendLength);	//	Firefox
	else if(navigator.userAgent.indexOf("Chrome") != -1)
		window.resizeTo(crPixelWidth, crPixelLength + extendLength);	//	Chrome
	else if(navigator.appName == "Microsoft Internet Explorer")
	{
		extendLength -= extendLength/14;
		window.resizeTo(iePixelWidth, iePixelLength + extendLength);	//	IE
	}
	else 
		window.resizeTo(iePixelWidth, iePixelLength + extendLength);	//	Resize others as of IE
}

//	Whitespace removal functions:
//	At source
function checkSpace(event)
{ 	
	return event.which !== 32;
}
//	In string
function whitespaceTrim(str)
{
	return str.replace(/\s+/g,'');
}

//	Check for valid email address
function isValidEmailAddress(str)
{  
	var at="@";
	var dot=".";
	var lat=str.indexOf(at);
	var lstr=str.length;
	var ldot=str.indexOf(dot);

	//	If string contains whitespace, trim
	str = whitespaceTrim(str);

	if (str.indexOf(at)==-1)
	{
		return false;
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr)
	{
		return false;
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==(lstr-1))
	{
		return false;
	}

	if (str.indexOf(at,(lat+1))!=-1)
	{
		return false;
	} 

	if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot)
	{
		return false;
	}

	if (str.indexOf(dot,(lat+2))==-1)
	{
		return false;
	}

	if (str.indexOf(" ")!=-1)
	{
		return false;
	}

	return true;			
}

//	Check for valid phone number
function isValidPhoneNumber(str)
{
		var validCharacters = "0123456789";

		//	If string contains whitespace, trim
		str = whitespaceTrim(str);

		for (i = 0; i < str.length; i++) 
		{ 
			if (validCharacters.indexOf(str.charAt(i)) == -1) 
			{
				return false;
			}
		}

		return true;
}

</script>