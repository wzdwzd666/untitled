package com.dao;

import com.bean.Canteen;
import com.bean.Food;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FoodDao {
    public static List<Food> findAllFood(){
        List<Food> foodList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT food.*, canteen.name AS canteen_name FROM food\n"+
                    "LEFT JOIN canteen ON canteen.canteen_id = food.canteen_id";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("food_id");
                String name=rs.getString("name");
                Canteen canteen=new Canteen();
                canteen.setName(rs.getString("canteen_name"));
                String cuisine=rs.getString("cuisine");
                String image=rs.getString("image");
                String price=rs.getString("price");
                String recommend=rs.getString("recommend");
                String time=rs.getString("time");
                foodList.add(new Food(id,name,canteen,cuisine,image,price,recommend,time));
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
    public static List<Food> getByCanteen(String canteenId) {
        List<Food> foodList = new ArrayList<>();
        Connection connection = MyConnection.getConnection();
        if (connection == null) {
            return null;
        }
        try {
            String sql = "SELECT food.*, canteen.name AS canteen_name FROM food\n" +
                    "LEFT JOIN canteen ON canteen.canteen_id = food.canteen_id\n" +
                    "WHERE canteen.canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, canteenId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                String id = rs.getString("food_id");
                String name = rs.getString("name");
                Canteen canteen = new Canteen();
                canteen.setName(rs.getString("canteen_name"));
                String cuisine = rs.getString("cuisine");
                String image = rs.getString("image");
                String price = rs.getString("price");
                String recommend = rs.getString("recommend");
                String time = rs.getString("time");
                foodList.add(new Food(id, name, canteen, cuisine, image, price, recommend, time));
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
    public static void editFood(String id,String name,String cuisine,String image, String price){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE food SET name = ?, cuisine=?, image=?, price = ? WHERE food_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,name);
            statement.setString(2,cuisine);
            statement.setString(3,image);
            statement.setString(4,price);
            statement.setString(5,id);
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
            String sql="DELETE FROM food WHERE food_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void insertFood(Food food){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO food(name,canteen_id,cuisine,image,price) VALUES (?,?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,food.getName());
            statement.setString(2,food.getCanteen().getId());
            statement.setString(3,food.getCuisine());
            statement.setString(4,food.getImage());
            statement.setString(5,food.getPrice());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void addRecommend(String id){
        Connection connection= MyConnection.getConnection();
        Date date=new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time=formatter.format(date);
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE food SET recommend = ?, time = ? WHERE food_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,"推荐");
            statement.setString(2,time);
            statement.setString(3,id);
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
            String sql="UPDATE food SET recommend = ?, time = ? WHERE food_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,null);
            statement.setString(2,null);
            statement.setString(3,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<Food> getRecommend(){
        List<Food> foodList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT food.*, canteen.name AS canteen_name FROM food\n"+
                    "LEFT JOIN canteen ON canteen.canteen_id = food.canteen_id\n"+
                    "WHERE food.recommend IS NOT NULL";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("food_id");
                String name=rs.getString("name");
                Canteen canteen=new Canteen();
                canteen.setName(rs.getString("canteen_name"));
                String cuisine=rs.getString("cuisine");
                String image=rs.getString("image");
                String price=rs.getString("price");
                String recommend=rs.getString("recommend");
                String time=rs.getString("time");
                foodList.add(new Food(id,name,canteen,cuisine,image,price,recommend,time));
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
}
