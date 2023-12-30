package com.bean;

import java.io.Serializable;

public class CanteenEvaluate implements Serializable {
    private String id;
    private User user;
    private Canteen canteen;
    private String content;
    private double rating;
    private Admin admin;
    private String replyContent;

    // 无参构造方法
    public CanteenEvaluate() {
    }

    // 有参构造方法
    public CanteenEvaluate(String id, User user, Canteen canteen, String content, double rating, Admin admin, String replyContent) {
        this.id = id;
        this.user = user;
        this.canteen = canteen;
        this.content = content;
        this.rating = rating;
        this.admin = admin;
        this.replyContent = replyContent;
    }

    // Getter 和 Setter 方法
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public Canteen getCanteen() {
        return canteen;
    }

    public void setCanteen(Canteen canteen) {
        this.canteen = canteen;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public Admin getAdmin() {
        return admin;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

}

