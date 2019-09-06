package GrivatoPackage;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet(name = "CreateAccount", urlPatterns = {"/CreateAccount"})
public class CreateAccount extends HttpServlet {
    Connection con;
    PreparedStatement pstmt;
    Statement stmt;
    Statement stmt2;
    ResultSet rst;
    ResultSet rst2;
    PrintWriter out;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try{
            out = response.getWriter();
            
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/grivato","root","");
            
            out = response.getWriter();
            
            String username = request.getParameter("user").toLowerCase();
            String password = request.getParameter("pass");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            int phone = Integer.parseInt(request.getParameter("phone"));
            String email = request.getParameter("email").toLowerCase();
            
            stmt = con.createStatement();
            stmt2 = con.createStatement();
            rst = stmt.executeQuery("SELECT a_username from account WHERE a_username = \"" + username +"\"");
            rst2 = stmt2.executeQuery("SELECT c_email from client WHERE c_email = \"" + email +"\"");
            
            
            if(rst.next())
            {
                out.println("<meta http-equiv='refresh' content='2;URL=CreateAccount.html'>");//redirects after 3 seconds
                out.println("<font color='red'>Username Already Exists...</font>");
            }
            
            else if(rst2.next())
            {
                out.println("<meta http-equiv='refresh' content='2;URL=CreateAccount.html'>");//redirects after 3 seconds
                out.println("<font color='red'>Email Already Used...</font>");
            }
            
            else
            {
                pstmt = con.prepareStatement("INSERT INTO client VALUES(NULL, ?, ?, ?, ?)");
                pstmt.setString(1, fname);
                pstmt.setString(2, lname);
                pstmt.setInt(3, phone);
                pstmt.setString(4, email);
                pstmt.executeUpdate();

                pstmt = con.prepareStatement("INSERT INTO account VALUES(?, ?, 0, (SELECT MAX(c_id) FROM CLIENT), 0)");
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.executeUpdate();
                    
                
                String link = "http://localhost:8080/Grivato/ActivateAccount?user=" + username;
                String message = "Dear Customer,\n\nThank you for creating a Grivato account!\nGo to the link below to activate your account: " + link + "\n\nRegards,\nGrivato Team";
                SendMail.send(email, "Activate Account", message);
                
                out.println("<meta http-equiv='refresh' content='3;URL=index.html'>");
                out.println("Account Created Successfully!");
                out.println("Check your email to activate your account!");
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

