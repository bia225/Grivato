<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grivato | Packages</title>
        <link href="CSS/Packages.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function addPackage()
            {
                window.location = "UpdatePackages.jsp?a=a";
            }

            function deletePackage(id)
            {
                if(confirm("Are you sure you want to delete this package?"))
                    window.location = "UpdatePackages.jsp?a=d&id= " + id;
            }
        </script>
    </head>
    <body>
        <%

            Connection con;
            Statement stmt,stmt2;
            ResultSet rst, rst2;
            try
            {   
                session = request.getSession(false);
                if(session.getAttribute("admin")!=null)
                {
                    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato", "root", "");
                    stmt = con.createStatement();
                    stmt2 = con.createStatement();
                    
        %>
               <ul>        
            <li><a href="Resorts.jsp">Resorts</a></li>
           <li> <a href="Packages.jsp">Packages</a></li>
           <li> <a href="Reservations.jsp">Reservations</a>  </li>  
           <li> <a href="Logout">Logout</a><br></li>
           </ul>
        <%
                    rst = stmt.executeQuery("SELECT * FROM package");
                    
                    if(rst.next())
                    {
                        do{
                            rst2 = stmt2.executeQuery("SELECT r_name FROM resort WHERE r_id = " + rst.getInt("p_r_id"));
                            if(rst2.next());
        %>
        <div class="packages">
        <h3><a href="UpdatePackages.jsp?a=u&id=<%=rst.getInt("p_id")%>"><%=rst.getInt("p_id")%></a> - <%=rst2.getString("r_name")%></h3>
            <img src="<%=rst.getString("p_img")%>"><img>
            <p><%=rst.getString("p_details")%></p>
            From: <%=rst.getDate("p_from")%> To: <%=rst.getDate("p_to")%><br>
            Price: <%=rst.getDouble("p_price")%>$<br>
            <br><button onclick="deletePackage(<%=rst.getInt("p_id")%>)">Delete</button>
            </div>
        <%
                        }while(rst.next());
                    }
                    
                    else
                    {
                        out.println("No packages found");
                    }
                
                }
           
                else
                {
                    out.print("<Access Denied... Please <a href='index.html'>login</a> first... ");
                
                }
        %>
            <br><br><button onclick="addPackage()">Add Package</button>
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
