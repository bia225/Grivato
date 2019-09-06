<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grivato | Reservations</title>
        <link href="CSS/Reservations.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function addReservation()
            {
                window.location = "UpdateReservations.jsp?a=a";
            }

            function deleteReservation(id)
            {
                if(confirm("Are you sure you want to delete this reservation?"))window.location = "UpdateReservations.jsp?a=d&id= " + id;
            }
        </script>
    </head>
    <body>
        <%

            Connection con;
            Statement stmt;
            ResultSet rst;
            try
            {   
                session = request.getSession(false);
                if(session.getAttribute("admin")!=null)
                {
                    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato", "root", "");
                    stmt = con.createStatement();
                    
        %>
           <ul>        
            <li><a href="Resorts.jsp">Resorts</a></li>
           <li> <a href="Packages.jsp">Packages</a></li>
           <li> <a href="Reservations.jsp">Reservations</a>  </li>  
           <li> <a href="Logout">Logout</a><br></li>
           </ul>
        <%
                    rst = stmt.executeQuery("SELECT * FROM RESERVATION");
                    
                    if(rst.next())
                    {
        %>
        <br><br><br><br> <table border="1">
                <thead>
                <th>Reservation ID</th>
                <th>Client ID</th>
                <th>Package ID</th>
                <th>Quantity</th>
                </thead>
        <%                
                        do{
        %>
                <tr>
                    <td><a href="UpdateReservations.jsp?a=u&id=<%=rst.getInt("re_id")%>"><%=rst.getInt("re_id")%></a></td>
                    <td><%=rst.getInt("re_c_id")%></td>    
                    <td><%=rst.getInt("re_p_id")%></td>
                    <td><%=rst.getInt("re_quantity")%></td> 
                    <td><button onclick="deleteReservation(<%=rst.getInt("re_id")%>)">Delete</button></td>   
                </tr>
        <%
                        }while(rst.next());
        %>
            </table>
        <%
                    }
                    
                    else
                    {
                        out.println("No reservations found");
                    }
                
                }
           
                else
                {
                    out.print("<Access Denied... Please <a href='index.html'>login</a> first... ");
                
                }
        %>
            <br><br><br><button onclick="addReservation()">Add Reservation</button>
        <%        
                   
            }
            catch(SQLException ex){
                out.println(ex);
            }
            catch(Exception ex){
                out.println(ex);
            }
    %>
    </body>
</html>
