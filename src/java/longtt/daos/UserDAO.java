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
import longtt.dtos.UserDTO;

/**
 *
 * @author Long
 */
public class UserDAO implements Serializable {

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

    public UserDTO checkLogin(String userId, String password) throws Exception {
        UserDTO dto = null;
        try {
            String query = "Select Name, Phone, Address, [Create Date], Role from tblUser where UserID = ? AND Password = ? AND Status = 1";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, userId);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("Name");
                String phone = rs.getString("Phone");
                String address = rs.getString("Address");
                String createDate = rs.getString("Create Date");
                int role = rs.getInt("Role");
                dto = new UserDTO(userId, name, phone, address, createDate, role, 1);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public boolean createUser(UserDTO dto) throws Exception {
        boolean check = false;
        try {
            String query = "Insert into tblUser(UserID, Password, Name, Phone, Address, [Create Date], Role, Status) "
                         + "values (?,?,?,?,?,GETDATE(),?,?)";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, dto.getUserId());
            preStm.setString(2, dto.getPassword());
            preStm.setString(3, dto.getName());
            preStm.setString(4, dto.getPhone());
            preStm.setString(5, dto.getAddress());
            preStm.setInt(6, 1); //1 = user, 2 = admin
            preStm.setInt(7, 1); //1 = active, -1 = deactive
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean checkUserIdExist(String userId) throws Exception {
        boolean exist = false;
        try {
            String query = "Select UserID from tblUser where UserID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, userId);
            rs = preStm.executeQuery();
            if (rs.next())
                exist = true;
        } finally {
            closeConnection();
        }
        return exist;
    }
    
    public boolean changePasswordById(String userId, String password) throws Exception {
        boolean check = false;
        try {
            String query = "Update tblUser set Password = ? where UserID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, password);
            preStm.setString(2, userId);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}