<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grivato | Resorts</title>
        <link href="CSS/Resorts.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function addResort()
            {
                window.location = "UpdateResorts.jsp?a=a";
            }

            function deleteResort(id)
            {
                if(confirm("Are you sure you want to delete this resort?"))window.location = "UpdateResorts.jsp?a=d&id= " + id;
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
                    rst = stmt.executeQuery("SELECT * FROM resort");
                    
                    if(rst.next())
                    {
        %>
        <br><br><br><br> <table border="1">
                <thead>
                <th>Resort ID</th>
                <th>Resort Name</th>
                <th>Resort Location</th>
                </thead>
        <%                
                        do{
        %>
                <tr>
                    <td><a href="UpdateResorts.jsp?a=u&id=<%=rst.getInt("r_id")%>"><%=rst.getInt("r_id")%></a></td>
                    <td><%=rst.getString("r_name")%></td>    
                    <td><%=rst.getString("r_location")%></td>
                    <td><button onclick="deleteResort(<%=rst.getInt("r_id")%>)">Delete</button></td>   
                </tr>
        <%
                        }while(rst.next());
        %>
            </table>
        <%
                    }
                    
                    else
                    {
                        out.println("No resorts found");
                    }
                
                }
           
                else
                {
                    out.print("<Access Denied... Please <a href='index.html'>login</a> first... ");
                
                }
        %>
            <br><br><br><button onclick="addResort()">Add Resort</button>
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
