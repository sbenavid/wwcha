/*
 * Copyright 2004 The Apache Software Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */ 
/* $Id: HelloWorldExample.java,v 1.4 2004/08/26 22:03:27 markt Exp $
 *
 */

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * The simplest possible servlet.
 *
 * @author James Duncan Davidson
 */

public class HelloWorldExample extends HttpServlet {


    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws IOException, ServletException
    {
        ResourceBundle rb =
            ResourceBundle.getBundle("LocalStrings",request.getLocale());
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");

	    String title = rb.getString("helloworld.title");

	    out.println("<title>" + title + "</title>");
        out.println("</head>");
        out.println("<body bgcolor=\"white\">");

        // Can't use relative links as the addition of pathinfo to the URI
        // breaks relative links. Therefore use absolute links but don't hard
        // code the context name so webapp can be deployed as different context
        // and will still work.
        String context = request.getContextPath();
        
	    out.println("<a href=\"" + context + "/servlets/helloworld.html\">");
        out.println("<img src=\"" + context + "/images/code.gif\" height=24 " +
                    "width=24 align=right border=0 alt=\"view code\"></a>");
        out.println("<a href=\"" + context + "/servlets/index.html\">");
        out.println("<img src=\"" + context + "/images/return.gif\" " +
                    "height=24 width=24 align=right border=0 alt=\"return\">" +
                    "</a>");


        out.println("<h1>" + title + "</h1>");

	out.println("<form name=wcForm>");
	out.println("<input type=hidden name=var1 value=liam");
	out.println("</form>");
	
        out.println("</body>");
        out.println("</html>");




    }
}



