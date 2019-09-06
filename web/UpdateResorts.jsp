<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/UpdateRes.css" rel="stylesheet" type="text/css"/>
        <title>Grivato | Resorts</title>
    </head>
    <body>
    <%
        
    Connection connection;
    Statement stmt, stmt2, stmt3;
    PreparedStatement pstmt;
    ResultSet rst, rst2, rst3;
    
    try {
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
        Class.forName("com.mysql.jdbc.Driver").newInstance(); 
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato", "root", "");
        if(!connection.isClosed());
        stmt = connection.createStatement();
        stmt2 = connection.createStatement();
        stmt3 = connection.createStatement();
        String action = request.getParameter("a");
        if(action.equals("a"))
        {
            
            %>
            <form action="UpdateResorts.jsp?a=a2" method="post">
               <br><br><br> <table>
                    <tr>
                        <td>Name:</td>
                        <td>
                            <input type="text" name="r_name">
                        </td>
                    </tr>
                    <tr>
                        <td>Location:</td>
                        <td>
                            <input type="text" name="r_location">
                        </td>
                    </tr>
                </table>
                <br><br><br><input type="submit" value="Add Resort">
            </form>
            <%
        }
        else if(action.equals("a2"))
        {
            String resortName = request.getParameter("r_name");
            String resortLocation = request.getParameter("r_location");
            
            
            String sql = "INSERT INTO resort VALUES(NULL,?,?);";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, resortName);
            pstmt.setString(2, resortLocation);
            pstmt.executeUpdate();
            
            response.sendRedirect("Resorts.jsp");
        }

        else if(action.equals("u"))
        {
            String r_id = request.getParameter("id");

            rst = stmt.executeQuery("SELECT * FROM resort WHERE r_id = " + r_id);
            if(rst.next());

            %>
            <form action="UpdateResorts.jsp?a=u2&id=<%=rst.getInt("r_id")%>" method="post">
                <br><br><br><table>
                    <tr>
                        <td>Resort Name:</td>
                        <td>
                            <input type="text" name="r_name" value="<%=rst.getString("r_name")%>">
                        </td>
                    </tr>
                    <tr>
                        <td>Resort Location:</td>
                        <td>
                            <input type="text" name="r_location" value="<%=rst.getString("r_location")%>">
                        </td>
                    </tr>
                    
                </table>
                <br><br><br><input type="submit" value="Update Resort">
            </form>
            <%
        }

        else if(action.equals("u2"))
        {
            String id = request.getParameter("id");
            String resortName = request.getParameter("r_name");
            String resortLocation = request.getParameter("r_location");
            

            String sql = "UPDATE resort SET r_name = ?, r_location = ? WHERE r_id = " + id;;
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, resortName);
            pstmt.setString(2, resortLocation);
            pstmt.executeUpdate();

            response.sendRedirect("Resorts.jsp");

        }
        else if(action.equals("d"))
        {
            String id = request.getParameter("id");
               
            stmt.executeUpdate("DELETE FROM reservation WHERE re_p_id IN (SELECT p_id FROM package WHERE p_r_id = "+id+")");
            stmt.executeUpdate("DELETE FROM package WHERE p_r_id = " + id);
            stmt.executeUpdate("DELETE FROM resort WHERE r_id = " + id);
            
            
            response.sendRedirect("Resorts.jsp");
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
