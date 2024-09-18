/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.accountDAO;
import dal.adminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import model.users;

/**
 *
 * @author admin
 */
@WebServlet(name = "getcode", urlPatterns = {"/getcode"})
public class getcode extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getcode</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getcode at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int sessionTimeout = 1800;
        session.setMaxInactiveInterval(sessionTimeout);
        String username = (String) session.getAttribute("username");
        accountDAO ad = new accountDAO();
        adminDAO adm = new adminDAO();
        users u = ad.findUserByUsername(username);
        String email = u.getEmail();
        Random random = new Random();
        int minRange = 1000;
        int maxRange = 9999;
        int randomNumber = random.nextInt(maxRange - minRange + 1) + minRange;
        String useremail = "daohien868@gmail.com";// Them 
        String passapi = "ajwx gmyd muzp npxb";//Them
        adm.sendOne(useremail, passapi, u.getEmail(), "New password !", String.valueOf(randomNumber));
        session.setAttribute("codefg", randomNumber);
        response.sendRedirect("getcode.jsp");
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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        int sessionTimeout = 1800;
        session.setMaxInactiveInterval(sessionTimeout);
        String username = request.getParameter("username");
        accountDAO ad = new accountDAO();
        adminDAO adm = new adminDAO();
        users u = ad.findUserByUsername(username);
        String code = request.getParameter("code");
        String codefg = request.getParameter("codefg");
        if ( codefg.equals(code)){
            ad.updateInfo( u.getUserid(),u.getUsername(), code, u.getFullname(), u.getEmail(), u.getAvatar());
            if (u.getRole().equals("student")) {
                session.setAttribute("user", u);
                response.sendRedirect("studenthome");
            } else if (u.getRole().equals("lecturer")) {
                session.setAttribute("user", u);
                adm.addAllSchedulesForAllLect();
                response.sendRedirect("lecturerhome");
            }
        } else {
            String mescodefg = "Code is incorrect!";
            session.setAttribute("mescodefg", mescodefg);
            response.sendRedirect("getcode.jsp");
        }
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
