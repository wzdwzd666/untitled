package com.dao;

import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    //根据用户名查询用户
    public static User findUserByName(String username){
        User user = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="select name,nick_name,password,type from user where name=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,username);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String name=rs.getString(1);
                String nickname=rs.getString(2);
                String password=rs.getString(3);
                String type=rs.getString(4);
                user=new User(name,nickname,password,type);
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

    }
}
