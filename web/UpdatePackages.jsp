<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="CSS/AddPackage.css" rel="stylesheet" type="text/css"/>
        <title>Grivato | Resorts</title>
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
        stmt = connection.createStatement();
        stmt2 = connection.createStatement();
        stmt3 = connection.createStatement();
        String action = request.getParameter("a");
        if(action.equals("a"))
        {
            
            rst = stmt.executeQuery("SELECT * FROM resort");
            %>
            <br><br><form name="packageForm" action="UpdatePackages.jsp?a=a2" method="post">
                <table>
                    <tr>
                        <td>Resort:</td>
                        <td>
                            <select name="r_id" required>
            <%
                            while(rst.next())
                            {
            %>
                                <option value="<%=rst.getInt("r_id")%>"><%=rst.getString("r_name")%></option>
            <%
                            }
            %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Details:</td>
                        <td height="100">
                            <textarea rows="4" cols="50" name="p_details"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Price:</td>
                        <td>
                            <input type="number" min="0" name="p_price" required>
                        </td>
                    </tr>
                    <tr>
                        <td>From:</td>
                        <td>
                            <input type="date" name="p_from" required>
                        </td>
                    </tr>
                    <tr>
                        <td>To:</td>
                        <td>
                            <input type="date" name="p_to" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Image:</td>
                        <td>
                            <input type="text" name="p_img">
                        </td>
                    </tr>
                </table>
                <br><input type="submit" value="Add Package">
            </form>
            <%
        }
        else if(action.equals("a2"))
        {
            String resortID = request.getParameter("r_id");
            String packageDetails = request.getParameter("p_details");
            double packagePrice = Double.parseDouble(request.getParameter("p_price")); 
            String packageFrom = request.getParameter("p_from");
            String packageTo = request.getParameter("p_to");
            String packageImg = request.getParameter("p_img");
            
            
            String sql = "INSERT INTO package VALUES(NULL,?,?,?,?,?,?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, resortID);
            pstmt.setString(2, packageDetails);
            pstmt.setDouble(3, packagePrice);
            pstmt.setString(4, packageFrom);
            pstmt.setString(5, packageTo);
            pstmt.setString(6, packageImg);
            pstmt.executeUpdate();
            
            response.sendRedirect("Packages.jsp");
        }

        else if(action.equals("u"))
        {
            String p_id = request.getParameter("id");

            rst = stmt.executeQuery("SELECT * FROM resort");
            
            rst2 = stmt2.executeQuery("SELECT * FROM package WHERE p_id = " + p_id);
            if(rst2.next());
            
            %>
            <form action="UpdatePackages.jsp?a=u2&id=<%=rst2.getInt("p_id")%>" method="post">
                <table>
                    <tr>
                        <td>Resort:</td>
                        <td>
                            <select name="r_id" required>
            <%
                            
                            while(rst.next())
                            {
                                String selected = (rst.getInt("r_id") == rst2.getInt("p_r_id"))? "selected":"";
            %>
                                <option value="<%=rst.getInt("r_id")%>" selected="<%=selected%>"><%=rst.getString("r_name")%></option>
            <%
                            }
            %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Details:</td>
                        <td height="100">
                            <textarea rows="4" cols="50" name="p_details"><%=rst2.getString("p_details")%></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Price:</td>
                        <td>
                            <input type="number" min="0" name="p_price" value="<%=rst2.getDouble("p_price")%>" required>
                        </td>
                    </tr>
                    <tr>
                        <td>From:</td>
                        <td>
                            <input type="date" name="p_from" value="<%=rst2.getString("p_from")%>" required>
                        </td>
                    </tr>
                    <tr>
                        <td>To:</td>
                        <td>
                            <input type="date" name="p_to" value="<%=rst2.getString("p_to")%>" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Image:</td>
                        <td>
                            <input type="text" name="p_img" value="<%=rst2.getString("p_img")%>">
                        </td>
                    </tr>
                </table>
                <input type="submit" value="Update Package">
            </form>
            <%
        }

        else if(action.equals("u2"))
        {
            String id = request.getParameter("id");
            String resortID = request.getParameter("r_id");
            String packageDetails = request.getParameter("p_details");
            double packagePrice = Double.parseDouble(request.getParameter("p_price")); 
            String packageFrom = request.getParameter("p_from");
            String packageTo = request.getParameter("p_to");
            String packageImg = request.getParameter("p_img");
            

            String sql = "UPDATE package SET p_r_id = ?, p_details = ?, p_price = ?, p_from = ?, p_to = ?, p_img= ? WHERE p_id = " + id;
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, resortID);
            pstmt.setString(2, packageDetails);
            pstmt.setDouble(3, packagePrice);
            pstmt.setString(4, packageFrom);
            pstmt.setString(5, packageTo);
            pstmt.setString(6, packageImg);
            pstmt.executeUpdate();
            
            response.sendRedirect("Packages.jsp");;

        }
        else if(action.equals("d"))
        {
            String id = request.getParameter("id");
            stmt.executeUpdate("DELETE FROM reservation WHERE re_p_id = " + id);
            stmt.executeUpdate("DELETE FROM package WHERE p_id = " + id);
            
            response.sendRedirect("Packages.jsp");
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
