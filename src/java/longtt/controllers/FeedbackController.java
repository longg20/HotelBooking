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
import longtt.daos.FeedbackDAO;
import longtt.dtos.FeedbackDTO;
import longtt.dtos.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class FeedbackController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(FeedbackController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                UserDTO userDTO = (UserDTO) session.getAttribute("USER");
                if (userDTO != null && userDTO.getRole() == 1) {
                    int roomId = Integer.parseInt(request.getParameter("txtRoomId"));
                    float rating = Float.parseFloat(request.getParameter("txtRating"));
                    String comment = request.getParameter("txtComment");
                    if (comment == null || comment.isEmpty()) {
                        comment = "";
                    }

                    FeedbackDTO feedbackDTO = new FeedbackDTO(userDTO.getUserId(), roomId, rating, comment);
                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    if (feedbackDAO.checkFeedbackExist(userDTO.getUserId(), roomId) == true) {
                        feedbackDAO.UpdateFeedback(feedbackDTO);
                        request.setAttribute("NOTICE", "Your feedback is updated.");
                    } else {
                        feedbackDAO.createFeedback(feedbackDTO);
                        request.setAttribute("NOTICE", "Your feedback is sent. Thank you.");
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at FeedbackController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("DetailBookingController").forward(request, response);
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
