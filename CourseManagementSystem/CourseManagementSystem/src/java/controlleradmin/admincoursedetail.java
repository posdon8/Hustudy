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
import model.courses;
import model.document;
import model.grades;
import model.lessons;
import model.reviews;
import model.users;

/**
 *
 * @author admin
 */
@WebServlet(name = "admincoursedetail", urlPatterns = {"/admincoursedetail"})
public class admincoursedetail extends HttpServlet {

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
            out.println("<title>Servlet admincoursedetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet admincoursedetail at " + request.getContextPath() + "</h1>");
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
        int courseid = Integer.parseInt(request.getParameter("id"));
        courseDAO cd = new courseDAO();
        courses c = cd.getCourseById(courseid);
        session.setAttribute("course", c);// course
        List<users> listuser = cd.getAllUserByCourseId(courseid); // member
        session.setAttribute("listuser", listuser);
        List<grades> listgrade = cd.getAllGradeByCourse(courseid); // grade
        session.setAttribute("listgrade", listgrade);
        List<lessons> listlesson = cd.getAllLesson(c);// lesson
        session.setAttribute("listlesson", listlesson);
        for (int i = 0; i < listlesson.size(); i++) {
            List<document> listdocument = cd.getAllDocument(listlesson.get(i));// document
            String name = "listdoc" + listlesson.get(i).getLessonname();
            session.setAttribute(name, listdocument);
        }
        List<reviews> listreview = cd.getAllReviewByCourseId(c.getCourseid());
        session.setAttribute("listreview", listreview);// review
        int total = 0;
        for (int i = 0; i < listreview.size(); i++) {
            total += listreview.get(i).getRating();
        }
        float avgrate = (float) total / listreview.size();
        float roundedAvgRate = (float) (Math.round(avgrate * 10.0) / 10.0);
        session.setAttribute("avgrate", roundedAvgRate);
        List<Float> perrate = cd.getPercentRate(listreview);
        session.setAttribute("perrate", perrate);
        response.sendRedirect("admin.coursedetail.jsp");
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
