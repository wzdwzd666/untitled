package com.dao;

import com.bean.CanteenEvaluate;
import com.bean.Topic;
import com.bean.User;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TopicDao {
    public static List<Topic> findAllTopic(){
        List<Topic> topicList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
//            String sql="SELECT topic.*, user.name FROM topic\n" +
//                    "JOIN user ON user.user_id = topic.user_id";
            String sql="SELECT\n" +
                    "    topic.*,\n" +
                    "    user.name,\n" +
                    "    COUNT(like_info.topic_id) AS like_count\n" +
                    "FROM\n" +
                    "    topic\n" +
                    "JOIN\n" +
                    "    user ON user.user_id = topic.user_id\n" +
                    "LEFT JOIN\n" +
                    "    like_info ON like_info.topic_id = topic.topic_id\n" +
                    "GROUP BY\n" +
                    "    topic.topic_id;";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("topic_id");
                User user =new User();
                user.setName(rs.getString("name"));
                String time=rs.getString("time");
                String content=rs.getString("content");
                String image=rs.getString("image");
                int like=rs.getInt("like_count");
                topicList.add(new Topic(id,user,time,content,image,like));
            }
            rs.close();
            statement.close();
            connection.close();
            return topicList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<Topic> searchByTitle(String t){
        List<Topic> topicList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT topic.*, user.name FROM topic\n" +
                    "JOIN user ON user.user_id = topic.user_id\n" +
                    "WHERE topic.title LIKE ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + t + "%"); // 使用通配符 % 包裹查询字符串
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("topic_id");
                User user =new User();
                user.setName(rs.getString("name"));
                String time=rs.getString("time");
                String content=rs.getString("content");
                String image=rs.getString("image");
                int like=rs.getInt("like_count");
                topicList.add(new Topic(id,user,time,content,image,like));
            }
            rs.close();
            statement.close();
            connection.close();
            return topicList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static Topic getTopicById(String topicId){
        Topic topic=new Topic();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT\n" +
                    "    topic.*,\n" +
                    "    user.name,\n" +
                    "    COUNT(like_info.topic_id) AS like_count\n" +
                    "FROM\n" +
                    "    topic\n" +
                    "JOIN\n" +
                    "    user ON user.user_id = topic.user_id\n" +
                    "LEFT JOIN\n" +
                    "    like_info ON like_info.topic_id = topic.topic_id\n" +
                    "WHERE\n"+
                    "topic.topic_id = ?\n"+
                    "GROUP BY\n" +
                    "    topic.topic_id;";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,topicId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("topic_id");
                User user =new User();
                user.setName(rs.getString("name"));
                String time=rs.getString("time");
                String content=rs.getString("content");
                String image=rs.getString("image");
                int like=rs.getInt("like_count");
                topic=new Topic(id,user,time,content,image,like);
            }
            rs.close();
            statement.close();
            connection.close();
            return topic;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteTopic(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM topic WHERE topic_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void addLike(String id,String userId){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO like_info(topic_id,user_id) VALUES(?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,id);
            statement.setString(2,userId);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void cancelLike(String id,String userId){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM like_info WHERE topic_id = ? AND user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,id);
            statement.setString(2,userId);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static boolean checkLike(String id,String userId){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return false;
        }
        try {
            String sql="SELECT * FROM like_info WHERE topic_id = ? AND user_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,id);
            statement.setString(2,userId);
            ResultSet rs=statement.executeQuery();
            boolean b = rs.next();
            statement.close();
            connection.close();
            return b;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static String getLike(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT COUNT(like_info.topic_id) AS like_count FROM like_info WHERE topic_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,id);
            ResultSet rs=statement.executeQuery();
            String like = null;
            while (rs.next()){
                like=rs.getString("like_count");
            }
            statement.close();
            connection.close();
            return like;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
