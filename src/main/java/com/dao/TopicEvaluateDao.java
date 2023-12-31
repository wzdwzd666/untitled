package com.dao;

import com.bean.Topic;
import com.bean.TopicEvaluate;
import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TopicEvaluateDao {
    public static List<TopicEvaluate> getListById(String topicId){
        List<TopicEvaluate> topicEvaluateList=new ArrayList<>();
        Connection connection=MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT topic_evaluate.*, user.name AS user_name FROM topic_evaluate\n"+
                    "JOIN user ON user.user_id = topic_evaluate.user_id\n"+
                    "WHERE topic_evaluate.topic_id = ?\n"+
                    "ORDER BY topic_evaluate.time DESC;\n";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,topicId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("topic_evaluate_id");
                String user_id=rs.getString("user_id");
                String user_name=rs.getString("user_name");
                User user=new User();
                user.setId(user_id);
                user.setName(user_name);
                String time=rs.getString("time");
                String content=rs.getString("content");
                topicEvaluateList.add(new TopicEvaluate(id,topicId,user,time,content));
            }
            rs.close();
            statement.close();
            connection.close();
            return topicEvaluateList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void postEvaluate(String topicId,String userId,String time,String content){
        Connection connection=MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO topic_evaluate(topic_id,user_id,time,content) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,topicId);
            statement.setString(2,userId);
            statement.setString(3,time);
            statement.setString(4,content);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
