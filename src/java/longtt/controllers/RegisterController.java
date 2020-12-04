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
import longtt.dtos.UserDTO;
import longtt.utilities.sha256;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class RegisterController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegisterController.class);
    private static final String INVALID = "register.jsp";
    private static final String SUCCESS = "LoadAreaController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID;
        try {
            String id = request.getParameter("txtId");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("txtConfirm");
            String name = request.getParameter("txtName");
            String phone = request.getParameter("txtPhone");
            String address = request.getParameter("txtAddress");
            
            UserDAO userDAO = new UserDAO();
            boolean valid = true;
            if (!password.equals(confirm)) {
                valid = false;
                request.setAttribute("NOTICE", "Confirm must match Password.");
            }
            if (userDAO.checkUserIdExist(id) == true) {
                valid = false;
                request.setAttribute("NOTICE", "Email exist. Try another.");
            }
            
            if (valid) {
                password = sha256.encrypt(password);
                UserDTO userDTO = new UserDTO(id, name, phone, address);
                userDTO.setPassword(password);
                if (userDAO.createUser(userDTO)) {
                    url = SUCCESS;
                    request.setAttribute("NOTICE", "New account created successfully.");
                }
            }
        } catch (Exception e) {
            LOGGER.error("Error at RegisterController: " + e.getMessage());
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
