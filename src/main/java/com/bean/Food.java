package com.bean;

import java.io.Serializable;

public class Food implements Serializable {
    private String id;
    private String name;
    private Canteen canteen;
    private String cuisine;
    private String image;
    private String price;
    private String recommend;
    private String time;
    public Food(){

    }
    public Food(String id, String name, Canteen canteen, String cuisine, String image, String price, String recommend, String time){
        this.id=id;
        this.name=name;
        this.canteen=canteen;
        this.cuisine=cuisine;
        this.image=image;
        this.price=price;
        this.recommend=recommend;
        this.time=time;
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

    public void setCanteen(Canteen canteen) {
        this.canteen = canteen;
    }

    public Canteen getCanteen() {
        return canteen;
    }

    public void setCuisine(String cuisine) {
        this.cuisine = cuisine;
    }

    public String getCuisine() {
        return cuisine;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getImage() {
        return image;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getPrice() {
        return price;
    }

    public void setRecommend(String recommend) {
        this.recommend = recommend;
    }

    public String getRecommend() {
        return recommend;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }
}
