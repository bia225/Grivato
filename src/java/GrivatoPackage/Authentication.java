package GrivatoPackage;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Authentication", urlPatterns = {"/Authentication"})
public class Authentication extends HttpServlet {

    Connection con;
    Statement stmt;
    ResultSet rst;
    PrintWriter out;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try{
            out = response.getWriter();
        
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato","root","");

            stmt = con.createStatement();

            String username = request.getParameter("user").toLowerCase();
            String password = request.getParameter("pass");
                
            rst = stmt.executeQuery("SELECT * FROM account WHERE a_username = '" + username + "'"); 


            if (rst.next())
            {
                if(password.equals(rst.getString("a_password")))
                {
                    if(rst.getBoolean("a_isVerified"))
                    {
                        HttpSession session;
                    
                        if(rst.getBoolean("a_isAdmin"))
                        {
                            session = request.getSession();
                            session.setAttribute("admin", true);
                            response.sendRedirect("Admin.jsp");
                        }

                        else
                        {
                            session = request.getSession();  
                            session.setAttribute("user", username);
                            response.sendRedirect("ViewReservations.jsp");
                        }
                    }
                    
                    else
                    {
                        out.println("<meta http-equiv='refresh' content='2;URL=index.html'>");//redirects after 3 seconds
                        out.println("Please activate you account first...");    
                    }
                    
                }

                else
                {
                    out.println("<meta http-equiv='refresh' content='2;URL=index.html'>");//redirects after 3 seconds
                    out.println("Invalid Password...");
                }
            }
            else
            {
                out.println("<meta http-equiv='refresh' content='2;URL=index.html'>");//redirects after 3 seconds
                out.println("Invalid Username...");
            }
            
        }catch(SQLException e)
        {
            out.println("SQL Exception: " + e);
            
        }catch(Exception e)
        {
            out.println("General Exception: " + e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
