package com.dao;

import com.bean.Admin;
import com.bean.Canteen;
import com.bean.CanteenEvaluate;
import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CanteenEvaluateDao {
    public static List<CanteenEvaluate> findEvaluateByCanteenId(String canteenId){
        List<CanteenEvaluate> canteenEvaluateList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT canteen_evaluate.*, user.name AS user_name, canteen.name AS canteen_name, admin.name AS admin_name FROM canteen_evaluate\n" +
                    "JOIN user ON user.user_id = canteen_evaluate.user_id\n"+
                    "JOIN canteen ON canteen.canteen_id = canteen_evaluate.canteen_id\n"+
                    "LEFT JOIN admin ON admin.admin_id = canteen_evaluate.reply_admin_id\n"+
                    "WHERE canteen_evaluate.canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteenId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id = rs.getString("canteen_evaluate_id");
                User user=new User();
                user.setName(rs.getString("user_name"));
                Canteen canteen=new Canteen();
                canteen.setName(rs.getString("canteen_name"));
                String content = rs.getString("content");
                double rating = rs.getDouble("rating");
                Admin admin=new Admin();
                admin.setName(rs.getString("admin_name"));
                String replyContent = rs.getString("reply_content");
                CanteenEvaluate canteenEvaluate=new CanteenEvaluate(id,user,canteen,content,rating,admin,replyContent);
                canteenEvaluateList.add(canteenEvaluate);
            }
            rs.close();
            statement.close();
            connection.close();
            return canteenEvaluateList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static CanteenEvaluate checkEvaluate(String userId,String canteenId){
        CanteenEvaluate canteenEvaluate=null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT canteen_evaluate.*, user.name AS user_name, canteen.name AS canteen_name, admin.name AS admin_name FROM canteen_evaluate\n" +
                    "JOIN user ON user.user_id = canteen_evaluate.user_id\n"+
                    "JOIN canteen ON canteen.canteen_id = canteen_evaluate.canteen_id\n"+
                    "LEFT JOIN admin ON admin.admin_id = canteen_evaluate.reply_admin_id\n"+
                    "WHERE canteen_evaluate.user_id = ? AND canteen_evaluate.canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,userId);
            statement.setString(2,canteenId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id = rs.getString("canteen_evaluate_id");
                User user=new User();
                user.setName(rs.getString("user_name"));
                Canteen canteen=new Canteen();
                canteen.setName(rs.getString("canteen_name"));
                String content = rs.getString("content");
                double rating = rs.getDouble("rating");
                Admin admin=new Admin();
                admin.setName(rs.getString("admin_name"));
                String replyContent = rs.getString("reply_content");
                canteenEvaluate=new CanteenEvaluate(id,user,canteen,content,rating,admin,replyContent);
            }
            rs.close();
            statement.close();
            connection.close();
            return canteenEvaluate;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void setRating(String userId,String canteenId,String content,String rating){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE canteen_evaluate SET content = ?, rating = ? WHERE user_id = ? AND canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,content);
            statement.setString(2,rating);
            statement.setString(3,userId);
            statement.setString(4,canteenId);

            statement.execute();
            statement.close();
            connection.close();
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
    public static void insertEvaluate(String userId,String canteenId,String reply,String rating){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO canteen_evaluate(user_id,canteen_id,content,rating) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,userId);
            statement.setString(2,canteenId);
            statement.setString(3,reply);
            statement.setString(4,rating);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
