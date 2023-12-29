package com.dao;

import com.bean.CanteenEvaluate;
import com.bean.Topic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TopicDao {
    public static List<Topic> findTopic(String sql){
        List<Topic> topicList=new ArrayList<>();
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
                String title=rs.getString(3);
                String time=rs.getString(4);
                String content=rs.getString(5);
                String image=rs.getString(6);
                int like=rs.getInt(7);
                topicList.add(new Topic(id,user_id,title,time,content,image,like));
            }
            rs.close();
            statement.close();
            connection.close();
            return topicList;
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
