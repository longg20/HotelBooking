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
import longtt.daos.HotelDAO;
import longtt.daos.RoomDAO;
import org.apache.log4j.Logger;

/**
 *
 * @author Long
 */
public class DetailHotelController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DetailHotelController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int hotelId = Integer.parseInt(request.getParameter("txtHotelId"));
            String checkinDate = request.getParameter("txtCheckInDateSearch");
            String checkoutDate = request.getParameter("txtCheckOutDateSearch");
            
            RoomDAO roomDAO = new RoomDAO();
            HotelDAO hotelDAO = new HotelDAO();
            request.setAttribute("ROOM", roomDAO.getRoomsByHotelId(hotelId, checkinDate, checkoutDate));
            request.setAttribute("HOTEL", hotelDAO.getHotelById(hotelId));
        } catch (Exception e) {
            LOGGER.error("ERROR at DetailHotelController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("detailHotel.jsp").forward(request, response);
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
