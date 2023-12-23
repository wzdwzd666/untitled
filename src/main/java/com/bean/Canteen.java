package com.bean;

import java.io.Serializable;

public class Canteen implements Serializable {
    String id;
    String name;
    String position;
    String startTime;
    String endTime;
    String info;
    public Canteen(){

    }
    public Canteen(String id,String name,String position,String startTime,String endTime,String info){
        this.id=id;
        this.name=name;
        this.position=position;
        this.startTime=startTime;
        this.endTime=endTime;
        this.info=info;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getInfo() {
        return info;
    }
}
