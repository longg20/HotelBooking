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
public class BookingDTO implements Serializable {

    String bookingId, userId, bookingDate, checkinDate, checkoutDate, checkOutDateBeforeConvert, code;
    float total;
    int status;

    public BookingDTO() {
    }

    public BookingDTO(String userId, String checkinDate, String checkoutDate, float total) {
        this.userId = userId;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.total = total;
    }

    public BookingDTO(String userId, String checkinDate, String checkoutDate, String code, float total) {
        this.userId = userId;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.code = code;
        this.total = total;
    }
    
    public BookingDTO(String bookingId, String userId, String bookingDate, String checkinDate, String checkoutDate, float total, String code, int status) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.bookingDate = bookingDate;
        this.checkinDate = checkinDate;
        this.checkoutDate = checkoutDate;
        this.total = total;
        this.code = code;
        this.status = status;
    }
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(String checkinDate) {
        this.checkinDate = checkinDate;
    }

    public String getCheckoutDate() {
        return checkoutDate;
    }

    public void setCheckoutDate(String checkoutDate) {
        this.checkoutDate = checkoutDate;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCheckOutDateBeforeConvert() {
        return checkOutDateBeforeConvert;
    }

    public void setCheckOutDateBeforeConvert(String checkOutDateBeforeConvert) {
        this.checkOutDateBeforeConvert = checkOutDateBeforeConvert;
    }
}
