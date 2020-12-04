/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.dtos;

import java.io.Serializable;

/**
 *
 * @author Long
 */
public class CodeDTO implements Serializable {
    String codeId, codeName, createDate, expireDate;
    int discountPercent, status;

    public CodeDTO() {
    }

    public CodeDTO(String codeId, String codeName, int discountPercent, String expireDate) {
        this.codeId = codeId;
        this.codeName = codeName;
        this.discountPercent = discountPercent;
        this.expireDate = expireDate;
    }
    
    public CodeDTO(String codeId, String codeName,int discountPercent, String createDate, String expireDate, int status) {
        this.codeId = codeId;
        this.codeName = codeName;
        this.discountPercent = discountPercent;
        this.createDate = createDate;
        this.expireDate = expireDate;
        this.status = status;
    }

    public String getCodeId() {
        return codeId;
    }

    public void setCodeId(String codeId) {
        this.codeId = codeId;
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public int getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(int discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(String expireDate) {
        this.expireDate = expireDate;
    }
}
