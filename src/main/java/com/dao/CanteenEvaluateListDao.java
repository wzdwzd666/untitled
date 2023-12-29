package com.dao;

import com.bean.Canteen;
import com.bean.CanteenEvaluate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CanteenEvaluateListDao {
    public static List<CanteenEvaluate> findCanteenEvaluate(String sql){
        List<CanteenEvaluate> canteenEvaluateList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String user_id=rs.getString(2);
                String canteen_id=rs.getString(3);
                String content=rs.getString(4);
                String reply_admin_id=rs.getString(5);
                String reply_content=rs.getString(6);
                canteenEvaluateList.add(new CanteenEvaluate(id,user_id,canteen_id,content,reply_admin_id,reply_content));
            }
            rs.close();
            statement.close();
            connection.close();
            return canteenEvaluateList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void editCanteenEvaluateById(String id,String adminId,String replyContent) {
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE canteen_evaluate SET reply_admin_id = ?, reply_content = ? WHERE canteen_evaluate_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,adminId);
            statement.setString(2,replyContent);
            statement.setString(3,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteCanteenEvaluate(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM canteen_evaluate WHERE canteen_evaluate_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void insertEvaluate(CanteenEvaluate canteenEvaluate){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO canteen_evaluate(user_id,canteen_id,content) VALUES (?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteenEvaluate.getUserId());
            statement.setString(2,canteenEvaluate.getCanteenId());
            statement.setString(3,canteenEvaluate.getContent());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
