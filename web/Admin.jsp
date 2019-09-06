<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/Admin.css" rel="stylesheet" type="text/css"/>
        <title>Grivato | Admin Page</title>
    </head>
    <body>
        <% 
            try
            {   
                session = request.getSession(false);
                if(session.getAttribute("admin")!=null)
                {
        %>
                     <ul>        
            <li><a href="Resorts.jsp">Resorts</a></li>
           <li> <a href="Packages.jsp">Packages</a></li>
           <li> <a href="Reservations.jsp">Reservations</a>  </li>  
           <li> <a href="Logout">Logout</a><br></li>
           </ul>
        <%
                }
                
                else
                {
                    out.print("<a>Access Denied... Please <a href='index.html'>login</a> first... ");
                
                }
                       
            }catch(Exception e)
            {
                out.println("General Exception: " + e);
            }
        %>
    </body>
</html>
