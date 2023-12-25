package com.bean;

import java.io.Serializable;

public class CanteenEvaluate implements Serializable {
    private String id;
    private String userId;
    private String canteenId;
    private String content;
    private String replyAdminId;
    private String replyContent;

    // 无参构造方法
    public CanteenEvaluate() {
    }

    // 有参构造方法
    public CanteenEvaluate(String id, String userId, String canteenId, String content, String replyAdminId, String replyContent) {
        this.id = id;
        this.userId = userId;
        this.canteenId = canteenId;
        this.content = content;
        this.replyAdminId = replyAdminId;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getReplyAdminId() {
        return replyAdminId;
    }

    public void setReplyAdminId(String replyAdminId) {
        this.replyAdminId = replyAdminId;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    // 可选的 toString 方法，用于方便调试
    @Override
    public String toString() {
        return "CanteenEvaluate{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", canteenId='" + canteenId + '\'' +
                ", content='" + content + '\'' +
                ", replyAdminId='" + replyAdminId + '\'' +
                ", replyContent='" + replyContent + '\'' +
                '}';
    }
}

