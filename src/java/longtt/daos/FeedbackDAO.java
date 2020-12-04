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
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import longtt.dtos.FeedbackDTO;

/**
 *
 * @author Long
 */
public class FeedbackDAO implements Serializable {

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
    
    public boolean createFeedback(FeedbackDTO dto) throws Exception {
        boolean check = false;
        try {
            String query = "Insert into tblFeedback(UserID, RoomID, Rating, Comment) values (?,?,?,?)";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, dto.getUserId());
            preStm.setInt(2, dto.getRoomId());
            preStm.setFloat(3, dto.getRating());
            preStm.setString(4, dto.getComment());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean UpdateFeedback(FeedbackDTO dto) throws Exception {
        boolean check = false;
        try {
            String query = "Update tblFeedback set Rating = ?, Comment = ? where UserID = ? AND RoomID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setFloat(1, dto.getRating());
            preStm.setString(2, dto.getComment());
            preStm.setString(3, dto.getUserId());
            preStm.setInt(4, dto.getRoomId());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean checkFeedbackExist(String userId, int roomId) throws Exception {
        boolean exist = false;
        try {
            String query = "Select FeedbackID from tblFeedback where UserID = ? AND RoomID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, userId);
            preStm.setInt(2, roomId);
            rs = preStm.executeQuery();
            if (rs.next())
                exist = true;
        } finally {
            closeConnection();
        }
        return exist;
    }
}
