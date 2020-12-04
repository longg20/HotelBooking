/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.controllers;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import longtt.daos.BookingDAO;
import longtt.daos.BookingDetailDAO;
import longtt.daos.CodeDAO;
import longtt.dtos.BookingDTO;
import longtt.dtos.RoomCart;
import longtt.dtos.RoomDTO;
import longtt.dtos.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class CartConfirmController extends HttpServlet {

    private static final String HOME = "LoadAreaController";
    private static final String INVALID = "verify.jsp";
    private static final Logger LOGGER = Logger.getLogger(CartConfirmController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = HOME;
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                String code = request.getParameter("txtCode");
                String checkCode = request.getParameter("txtCheckCode");
                boolean valid = true;
                if (!code.equals(checkCode)) {
                    valid = false;
                    url = INVALID;
                    request.setAttribute("CODE", code);
                    request.setAttribute("NOTICE", "Invalid code. Try again.");
                }
                if (valid) {
                    RoomCart cart = (RoomCart) session.getAttribute("CART");
                    if (cart != null) {
                        UserDTO userDTO = (UserDTO) session.getAttribute("USER");

                        if (userDTO != null && userDTO.getRole() == 1) { //user
                            BookingDTO bookingDTO;
                            if (cart.getCode() != null) {
                                CodeDAO codeDAO = new CodeDAO();
                                int discount = codeDAO.getCodeDiscountPercent(cart.getCode());
                                float total = cart.getTotal() - (cart.getTotal() * discount / 100);
                                codeDAO.updateCodeStatus(cart.getCode());
                                bookingDTO = new BookingDTO(userDTO.getUserId(), cart.getCheckinDate(), cart.getCheckoutDate(), cart.getCode(), total);
                            } else {
                                bookingDTO = new BookingDTO(userDTO.getUserId(), cart.getCheckinDate(), cart.getCheckoutDate(), cart.getTotal());
                            }
                            BookingDAO bookingDAO = new BookingDAO();

                            if (bookingDAO.createBooking(bookingDTO)) {
                                String bookingId = bookingDAO.getBookingId(userDTO.getUserId());
                                Iterator iterator = cart.getCart().entrySet().iterator();
                                BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                                while (iterator.hasNext()) {
                                    Map.Entry entry = (Map.Entry) iterator.next();
                                    RoomDTO roomDTO = (RoomDTO) entry.getValue();
                                    bookingDetailDAO.createBookingDetail(bookingId, roomDTO);
                                }
                                request.setAttribute("NOTICE", "Order is successfully sent. Your Booking ID is: " + bookingId);
                                session.removeAttribute("CART");
                            }
                        } else {
                            request.setAttribute("NOTICE", "Guest or Admin isn't allowed to book rooms.");
                        }
                    } else {
                        request.setAttribute("NOTICE", "Cart not found.");
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at CartConfirmController: " + e.getMessage());

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
