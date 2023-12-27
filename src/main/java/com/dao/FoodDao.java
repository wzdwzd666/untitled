package com.dao;

import com.bean.Canteen;
import com.bean.Food;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FoodDao {
    public static List<Food> findAllFood(){
        List<Food> foodList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM food";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String name=rs.getString(2);
                String canteenId=rs.getString(3);
                String cuisine=rs.getString(4);
                String image=rs.getString(5);
                String price=rs.getString(6);
                foodList.add(new Food(id,name,canteenId,cuisine,image,price));
            }
            rs.close();
            statement.close();
            connection.close();
            return foodList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<String> findAllCuisine(){
        List<String> cuisineList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM cuisine";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String name=rs.getString(1);
                cuisineList.add(name);
            }
            rs.close();
            statement.close();
            connection.close();
            return cuisineList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
