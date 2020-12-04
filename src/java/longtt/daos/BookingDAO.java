/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import longtt.dtos.BookingDTO;

/**
 *
 * @author Long
 */
public class BookingDAO implements Serializable {

    private Connection conn = null;
    private PreparedStatement preStm = null;
    private ResultSet rs = null;

    private void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public static Connection getMyConnection() throws Exception {
        Connection conn = null;
        Context context = new InitialContext();
        Context end = (Context) context.lookup("java:comp/env");
        DataSource ds = (DataSource) end.lookup("DBCon");
        conn = ds.getConnection();
        return conn;
    }
    
    public boolean createBooking(BookingDTO dto) throws Exception {
        boolean check = false;
        try {
            String query = "Insert into tblBooking(BookingID,UserID,[Booking Date],[CheckIn Date],[CheckOut Date],Total,Code,Status) "
                         + "values (NEWID(),?,GETDATE(),?,?,?,?,1)";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, dto.getUserId());
            preStm.setString(2, dto.getCheckinDate());
            preStm.setString(3, dto.getCheckoutDate());
            preStm.setFloat(4, dto.getTotal());
            preStm.setString(5, dto.getCode());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public String getBookingId(String userId) throws Exception {
        String bookingId = null;
        try {
            String query = "SELECT TOP 1 BookingID FROM tblBooking Where UserID = ? ORDER BY [Booking Date] DESC";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, userId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                bookingId = rs.getString("BookingID");
            }
        } finally {
            closeConnection();
        }
        return bookingId;
    }
    
    public List<BookingDTO> getBookingsByLikeId(String search, String searchDate, String userId) throws Exception {
        List<BookingDTO> list = new ArrayList<>();
        BookingDTO dto = null;
        String bookingId, bookingDate, checkinDate, checkoutDate, code;
        float total;
        try {
            String query = "Select BookingID, convert(varchar,[Booking Date],0) as [Book Date], "
                         + "convert(varchar,[Checkin Date],0) as [Checkin Date], "
                         + "convert(varchar,[Checkout Date],0) as [Checkout Date], Total, Code "
                         + "from tblBooking "
                         + "Where BookingID LIKE ? AND convert(varchar, [Booking Date], 25) LIKE ? AND UserID = ? AND Status = 1 "
                         + "Order By [Booking Date] DESC";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, "%" + search + "%");
            preStm.setString(2, "%" + searchDate + "%");
            preStm.setString(3, userId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                bookingId = rs.getString("BookingID");
                bookingDate = rs.getString("Book Date");
                checkinDate = rs.getString("Checkin Date");
                checkoutDate = rs.getString("Checkout Date");
                total = rs.getFloat("Total");
                code = rs.getString("Code");
                if (code == null || code.isEmpty())
                    code = "None";
                dto = new BookingDTO(bookingId, userId, bookingDate, checkinDate, checkoutDate, total, code, 1);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
    
    public BookingDTO getBookingById(String bookingId) throws Exception {
        BookingDTO dto = null;
        String userId, bookingDate, checkinDate, checkoutDate, checkoutDateBeforeConvert, code;
        float total;
        try {
            String query = "Select UserID, convert(varchar,[Booking Date],0) as [Book Date], "
                         + "convert(varchar,[Checkin Date],0) as [Checkin Date], "
                         + "convert(varchar,[Checkout Date],0) as [Converted Checkout Date], Total, Code, [Checkout Date] "
                         + "from tblBooking "
                         + "Where BookingID = ? AND Status = 1";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, bookingId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                userId = rs.getString("UserID");
                bookingDate = rs.getString("Book Date");
                checkinDate = rs.getString("Checkin Date");
                checkoutDate = rs.getString("Converted Checkout Date");
                checkoutDateBeforeConvert = rs.getString("Checkout Date");
                total = rs.getFloat("Total");
                code = rs.getString("Code");
                if (code == null || code.isEmpty())
                    code = "None";
                dto = new BookingDTO(bookingId, userId, bookingDate, checkinDate, checkoutDate, total, code, 1);
                dto.setCheckOutDateBeforeConvert(checkoutDateBeforeConvert);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean deleteBookingById(String bookingId) throws Exception {
        boolean check = false;
        try {
            String query = "Update tblBooking set Status = 0 where BookingID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, bookingId);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}
