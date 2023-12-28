package com.dao;

import com.bean.User;

import java.sql.*;

public class UserDao {
    //根据用户名查询用户
    public static User findUserByAccount(String loginAccount){
        User user = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT id,account,name,password,type FROM user WHERE account=?";
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
    public static int insertUser(User user){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return 0;
        }
        try {
            String sql="INSERT INTO user(account,name,password,type) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,user.getAccount());
            statement.setString(2,user.getName());
            statement.setString(3,user.getPassword());
            statement.setString(4, user.getType());
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
    public static void editUser(User user){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE canteen SET name = ?, password = ?, type = ? WHERE id=?";
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
}
