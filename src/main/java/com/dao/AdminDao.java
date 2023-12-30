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
            String sql="SELECT admin.*, canteen.name AS canteen_name FROM admin \n" +
                    "LEFT JOIN canteen ON canteen.canteen_id = admin.canteen_id\n"+
                    "WHERE admin.account=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,loginAccount);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("admin_id");
                String account=rs.getString("account");;
                String name=rs.getString("name");
                String password=rs.getString("password");
                Canteen canteen=new Canteen();
                canteen.setId(rs.getString("canteen_id"));
                canteen.setName(rs.getString("canteen_name"));
                admin=new Admin(id,account,name,password,canteen);
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
            String sql="SELECT admin.*, canteen.name AS canteen_name FROM admin \n" +
                    "JOIN canteen ON canteen.canteen_id=admin.canteen_id\n"+
                    "WHERE admin.canteen_id IS NOT NULL";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("admin_id");
                String account=rs.getString("account");
                String name=rs.getString("name");
                String password=rs.getString("password");
                Canteen canteen=new Canteen();
                canteen.setId(rs.getString("canteen_id"));
                canteen.setName(rs.getString("canteen_name"));
                adminList.add(new Admin(id,account,name,password,canteen));
            }
            rs.close();
            statement.close();
            connection.close();
            return adminList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void insertAdmin(String account,String name,String password,String canteenId){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO admin(account,name,password,canteen_id) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,account);
            statement.setString(2,name);
            statement.setString(3,password);
            statement.setString(4,canteenId);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void editAdmin(String id,String name,String password) {
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE admin SET name = ?, password = ? WHERE admin_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,name);
            statement.setString(2,password);
            statement.setString(3,id);
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
            String sql="DELETE FROM admin WHERE admin_id = ?";
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
