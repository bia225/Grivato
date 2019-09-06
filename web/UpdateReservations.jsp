<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/UpdateRsv.css" rel="stylesheet" type="text/css"/>
        <title>Grivato | Reservations</title>
    </head>
    <body>
    <%
        
    Connection connection;
    Statement stmt, stmt2, stmt3;
    PreparedStatement pstmt;
    ResultSet rst, rst2, rst3;
    
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance(); 
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato", "root", "");
        if(!connection.isClosed());
        stmt = connection.createStatement();
        stmt2 = connection.createStatement();
        stmt3 = connection.createStatement();
        String action = request.getParameter("a");
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
        if(action.equals("a"))
        {
            rst = stmt.executeQuery("SELECT c_id, c_fname, c_lname FROM client");
            rst2 = stmt2.executeQuery("SELECT p_id, r_name FROM package, resort WHERE p_r_id = r_id");
            %>
            <form action="UpdateReservations.jsp?a=a2" method="post">
                <br><br> <table>
                    <tr>
                        <td>Package:</td>
                        <td>
                            <select name="p_id">
            <%
                            while(rst2.next())
                            {
            %>
            <option value="<%=rst2.getInt("p_id")%>"><%=rst2.getInt("p_id")%> - <%=rst2.getString("r_name")%> </option>
            <%
                            }
            %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Client:</td>
                        <td>
                            <select name="c_id">
            <%
                            while(rst.next())
                            {
            %>
                            <option value="<%=rst.getInt("c_id")%>"><%=rst.getInt("c_id")%> - <%=rst.getString("c_fname")%> <%=rst.getString("c_lname")%></option>
            <%
                            }
            %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantity: </td>
                        <td><input type="number" min="1" max="10" name="quantity"></td>
                    </tr>
                </table>
               <br><br> <input type="submit" value="Add Reservation">
            </form>
            <%
        }
        else if(action.equals("a2"))
        {
            int p_id = Integer.parseInt(request.getParameter("p_id"));
            int c_id = Integer.parseInt(request.getParameter("c_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            String sql = "INSERT INTO reservation VALUES(NULL,?,?,?);";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, p_id);
            pstmt.setInt(2, c_id);
            pstmt.setInt(3, quantity);
            pstmt.executeUpdate();
            
            response.sendRedirect("Reservations.jsp");
        }

        else if(action.equals("u"))
        {
            String re_id = request.getParameter("id");
            
            
            rst = stmt.executeQuery("SELECT c_id, c_fname, c_lname FROM client");
            rst2 = stmt2.executeQuery("SELECT p_id, r_name FROM package, resort WHERE p_r_id = r_id");

            rst3 = stmt3.executeQuery("SELECT * FROM reservation WHERE re_id = " + re_id);
            if(rst3.next());

            %>
            <form action="UpdateReservations.jsp?a=u2&id=<%=rst3.getInt("re_id")%>" method="post">
                <table>
                    <tr>
                        <td>Package:</td>
                        <td>
                            <select name="p_id">
            <%
                            while(rst2.next())
                            {
                                String selected = (rst3.getInt("re_p_id")==rst2.getInt("p_id"))?"selected":"";
            %>
            <option value="<%=rst2.getInt("p_id")%>" selected="<%=selected%>"><%=rst2.getInt("p_id")%> - <%=rst2.getString("r_name")%> </option>
            <%
                            }
            %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Client:</td>
                        <td>
                            <select name="c_id">
            <%
                            
                            while(rst.next())
                            {
                                String selected = (rst3.getInt("re_c_id")==rst.getInt("c_id"))?" selected=\"selected\"":"";
            %>
                            <option value="<%=rst.getInt("c_id")%>" <%=selected%>><%=rst.getInt("c_id")%> - <%=rst.getString("c_fname")%> <%=rst.getString("c_lname")%></option>
            <%
                            }
            %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Quantity: </td>
                        <td><input type="number" min="1" max="10" name="quantity" value="<%=rst3.getInt("re_quantity")%>"></td>
                    </tr>
                </table>
                <input type="submit" value="Update Reservation">
            </form>
            <%
        }

        else if(action.equals("u2"))
        {
            String id = request.getParameter("id");
            int p_id = Integer.parseInt(request.getParameter("p_id"));
            int c_id = Integer.parseInt(request.getParameter("c_id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            

            String sql = "UPDATE reservation SET re_c_id = ?, re_p_id = ?, re_quantity = ? WHERE re_id = " + id;;
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, c_id);
            pstmt.setInt(2, p_id);
            pstmt.setInt(3, quantity);
            pstmt.executeUpdate();

            response.sendRedirect("Reservations.jsp");

        }
        else if(action.equals("d"))
        {
            String id = request.getParameter("id");
               
            stmt.executeUpdate("DELETE FROM reservation WHERE re_id = " + id);
            
            response.sendRedirect("Reservations.jsp");
        }
        
            
        connection.close();
        }

        else{
            out.print("Access Denied... Please <a href='index.html'>login</a> first... ");
        }
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
