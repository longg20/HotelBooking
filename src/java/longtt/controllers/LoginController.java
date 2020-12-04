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
import javax.servlet.http.HttpSession;
import longtt.daos.UserDAO;
import longtt.dtos.UserDTO;
import longtt.utilities.VerifyUtils;
import longtt.utilities.sha256;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class LoginController extends HttpServlet {

    private static final String USER = "LoadAreaController";
    private static final String ADMIN = "home.jsp";
    private static final String INVALID = "login.jsp";
    private static final Logger LOGGER = Logger.getLogger(LoginController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID;
        try {
            String id = request.getParameter("txtId");
            String password = request.getParameter("txtPassword");
            password = sha256.encrypt(password);

            boolean valid = true;
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
            valid = VerifyUtils.verify(gRecaptchaResponse);

            if (valid) {
                UserDAO udao = new UserDAO();
                UserDTO udto = udao.checkLogin(id, password);
                if (udto == null) {
                    request.setAttribute("NOTICE", "Invalid Username or Password");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("USER", udto);
                    if (udto.getRole() == 1) {
                        url = USER;
                    } else if (udto.getRole() == 2) {
                        url = ADMIN;
                    }
                }
            } else {
                request.setAttribute("NOTICE", "Invalid Captcha");
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at LoginController: " + e.getMessage());
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
