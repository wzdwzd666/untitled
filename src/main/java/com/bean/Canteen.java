package com.bean;

import java.io.Serializable;

public class Canteen implements Serializable {
    String id;
    String name;
    String startTime;
    String endTime;
    String info;
    String avgRating;
    String userRating;
    public Canteen(){

    }
    public Canteen(String id,String name,String startTime,String endTime,String info){
        this.id=id;
        this.name=name;
        this.startTime=startTime;
        this.endTime=endTime;
        this.info=info;
    }
    public Canteen(String id,String name,String startTime,String endTime,String info,String avgRating,String userRating){
        this.id=id;
        this.name=name;
        this.startTime=startTime;
        this.endTime=endTime;
        this.info=info;
        this.avgRating=avgRating;
        this.userRating=userRating;
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

    public void setAvgRating(String avgRating) {
        this.avgRating = avgRating;
    }

    public String getAvgRating() {
        return avgRating;
    }

    public void setUserRating(String userRating) {
        this.userRating = userRating;
    }

    public String getUserRating() {
        return userRating;
    }
    @Override
    public String toString() {
        return "Canteen{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", info='" + info + '\'' +
                ", avgRating='" + avgRating + '\'' +
                ", userRating='" + userRating + '\'' +
                '}';
    }
}
