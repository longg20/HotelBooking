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
import longtt.daos.HotelDAO;
import longtt.dtos.RoomCart;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class SearchHotelController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchHotelController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String hotelName = request.getParameter("txtHotelNameSearch");
            String hotelArea = request.getParameter("txtHotelAreaSearch");
            String checkinDate = request.getParameter("txtCheckInDateSearch");
            String checkoutDate = request.getParameter("txtCheckOutDateSearch");
            String roomAmountStr = request.getParameter("txtRoomAmountSearch");
            int roomAmount;

            if (hotelName == null || hotelName.isEmpty()) {
                hotelName = "";
            }

            if (hotelArea == null || hotelArea.isEmpty()) {
                hotelArea = "";
            }

            if (roomAmountStr == null || roomAmountStr.isEmpty()) {
                roomAmount = 0;
            } else {
                roomAmount = Integer.parseInt(roomAmountStr);
            }

            HotelDAO hotelDAO = new HotelDAO();
            request.setAttribute("INFO", hotelDAO.getHotelsBySearch(hotelName, hotelArea, checkinDate, checkoutDate, roomAmount));

            HttpSession session = request.getSession(false);
            if (session != null) {
                RoomCart cart = (RoomCart) session.getAttribute("CART");
                if (cart != null) {
                    if (!cart.getCheckinDate().equals(checkinDate) || !cart.getCheckoutDate().equals(checkoutDate)) {
                        session.removeAttribute("CART");
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at SearchHotelController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("LoadAreaController").forward(request, response);
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
