package com.dao;

import com.bean.Canteen;
import com.bean.Food;

import java.sql.*;
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
                String recommend=rs.getString(7);
                foodList.add(new Food(id,name,canteenId,cuisine,image,price,recommend));
            }
            rs.close();
            statement.close();
            connection.close();
            System.out.println(foodList);
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
    public static void editFood(Food food){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE food SET name = ?, cuisine=?, image=?, price = ? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,food.getName());
            statement.setString(2,food.getCuisine());
            statement.setString(3,food.getImage());
            statement.setString(4,food.getPrice());
            statement.setString(5,food.getId());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteFood(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM food WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static int insertFood(Food food){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return 0;
        }
        try {
            String sql="INSERT INTO food(name,canteen_id,cuisine,image,price) VALUES (?,?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,food.getName());
            statement.setString(2,food.getCanteenId());
            statement.setString(3,food.getCuisine());
            statement.setString(4,food.getImage());
            statement.setString(5,food.getPrice());
            int affectedRows = statement.executeUpdate();
            int id=0;
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        // 在这里使用获取到的自增主键值（id）
                        id = generatedKeys.getInt(1);
                    }
                }
            }
            statement.close();
            connection.close();
            return id;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void addRecommend(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE food SET recommend = ? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,"推荐");
            statement.setString(2,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteRecommend(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE food SET recommend = ? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,null);
            statement.setString(2,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
