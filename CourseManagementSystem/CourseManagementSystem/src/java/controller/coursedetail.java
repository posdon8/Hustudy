/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import model.enrollments;
import model.lessons;
import model.reviews;
import model.users;

/**
 *
 * @author admin
 */
@WebServlet(name = "coursedetail", urlPatterns = {"/coursedetail"})
public class coursedetail extends HttpServlet {

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
            out.println("<title>Servlet coursedetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet coursedetail at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        int userid = Integer.parseInt(request.getParameter("userid"));
        courseDAO cd = new courseDAO();
        courses c = cd.getCourseById(id);
        List<users> listu = cd.getAllUserByCourseId(c.getCourseid());
        session.setAttribute("listmember", listu);// member
        List<lessons> listl = cd.getAllLesson(c);// lesson
        session.setAttribute("listlesson", listl);
        for (int i = 0; i < listl.size(); i++) {
            List<document> listd = cd.getAllDocument(listl.get(i));// document
            String name = "listdoc" + listl.get(i).getLessonname();
            session.setAttribute(name, listd);
        }
        List<reviews> listr = cd.getAllReviewByCourseId(c.getCourseid());
        session.setAttribute("listreview", listr);// review
        int avgrate = 0;
        if (listr.size() == 0) {
            avgrate = 0;
        } else {
            int total = 0;
            for (int i = 0; i < listr.size(); i++) {
                total += listr.get(i).getRating();
            }
            avgrate = total / listr.size();
        }
        session.setAttribute("avgrate", avgrate);
        List<Float> perrate = cd.getPercentRate(listr);
        session.setAttribute("perrate", perrate);
        if (cd.checkEnrollment(userid, id)) {
            session.setAttribute("courses", c);
            response.sendRedirect("student.courseafterbuy.jsp");
        } else {
            session.setAttribute("courses", c);
            response.sendRedirect("student.coursedetail.jsp");
        }

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
