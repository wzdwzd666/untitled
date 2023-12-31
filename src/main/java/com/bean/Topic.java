package com.bean;

import java.io.Serializable;

public class Topic implements Serializable {
    private String id;
    private User user;
    private String time;
    private String content;
    private String image;
    private int like;

    // 构造方法
    public Topic() {
        // 默认构造方法
    }

    public Topic(String id, User user, String time, String content, String image, int like) {
        this.id=id;
        this.user=user;
        this.time=time;
        this.content=content;
        this.image=image;
        this.like=like;
    }

    // Getter 和 Setter 方法
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getLike() {
        return like;
    }

    public void setLike(int like) {
        this.like = like;
    }
    @Override
    public String toString() {
        return "Topic{" +
                "id='" + id + '\'' +
                ", user=" + user +
                ", time='" + time + '\'' +
                ", content='" + content + '\'' +
                ", image='" + image + '\'' +
                ", like=" + like +
                '}';
    }
}
