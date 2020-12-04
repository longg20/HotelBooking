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
import longtt.daos.RoomDAO;
import longtt.dtos.RoomCart;
import longtt.dtos.RoomDTO;
import longtt.dtos.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class CartAddController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CartAddController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                String roomIdStr = request.getParameter("txtRoomId");
                String typeName = request.getParameter("txtTypeName");
                String checkinDate = request.getParameter("txtCheckInDateSearch");
                String checkoutDate = request.getParameter("txtCheckOutDateSearch");
                int roomId = Integer.parseInt(roomIdStr);
                int vacant = Integer.parseInt(request.getParameter("txtVacant"));
                RoomDAO roomDAO = new RoomDAO();
                RoomDTO roomDTO = roomDAO.getRoomById(roomId);
                HotelDAO hotelDAO = new HotelDAO();
                roomDTO.setCartQty(1);
                roomDTO.setTypeName(typeName);
                roomDTO.setHotelName(hotelDAO.getHotelNameById(roomDTO.getHotelId()));
                roomDTO.setVacant(vacant);

                UserDTO userDTO = (UserDTO) session.getAttribute("USER");
                RoomCart cart = (RoomCart) session.getAttribute("CART");

                if (cart == null) {
                    if (userDTO != null && userDTO.getRole() == 1) {
                        cart = new RoomCart(userDTO.getUserId());
                        cart.setCheckinDate(checkinDate);
                        cart.setCheckoutDate(checkoutDate);
                    }
                }
                if (cart != null) {
                    boolean valid = true;
                    if (vacant <= 0) {
                        valid = false;
                        request.setAttribute("NOTICE", "Amount exceed maximum quantity of vacant rooms.");
                    }
                    if (cart.getCart().get(roomId) != null) {
                        if (cart.getCart().get(roomId).getCartQty() + 1 > vacant) {
                            valid = false;
                            request.setAttribute("NOTICE", "Amount exceed maximum quantity of vacant rooms.");
                        }
                    }

                    if (valid) {
                        cart.addToCart(roomDTO);
                        cart.setTotal(cart.getTotal());
                        session.setAttribute("CART", cart);
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at CartAddController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("DetailHotelController").forward(request, response);
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
