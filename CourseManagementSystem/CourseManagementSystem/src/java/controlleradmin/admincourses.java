/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controlleradmin;

import dal.courseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.category;
import model.courses;
import model.typecourse;

/**
 *
 * @author admin
 */
@WebServlet(name="admincourses", urlPatterns={"/admincourses"})
public class admincourses extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet admincourses</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet admincourses at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
        courseDAO cd = new courseDAO();
        List<courses> courses = cd.getAllCourse();
        List<category> category = cd.getAllCategory();
        session.setAttribute("listcate", category);
        for (int i = 0; i < category.size(); i++) {
            List<typecourse> type = cd.getAllTypecourseByCategory(category.get(i).getCategoryid());
            String typename = "type" + category.get(i).getCategoryname();
            session.setAttribute(typename, type);  
            out.println(category.get(i).getCategoryname());
            out.println(typename);
            for ( int j = 0 ; j < type.size() ; j++ ){
                out.println(type.get(j).getTypecoursename());
            }
        }
        session.setAttribute("courses", courses);
        response.sendRedirect("admin.courses.jsp");
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
