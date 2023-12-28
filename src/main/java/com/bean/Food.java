package com.bean;

import java.io.Serializable;

public class Food implements Serializable {
    String id;
    String name;
    String canteenId;
    String cuisine;
    String image;
    String price;
    public Food(){

    }
    public Food(String id, String name, String canteenId, String cuisine, String image, String price){
        this.id=id;
        this.name=name;
        this.canteenId=canteenId;
        this.cuisine=cuisine;
        this.image=image;
        this.price=price;
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

    public void setCanteenId(String canteenId) {
        this.canteenId = canteenId;
    }

    public String getCanteenId() {
        return canteenId;
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
    @Override
    public String toString() {
        return "Food{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", canteenId='" + canteenId + '\'' +
                ", cuisine='" + cuisine + '\'' +
                ", image='" + image + '\'' +
                ", price='" + price + '\'' +
                '}';
    }
}
