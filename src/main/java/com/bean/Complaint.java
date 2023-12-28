package com.bean;

import java.io.Serializable;

public class Complaint implements Serializable {
    private String id;
    private String userId;
    private String canteenId;
    private String time;
    private String content;
    private String adminId;
    private String replyContent;

    // 无参构造方法
    public Complaint() {
    }
    public Complaint(String id, String userId, String canteenId, String time, String content, String adminId,  String replyContent) {
        this.id = id;
        this.userId = userId;
        this.canteenId = canteenId;
        this.time = time;
        this.content = content;
        this.adminId = adminId;
        this.replyContent = replyContent;
    }

    // Getter 和 Setter 方法
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCanteenId() {
        return canteenId;
    }

    public void setCanteenId(String canteenId) {
        this.canteenId = canteenId;
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

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    @Override
    public String toString() {
        return "Complaint{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", canteenId='" + canteenId + '\'' +
                ", time='" + time + '\'' +
                ", content='" + content + '\'' +
                ", adminId='" + adminId + '\'' +
                '}';
    }
}
