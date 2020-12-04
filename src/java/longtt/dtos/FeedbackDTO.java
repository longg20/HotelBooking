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
public class FeedbackDTO implements Serializable {
    String userId, comment;
    int feedbackId, roomId;
    float rating;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String userId, int roomId, float rating, String comment) {
        this.userId = userId;
        this.roomId = roomId;
        this.rating = rating;
        this.comment = comment;
    }

    public FeedbackDTO(int feedbackId, String userId, int roomId, float rating, String comment) {
        this.feedbackId = feedbackId;
        this.userId = userId;
        this.roomId = roomId;
        this.rating = rating;
        this.comment = comment;
    }
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }
}
