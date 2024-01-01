package com.dao;

import com.bean.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    //根据用户名查询用户
    public static User findUserByAccount(String loginAccount){
        User user = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM user WHERE account=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,loginAccount);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);
                String name=rs.getString(3);
                String password=rs.getString(4);
                String type=rs.getString(5);
                user=new User(id,account,name,password,type);
            }
            rs.close();
            statement.close();
            connection.close();
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static User findUserById(String userId){
        User user = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM user WHERE user_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,userId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);
                String name=rs.getString(3);
                String password=rs.getString(4);
                String type=rs.getString(5);
                user=new User(id,account,name,password,type);
            }
            rs.close();
            statement.close();
            connection.close();
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    //插入新用户
    public static void insertUser(User user){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO user(account,name,password,type) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,user.getAccount());
            statement.setString(2,user.getName());
            statement.setString(3,user.getPassword());
            statement.setString(4, user.getType());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void editUser(User user){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE user SET name = ?, password = ?, type = ? WHERE user_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,user.getName());
            statement.setString(2,user.getPassword());
            statement.setString(3,user.getType());
            statement.setString(4,user.getId());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<User> findAllUser(){
        List<User> userList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM user";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);
                String name=rs.getString(3);
                String password=rs.getString(4);
                String type=rs.getString(5);
                userList.add(new User(id,account,name,password,type));
            }
            rs.close();
            statement.close();
            connection.close();
            return userList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteUser(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM user WHERE user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
