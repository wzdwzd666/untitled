package com.dao;

import com.bean.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {
    public static Admin findAdminByAccount(String loginAccount){
        Admin admin = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="select id,account,name,password,,type,canteen_id from admin where account=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,loginAccount);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);;
                String name=rs.getString(3);
                String password=rs.getString(4);
                String type=rs.getString(5);
                String canteenId=rs.getString(6);
                admin=new Admin(id,account,name,password,type,canteenId);
            }
            rs.close();
            statement.close();
            connection.close();
            return admin;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void insertAdmin(Admin admin){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="insert into admin(account,name,password,canteen_id,type) values (?,?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,admin.getAccount());
            statement.setString(2,admin.getName());
            statement.setString(3,admin.getPassword());
            statement.setString(4,admin.getCanteenId());
            statement.setString(5,admin.getType());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
