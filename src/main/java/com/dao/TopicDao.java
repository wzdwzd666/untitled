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
            String sql="SELECT topic.*, user.name FROM topic\n" +
                    "JOIN user ON user.user_id = topic.user_id";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("topic_id");
                User user =new User();
                user.setName(rs.getString("name"));
                String title=rs.getString("title");
                String time=rs.getString("time");
                String content=rs.getString("content");
                String image=rs.getString("image");
                int like=rs.getInt("like_count");
                topicList.add(new Topic(id,user,title,time,content,image,like));
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
                String title=rs.getString("title");
                String time=rs.getString("time");
                String content=rs.getString("content");
                String image=rs.getString("image");
                int like=rs.getInt("like_count");
                topicList.add(new Topic(id,user,title,time,content,image,like));
            }
            rs.close();
            statement.close();
            connection.close();
            return topicList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static Topic getTopicById(String id){
//        Topic topic = null;
//        Connection connection= MyConnection.getConnection();
//        if(connection==null){
//            return null;
//        }
//        try {
//            String sql="SELECT topic.*, user.name FROM topic\n" +
//                    "JOIN user ON user.user_id = topic.user_id\n"+
//                    "WHERE topic_id = ?";
//            PreparedStatement statement = connection.prepareStatement(sql);
//            statement.setInt(1, Integer.parseInt(id));
//            ResultSet rs=statement.executeQuery();
//            while (rs.next()){
//                String topic_id=rs.getString("topic_id");
//                User user =new User();
//                user.setName(rs.getString("name"));
//                String title=rs.getString("title");
//                String time=rs.getString("time");
//                String content=rs.getString("content");
//                String image=rs.getString("image");
//                int like=rs.getInt("like_count");
//                topic=new Topic(topic_id,user,title,time,content,image,like);
//            }
//            rs.close();
//            statement.close();
//            connection.close();
//            return topic;
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
        return null;
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
    public static void addLike(String id,String like){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE topic SET like_count = ? WHERE topic_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,like);
            statement.setString(2,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
