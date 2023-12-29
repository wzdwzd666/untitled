package com.dao;

import com.bean.Topic;
import com.bean.TopicEvaluate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TopicEvaluateDao {
    public static List<TopicEvaluate> getList(){
        List<TopicEvaluate> topicEvaluateList=new ArrayList<>();
        Connection connection=MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM topic_evaluate";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String topicId=rs.getString(2);
                String user_id=rs.getString(3);
                String time=rs.getString(4);
                String content=rs.getString(5);
                topicEvaluateList.add(new TopicEvaluate(id,topicId,user_id,time,content));
            }
            rs.close();
            statement.close();
            connection.close();
            return topicEvaluateList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
