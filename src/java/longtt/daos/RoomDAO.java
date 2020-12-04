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
import longtt.dtos.RoomDTO;

/**
 *
 * @author Long
 */
public class RoomDAO implements Serializable {

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
    
    public RoomDTO getRoomById(int roomId) throws Exception {
        RoomDTO dto = null;
        try {
            String query = "Select HotelID, Type, Price, Quantity from tblRoom where RoomID = ? AND Status = 1";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setInt(1, roomId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                int hotelId = rs.getInt("HotelID");
                int type = rs.getInt("Type");
                float price = rs.getFloat("Price");
                int quantity = rs.getInt("Quantity");
                dto = new RoomDTO(roomId, hotelId, type, price, quantity, 1);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public List<RoomDTO> getRoomsByHotelId(int hotelId, String checkInDate, String checkOutDate) throws Exception {
        List<RoomDTO> list = new ArrayList<>();
        RoomDTO dto = null;
        String typeName;
        int roomId, type, quantity, vacant;
        float price;
        try {
            String query = "Select C.RoomID, C.Type, D.Name as [Type Name], C.Price, C.Quantity, "
                         + "C.Quantity - COALESCE(SUM(A.Quantity),0) as [Vacant Room] "
                         + "from tblBookingDetail A JOIN tblBooking B ON A.BookingID = B.BookingID AND B.Status = 1 "
                         + "AND B.[CheckOut Date] >= ? AND B.[CheckIn Date] <= ? "
                         + "RIGHT JOIN tblRoom C ON A.RoomID = C.RoomID "
                         + "JOIN tblRoomType D ON C.Type = D.RoomTypeID "
                         + "Where C.Status = 1 AND C.HotelID = ? "
                         + "GROUP BY C.RoomID, C.Type, D.Name, C.Price, C.Quantity";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, checkInDate);
            preStm.setString(2, checkOutDate);
            preStm.setInt(3, hotelId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                roomId = rs.getInt("RoomID");
                type = rs.getInt("Type");
                typeName = rs.getString("Type Name");
                price = rs.getFloat("Price");
                quantity = rs.getInt("Quantity");
                vacant = rs.getInt("Vacant Room");
                if (vacant < 0)
                    vacant = 0;
                dto = new RoomDTO(roomId, hotelId, type, price, quantity, 1);
                dto.setVacant(vacant);
                dto.setTypeName(typeName);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
}
