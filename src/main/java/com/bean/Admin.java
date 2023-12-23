package com.bean;

import java.io.Serializable;

public class Admin implements Serializable {
    String id;
    String account;
    String name;
    String password;
    String type;
    String canteenId;
    public Admin(){

    }
    public Admin(String id,String account,String name,String password,String type,String canteenId){
        this.id=id;
        this.account=account;
        this.name=name;
        this.password=password;
        this.type=type;
        this.canteenId=canteenId;
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

    public void setCanteenId(String canteenId) {
        this.canteenId = canteenId;
    }

    public String getCanteenId() {
        return canteenId;
    }
}
