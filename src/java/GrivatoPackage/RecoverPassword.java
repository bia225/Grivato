package GrivatoPackage;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet(name = "RecoverPassword", urlPatterns = {"/RecoverPassword"})
public class RecoverPassword extends HttpServlet {

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
            
            out = response.getWriter();
            
            
            stmt = con.createStatement();
            String username = request.getParameter("username").toLowerCase();
            rst = stmt.executeQuery("SELECT c_email, a_password FROM account, client WHERE a_username = \"" + username + "\" AND a_c_id = c_id");
            
            if(rst.next())
            {
                String to = rst.getString("c_email");
                String subject = "Password Recovery";
                
                String userPassword = rst.getString("a_password");
                String message = "Dear Customer,\n\nYour password is: " + userPassword + "\n\nRegards,\nGrivato Team";
                
                
                SendMail.send(to, subject, message);
                
                out.println("<meta http-equiv='refresh' content='3;URL=index.html'>");//redirects after 3 seconds
                out.println("Your password has been sent to your email");
            }
            else
            {
                out.println("<meta http-equiv='refresh' content='3;URL=index.html'>");//redirects after 3 seconds
                out.println("Username doesn't exist");
                
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
