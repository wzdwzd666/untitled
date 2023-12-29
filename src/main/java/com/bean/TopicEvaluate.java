package com.bean;

import java.io.Serializable;

public class TopicEvaluate implements Serializable {
    private String id;
    private String topicId;
    private String userId;
    private String time;
    private String content;
    public TopicEvaluate(){

    }
    public TopicEvaluate(String id, String topicId, String userId, String time,String content){
        this.id=id;
        this.topicId=topicId;
        this.userId=userId;
        this.time=time;
        this.content=content;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId;
    }

    public String getTopicId() {
        return topicId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserId() {
        return userId;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTime() {
        return time;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

}
