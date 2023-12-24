package com.dao;

import com.bean.Admin;
import com.bean.Canteen;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {
    public static Admin findAdminByAccount(String loginAccount){
        Admin admin = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT id,account,name,password,canteen_id From admin where account=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,loginAccount);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);;
                String name=rs.getString(3);
                String password=rs.getString(4);
                String canteenId=rs.getString(5);
                admin=new Admin(id,account,name,password,canteenId);
            }
            rs.close();
            statement.close();
            connection.close();
            return admin;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<Admin> findAllAdmin() {
        List<Admin> adminList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT id,account,name,password,canteen_id FROM admin";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String account=rs.getString(2);
                String name=rs.getString(3);
                String password=rs.getString(4);
                String canteenId=rs.getString(5);
                adminList.add(new Admin(id,account,name,password,canteenId));
            }
            rs.close();
            statement.close();
            connection.close();
            return adminList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static int insertAdmin(Admin admin){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return 0;
        }
        try {
            String sql="INSERT INTO admin(account,name,password,canteen_id) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,admin.getAccount());
            statement.setString(2,admin.getName());
            statement.setString(3,admin.getPassword());
            statement.setString(4,admin.getCanteenId());
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
    public static void editAdminById(Admin admin) {
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE canteen SET name = ?, password = ?, canteen_id=? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,admin.getName());
            statement.setString(2,admin.getPassword());
            statement.setString(3,admin.getCanteenId());
            statement.setString(4,admin.getId());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteAdmin(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM admin WHERE id = ?";
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
