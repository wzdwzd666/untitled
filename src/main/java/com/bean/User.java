package com.bean;

public class User {
    //姓名
    private String name;
    //密码
    private String password;
    //昵称
    private String nickname;
    //用户类型
    private String type;
    public User(){

    }
    public User(String name, String nickname, String password,String type) {
        this.name = name;
        this.nickname=nickname;
        this.password = password;
        this.type=type;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getNickname() {
        return nickname;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }
}


