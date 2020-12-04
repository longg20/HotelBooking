/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.dtos;

import java.io.Serializable;
import java.util.HashMap;

/**
 *
 * @author Long
 */
public class RoomCart implements Serializable {

    private String userId;
    private HashMap<Integer, RoomDTO> cart;
    String checkinDate, checkoutDate, code;
    float total;

    public String getUserId() {
        return userId;
    }

    public HashMap<Integer, RoomDTO> getCart() {
        return cart;
    }

    public void setCheckinDate(String checkinDate) {
        this.checkinDate = checkinDate;
    }
    
    public void setCheckoutDate(String checkoutDate) {
        this.checkoutDate = checkoutDate;
    }

    public String getCheckinDate() {
        return checkinDate;
    }

    public String getCheckoutDate() {
        return checkoutDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public RoomCart(String userId) {
        this.userId = userId;
        this.cart = new HashMap<Integer, RoomDTO>();
        this.total = 0;
    }

    public void addToCart(RoomDTO dto) throws Exception {
        if (this.cart.containsKey(dto.getRoomId())) {
            int cartQty = this.cart.get(dto.getRoomId()).getCartQty() + dto.getCartQty();
            dto.setCartQty(cartQty);
        }
        this.cart.put(dto.getRoomId(), dto);
    }

    public void removeFromCart(int id) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }
    }

    public void updateCart(int id, int qty) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.get(id).setCartQty(qty);
        }
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public float getTotal() throws Exception {
        this.total = 0;
        for (RoomDTO dto : this.cart.values()) {
            this.total = this.total + dto.getPrice() * dto.getCartQty();
        }
        return this.total;
    }
}
