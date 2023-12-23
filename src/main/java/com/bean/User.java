package com.bean;

import java.io.Serializable;

public class User implements Serializable {
    String id;
    //账号
    private String account;
    //昵称
    private String name;
    //密码
    private String password;

    //用户类型
    private String type;
    public User(){

    }
    public User(String id, String account, String name, String password,String type) {
        this.id=id;
        this.account=account;
        this.name = name;
        this.password = password;
        this.type=type;
    }
    public void setAccount(String account) {
        this.account = account;
    }

    public String getAccount() {
        return account;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
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


