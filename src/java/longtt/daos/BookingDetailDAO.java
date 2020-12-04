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
import longtt.dtos.BookingDetailDTO;
import longtt.dtos.RoomDTO;

/**
 *
 * @author Long
 */
public class BookingDetailDAO implements Serializable {

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
    
    public boolean createBookingDetail(String bookingId, RoomDTO room) throws Exception {
        boolean check = false;
        try {
            String query = "Insert into tblBookingDetail(BookingID,RoomID,Quantity,Total) "
                         + "values (?,?,?,?)";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, bookingId);
            preStm.setInt(2, room.getRoomId());
            preStm.setInt(3, room.getCartQty());
            preStm.setFloat(4, room.getCartQty() * room.getPrice());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public List<BookingDetailDTO> getBookingDetailsByBookingId(String bookingId) throws Exception {
        List<BookingDetailDTO> list = new ArrayList<>();
        BookingDetailDTO dto = null;
        String typeName, hotelName;
        int bookingDetailId, roomId, quantity;
        float total;
        try {
            String query = "Select A.BookingDetailID, A.RoomID, C.Name as [Type Name], A.Quantity, D.Name as [Hotel Name], A.Total "
                         + "From tblBookingDetail A, tblRoom B, tblRoomType C, tblHotel D "
                         + "Where A.RoomID = B.RoomID AND B.Type = C.RoomTypeID AND B.HotelID = D.HotelID AND A.BookingID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, bookingId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                bookingDetailId = rs.getInt("BookingDetailID");
                roomId = rs.getInt("RoomID");
                typeName = rs.getString("Type Name");
                quantity = rs.getInt("Quantity");
                hotelName = rs.getString("Hotel Name");
                total = rs.getFloat("Total");
                dto = new BookingDetailDTO(bookingDetailId, bookingId, roomId, quantity, total);
                dto.setTypeName(typeName);
                dto.setHotelName(hotelName);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
