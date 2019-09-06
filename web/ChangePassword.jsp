<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='java.sql.*'%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grivato | My Reservations</title>
        <link href="CSS/ChangePass.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function changePass()
            {
                var cpass = document.forms["passform"]["cpass"].value;
                var npass = document.forms["passform"]["npass"].value;
                var cnpass = document.forms["passform"]["cnpass"].value;
                var pass = document.forms["passform"]["pass"].value;
                
                if(cpass == "" || npass == "" || cnpass=="")
                {
                    alert("Please fill all fields");
                    return false;
                }
                
                if(cpass!=pass)
                {
                    alert("Invalid current password");
                    return false;
                }
                
                if(npass!=cnpass)
                {
                    alert("Passwords don't match");
                    return false;
                }
                
                if(pass==npass)
                {
                    alert("New password must be different from old password");
                    return false;
                }
                
                
            }
        </script>
    </head>
    <body>
        <% 
            Connection con;
            Statement stmt;
            PreparedStatement pstmt;
            ResultSet rst;
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
                    
                    String password = rst.getString("a_password");
                    
                    String action = request.getParameter("a");
                    
                    if(action.equals("1"))
                    {
        %>
        <ul>
            <li><a href="ViewReservations.jsp">My Reservations</a></li>
                    <li><a href="MakeReservation.jsp">Make a Reservation</a></li>
                   <li> <a href="ChangePassword.jsp?a=1">Change Password</a></li>
                   <li> <a href="Logout">Logout</a></li>
        </ul>
        <br><br>
        <h2>Change Password</h2>
        <form name="passform" action="ChangePassword.jsp" method="get" onsubmit="return changePass()">
            <table>
                <tr>
                    <td>Current Password:</td>
                    <td><input type="password" name="cpass"></td>
                </tr>
                <tr>
                    <td>New Password:</td>
                    <td><input type="password" name="npass"></td>
                </tr>
                <tr>
                    <td>Confirm New Password:</td>
                    <td><input type="password" name="cnpass"></td>
                </tr>
            </table> 
            <input type="hidden" name="a" value="2">
            <input type="hidden" name="pass" value="<%=password%>">
            <br><input type="submit" value="Change Password">
        </form>
        
        
        <%
                    }
                    
                    else if(action.equals("2"))
                    {
                        String newPassword = request.getParameter("npass");
                        String sql = "UPDATE account SET a_password = ? WHERE a_username = ?";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, newPassword);
                        pstmt.setString(2, username);
                        pstmt.executeUpdate();
                        
                        response.sendRedirect("ViewReservations.jsp");
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
