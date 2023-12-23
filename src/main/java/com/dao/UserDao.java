package com.dao;

import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    //根据用户名查询用户
    public static User findUserByAccount(String loginAccount){
        User user = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="select id,account,name,password,type from user where account=?";
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
    //插入新用户
    public static void insertUser(User user){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="insert into user(account,name,password,type) values (?,?,?,?)";
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
}
