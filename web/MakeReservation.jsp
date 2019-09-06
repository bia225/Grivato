<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='java.sql.*'%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grivato | Making a Reservations</title>
        <link href="CSS/MakeRes.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function cancelReservation(id)
            {
                if(confirm("Are you sure you want to cancel this reservation?"))
                    window.location = "CancelReservation?re_id=" + id;
            }
            
            function confirmReservation()
            {
                if(!confirm("Are you sure you want to reserve this package?"))
                    return false;
            }
        </script>
    </head>
    <body>
        <% 
            Connection con;
            Statement stmt;
            ResultSet rst, rst2;
            try
            {   
                
                if(session.getAttribute("user")!=null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato","root","");

                    stmt = con.createStatement();

                    String username = (String)session.getAttribute("user");
                     

                    rst = stmt.executeQuery("SELECT * FROM account WHERE a_username = \"" + username + "\"");
                    
                    if(rst.next());
                    
                    int client_ID = rst.getInt("a_c_id"); 
                  
                    String sql = "";
                    sql += "SELECT * FROM package, resort";
                    sql += " WHERE p_id NOT IN ";
                    sql += "(SELECT re_p_id FROM reservation WHERE re_c_id = " + rst.getInt("a_c_id") + ")";
                    sql += " AND p_r_id = r_id";
                    rst2 = stmt.executeQuery(sql);
        
        %>
                    <ul>
            <li><a href="ViewReservations.jsp">My Reservations</a></li>
                    <li><a href="MakeReservation.jsp">Make a Reservation</a></li>
                   <li> <a href="ChangePassword.jsp?a=1">Change Password</a></li>
                   <li> <a href="Logout">Logout</a></li>
        </ul>
                    <br>
                    <form action="SubmitReservation" onsubmit="return confirmReservation()" method="get">
                        <div class="make_res">
                            <h2>Make a Reservation</h2>

                        <table>
                            <tr>
                                <td >Package:</td>
                                <td>
                                    <select name="p_id">
        <%
                    if(rst2.first());

                    do
                    {
        %>
                                    <option value="<%=rst2.getInt("p_id")%>"><%=rst2.getInt("p_id")%> - <%=rst2.getString("r_name")%></option>
        <%
                    }while(rst2.next());
        %>                              
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>For: </td>
                                <td><input type="number" min="1" max="10" name="quantity"></td>
                            </tr>

                        </table>
                        <input type="hidden" name="c_id" value="<%=client_ID%>">
                        <br><input type="submit" value="Reserve">
                        </div>

                    </form>

                        <i><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Available Packages:</h4></i>
        <%            
                    if(rst2.first())
                    {  
                        do{
        %>
                  <div class="packages">
                      <h3><%=rst2.getInt("p_id")%> - <%=rst2.getString("r_name")%></h3>
                            <img src="<%=rst2.getString("p_img")%>"><img>
                            <p><%=rst2.getString("p_details")%></p>
                            From: <%=rst2.getDate("p_from")%> To: <%=rst2.getDate("p_to")%><br>
                            Price: <%=rst2.getDouble("p_price")%>$<br>
                  </div>
        <%
                        }while(rst2.next());
                    }
                    
                    else
                    {
                       out.println("No packages are available for reservation at the moment... Please check again later");
                    }
        %>
                    <br><br>
<!--                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="ViewReservations.jsp">Back</a>-->
        <%
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

