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
import longtt.dtos.HotelDTO;

/**
 *
 * @author Long
 */
public class HotelDAO implements Serializable {

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
    
    public List<HotelDTO> getHotelsBySearch(String hotelNameSearch, String hotelAreaSearch, String checkInDate, 
                                              String checkOutDate, int roomAmount) throws Exception {
        List<HotelDTO> list = new ArrayList<>();
        HotelDTO dto = null;
        String hotelName, hotelArea, image, areaName;
        int hotelId, roomQuantity;
        try {
            String query = "Select T1.HotelID, [Hotel Name], T1.Area, [Area Name], T1.Image, [Room Quantity] - [Booked Room] as [Vacant Room] "
                         + "From ( "
                         + "Select C.HotelID, D.Name as [Hotel Name], D.Area, E.Name as [Area Name], D.Image, "
                         + "COALESCE(SUM(A.Quantity),0) as [Booked Room] "
                         + "from tblBookingDetail A JOIN tblBooking B ON A.BookingID = B.BookingID AND B.Status = 1 "
                         + "AND B.[CheckOut Date] >= ? AND B.[CheckIn Date] <= ? "
                         + "RIGHT JOIN tblRoom C ON A.RoomID = C.RoomID "
                         + "JOIN tblHotel D ON C.HotelID = D.HotelID AND D.Name LIKE ? AND D.Area LIKE ? " 
                         + "JOIN tblArea E ON D.Area = E.AreaID "
                         + "GROUP BY C.HotelID, D.Area, D.Name, E.Name, D.Image "
                         + ") T1 JOIN ( "
                         + "Select A.HotelID, SUM(A.Quantity) as [Room Quantity] "
                         + "From tblRoom A "
                         + "Group By A.HotelID "
                         + ") T2 ON T1.HotelID = T2.HotelID "
                         + "Group By T1.HotelID, [Hotel Name], T1.Area, [Area Name], T1.Image, [Room Quantity], [Booked Room] "
                         + "Having [Room Quantity] - [Booked Room] >= ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, checkInDate);
            preStm.setString(2, checkOutDate);
            preStm.setString(3, "%" + hotelNameSearch + "%");
            preStm.setString(4, "%" + hotelAreaSearch + "%");
            preStm.setInt(5, roomAmount);
            rs = preStm.executeQuery();
            while (rs.next()) {
                hotelId = rs.getInt("HotelID");
                hotelName = rs.getString("Hotel Name");
                hotelArea = rs.getString("Area");
                areaName = rs.getString("Area Name");
                image = rs.getString("Image");
                roomQuantity = rs.getInt("Vacant Room");
                dto = new HotelDTO(hotelId, hotelName, hotelArea, image, 1);
                dto.setRoomAmount(roomQuantity);
                dto.setAreaName(areaName);
                list.add(dto);
            }
        } finally {
            closeConnection();
        }
        return list;
    }
    
    public String getHotelNameById(int hotelId) throws Exception {
        String name = null;
        try {
            String query = "Select Name from tblHotel where HotelID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setInt(1, hotelId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                name = rs.getString("Name");
            }
        } finally {
            closeConnection();
        }
        return name;
    }
    
    public HotelDTO getHotelById(int hotelId) throws Exception {
        HotelDTO dto = null;
        try {
            String query = "Select A.Name, A.Area, A.Image, B.Name as [Area Name] "
                         + "from tblHotel A, tblArea B "
                         + "where A.Area = B.AreaID AND A.HotelID = ? AND A.Status = 1";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setInt(1, hotelId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("Name");
                String area = rs.getString("Area");
                String image = rs.getString("Image");
                String areaName = rs.getString("Area Name");
                dto = new HotelDTO(hotelId, name, area, image, 1);
                dto.setAreaName(areaName);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
}
