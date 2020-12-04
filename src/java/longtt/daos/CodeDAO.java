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
import longtt.dtos.CodeDTO;

/**
 *
 * @author Long
 */
public class CodeDAO implements Serializable {

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
    
    public boolean createCode(CodeDTO dto) throws Exception {
        boolean check = false;
        try {
            String query = "Insert into tblCode(CodeID, Name, [Discount Percent], [Create Date], [Expire Date], Status) "
                         + "values (?,?,?,GETDATE(),?,1)";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, dto.getCodeId());
            preStm.setString(2, dto.getCodeName());
            preStm.setInt(3, dto.getDiscountPercent());
            preStm.setString(4, dto.getExpireDate());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public boolean checkCodeIdExist(String codeId) throws Exception {
        boolean exist = false;
        try {
            String query = "Select CodeID from tblCode where CodeID = ? AND [Expire Date] >= GETDATE() AND Status = 1";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, codeId);
            rs = preStm.executeQuery();
            if (rs.next())
                exist = true;
        } finally {
            closeConnection();
        }
        return exist;
    }
    
    public boolean updateCodeStatus(String codeId) throws Exception {
        boolean check = false;
        try {
            String query = "Update tblCode set Status = 0 Where CodeID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, codeId);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public int getCodeDiscountPercent(String codeId) throws Exception {
        int discount = 0;
        try {
            String query = "Select [Discount Percent] from tblCode where CodeID = ?";
            conn = getMyConnection();
            preStm = conn.prepareStatement(query);
            preStm.setString(1, codeId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                discount = rs.getInt("Discount Percent");
            }
        } finally {
            closeConnection();
        }
        return discount;
    }
}
