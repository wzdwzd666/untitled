package com.dao;

import com.bean.Admin;
import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {
    public static Admin findAdminByName(String loginAccount){
        Admin admin = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="select id,account,name,password,canteen_id,type from admin where account=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,loginAccount);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);;
                String name=rs.getString(3);
                String password=rs.getString(4);
                String canteenId=rs.getString(5);
                String type=rs.getString(6);
                admin=new Admin(id,account,name,password,canteenId,type);
            }
            rs.close();
            statement.close();
            connection.close();
            return admin;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
