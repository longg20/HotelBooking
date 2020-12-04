/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import longtt.daos.UserDAO;
import longtt.utilities.sha256;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class ResetConfirmController extends HttpServlet {

    private static final String SUCCESS = "login.jsp";
    private static final String INVALID = "forget.jsp";
    private static final Logger LOGGER = Logger.getLogger(ResetMailController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SUCCESS;
        try {
            String code = request.getParameter("txtCode");
            String checkCode = request.getParameter("txtCheckCode");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("txtConfirm");
            String email = request.getParameter("txtId");

            boolean valid = true;
            if (!code.equals(checkCode)) {
                valid = false;
                url = INVALID;
                request.setAttribute("CODE", code);
                request.setAttribute("EMAIL", email);
                request.setAttribute("NOTICE", "Invalid code. Try again.");
            }
            if (!password.equals(confirm)) {
                valid = false;
                url = INVALID;
                request.setAttribute("CODE", code);
                request.setAttribute("EMAIL", email);
                request.setAttribute("NOTICE", "Confirm must match Password.");
            }

            if (valid) {
                password = sha256.encrypt(password);
                UserDAO userDAO = new UserDAO();
                if (userDAO.changePasswordById(email, password)) {
                    request.setAttribute("NOTICE", "Password changed successfully.");
                }
            }
        } catch (Exception e) {
            LOGGER.error("Error at ResetMailController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
