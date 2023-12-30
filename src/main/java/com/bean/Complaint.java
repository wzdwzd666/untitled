package com.bean;

import java.io.Serializable;

public class Complaint implements Serializable {
    private String id;
    private User user;
    private Canteen canteen;
    private String time;
    private String content;
    private Admin admin;
    private String replyContent;

    // 无参构造方法
    public Complaint() {
    }
    public Complaint(String id, User user, Canteen canteen, String time, String content, Admin admin,  String replyContent) {
        this.id = id;
        this.user = user;
        this.canteen = canteen;
        this.time = time;
        this.content = content;
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

    public void setCanteen(Canteen canteen) {
        this.canteen = canteen;
    }

    public Canteen getCanteen() {
        return canteen;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
