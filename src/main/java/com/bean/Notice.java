package com.bean;

import java.io.Serializable;

public class Notice implements Serializable {
    String id;
    Admin admin;
    String title;
    String time;
    String content;
    public Notice(){

    }
    public Notice(String id,Admin admin,String title,String time,String content){
        this.id=id;
        this.admin=admin;
        this.title=title;
        this.time=time;
        this.content=content;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }
}
