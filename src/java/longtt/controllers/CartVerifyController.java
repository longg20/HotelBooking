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
import longtt.daos.CodeDAO;
import longtt.dtos.RoomCart;
import longtt.dtos.UserDTO;
import longtt.utilities.MailObj;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class CartVerifyController extends HttpServlet {

    private static final String SUCCESS = "verify.jsp";
    private static final String INVALID = "detailCart.jsp";
    private static final Logger LOGGER = Logger.getLogger(CartVerifyController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SUCCESS;
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                boolean valid = true;
                String codeId = request.getParameter("txtCodeId");

                if (codeId == null || codeId.isEmpty()) {
                    codeId = "";
                }

                if (!codeId.trim().equals("")) {
                    CodeDAO codeDAO = new CodeDAO();
                    if (codeDAO.checkCodeIdExist(codeId) == true) {
                        RoomCart cart = (RoomCart) session.getAttribute("CART");
                        cart.setCode(codeId);
                    } else {
                        url = INVALID;
                        valid = false;
                        request.setAttribute("NOTICE", "Discount Code not found, expired or already used. Try another.");
                    }
                }
                if (valid) {
                    UserDTO userDTO = (UserDTO) session.getAttribute("USER");
                    String code = MailObj.sendMail(userDTO.getUserId(), "ConfirmCart");
                    request.setAttribute("CODE", code);
                }
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at CartVerifyController: " + e.getMessage());
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
