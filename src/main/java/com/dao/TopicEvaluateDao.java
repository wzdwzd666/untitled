package com.dao;

import com.bean.Topic;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class TopicEvaluateDao {
    public static List<Topic> getList(){
        List<Topic> topicList=new ArrayList<>();
        Connection connection=MyConnection.getConnection();
        if(connection==null){
            return null;
        }

        return topicList;
    }
}
