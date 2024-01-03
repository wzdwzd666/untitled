package com.bean;

import java.io.Serializable;

public class Admin implements Serializable {
    String id;
    String account;
    String name;
    String password;
    Canteen canteen;
    public Admin(){

    }
    public Admin(String id,String account,String name,String password,Canteen canteen){
        this.id=id;
        this.account=account;
        this.name=name;
        this.password=password;
        this.canteen=canteen;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
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

    public void setCanteen(Canteen canteen) {
        this.canteen = canteen;
    }

    public Canteen getCanteen() {
        return canteen;
    }

}
