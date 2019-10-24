////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  displayformparams.js     Author: Liam Loftus         Date: 10 Oct 2005       Nortel CCMM 6.0
//
//  Retrieves name=value pairs from url and displays values in web form
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////


var els = document.forms[0].elements; 

// Get Query String
var query = location.search.substring(1);
// Split query at the comma
var pairs = query.split("&");
  
var counter = 0;
  
// Begin loop through the querystring
for(var i = 0; i < pairs.length; i++) 
{

    // Look for "name=value"
    var pos = pairs[i].indexOf('=');

    // if not found, skip to next
    if (pos == -1) continue;

    // Extract the name
    var argname = pairs[i].substring(0,pos);
    
    // Extract the value
    var value = pairs[i].substring(pos+1); 


    for(x=0; x<els.length; x++)
    { 


	if (els[x].name == argname)
	{


	   switch(els[x].type)
  	   {

		   case "select-one" :

			for(indx=0; indx<els[x].length; indx++)
			{

			    if(els[x].options[indx].text == myunescape(value)) 
			    {					
				els[x].selectedIndex = indx;

			    }
			}


			break;

		   case "text":

			els[x].value= myunescape(value);

			break;

		   case "textarea":

			els[x].value= myunescape(value);

			break;

		   case "checkbox":

			els[x].checked = true;

			break;

		   case "radio":

			var p = els[x].length;
			do
			{

			   if (els[x].value == value)
			   {
				els[x].checked = true;

			   }
			}
			while (p);

			break;

	 	}


	   }

   }


}

  
function myunescape (str)
{
     str = "" + str;
     while (true)
     {
	var i = str . indexOf ('+');
	if (i < 0)
		break;
	str = str . substring (0, i) + '%20' +
		str . substring (i + 1, str . length);

     }

     return unescape (str);
}

