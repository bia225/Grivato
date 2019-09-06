<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='java.sql.*'%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grivato | My Reservations</title>
        <link href="CSS/ViewRes.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function cancelReservation(id)
            {
                if(confirm("Are you sure you want to cancel this reservation?"))
                    window.location = "CancelReservation?re_id=" + id;
            }
        </script>
    </head>
    <body>
        <% 
            Connection con;
            Statement stmt;
            ResultSet rst, rst2, rst3;
            try
            {   
                session = request.getSession(false);
                if(session.getAttribute("user")!=null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato","root","");

                    stmt = con.createStatement();

                    String username = (String)session.getAttribute("user");
                     

                    rst = stmt.executeQuery("SELECT * FROM account WHERE a_username = \"" + username + "\"");
                    if(rst.next());
                    
                    rst2 = stmt.executeQuery("SELECT * FROM client WHERE c_id = " + rst.getInt("a_c_id")); 
                    if(rst2.next());
                  
                    
        %>

        <ul>
            <li><a href="ViewReservations.jsp">My Reservations</a></li>
                    <li><a href="MakeReservation.jsp">Make a Reservation</a></li>
                   <li> <a href="ChangePassword.jsp?a=1">Change Password</a></li>
                   <li> <a href="Logout">Logout</a></li>
        </ul>
                    <br>
                    <h3>Welcome <i><%=rst2.getString("c_fname")%></i>!</h3>
        <%          
                    String sql = "";
                    sql += "SELECT * FROM reservation, package, resort";
                    sql += " WHERE re_c_id = " + rst2.getInt("c_id");
                    sql += " AND p_id = re_p_id";
                    sql += " AND r_id = p_r_id";
                    rst3 = stmt.executeQuery(sql);
                    
                    if(rst3.next())
                    {
        %>
                        <table border="1">
                            <thead>
                            <th>Resort</th>
                            <th>Location</th>
                            <th>From</th>
                            <th>To</th>
                            
                            <th>For</th>
                            <th>Total Payment</th>
                            </thead>
        <%                
                        
                        do{
        %>
                            <tr>
                                <td><%=rst3.getString("r_name")%></td>
                                <td><%=rst3.getString("r_location")%></td>
                                <td><%=rst3.getDate("p_from")%></td>
                                <td><%=rst3.getDate("p_to")%></td>
                                <td><%=rst3.getInt("re_quantity")%></td>
                                <td><%=rst3.getDouble("p_price")*rst3.getInt("re_quantity")%>$</td>
                                <td><button onClick="cancelReservation(<%=rst3.getInt("re_id")%>)">Cancel</button></td>
                            </tr>
        <%
                        }while(rst3.next());
        %>
                        </table>
        <%
                    }
                    
                    else
                    {
                       out.println("<h3>You haven't made any reservations</h3>");
                    }
                }
                
                else
                {
                    out.print("Please <a href='index.html'>login</a> first... ");
                }
                       
            }catch(SQLException e)
            {
                out.println("SQL Exception: " + e);

            }catch(Exception e)
            {
                out.println("General Exception: " + e);

            }
        %>
    </body>
</html>

