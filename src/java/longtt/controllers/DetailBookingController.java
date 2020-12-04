/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import longtt.daos.BookingDAO;
import longtt.daos.BookingDetailDAO;
import longtt.dtos.BookingDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class DetailBookingController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DetailBookingController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String bookingId = request.getParameter("txtBookingId");
            BookingDAO bookingDAO = new BookingDAO();
            BookingDTO bookingDTO = bookingDAO.getBookingById(bookingId);
            BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
            
            boolean feedback = false;
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date today = new Date();
            Date checkoutDate = df.parse(bookingDTO.getCheckOutDateBeforeConvert());
            if (checkoutDate.compareTo(today) < 0) {
                feedback = true;
            }
            
            request.setAttribute("BOOKING", bookingDTO);
            request.setAttribute("DETAIL", bookingDetailDAO.getBookingDetailsByBookingId(bookingId));
            request.setAttribute("FEEDBACK", feedback);
        } catch (Exception e) {
            LOGGER.error("ERROR at DetailBookingController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("bookingHistoryDetail.jsp").forward(request, response);
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
