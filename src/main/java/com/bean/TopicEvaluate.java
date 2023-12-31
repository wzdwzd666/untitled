package com.bean;

import java.io.Serializable;

public class TopicEvaluate implements Serializable {
    private String id;
    private String topicId;
    private User user;
    private String time;
    private String content;
    public TopicEvaluate(){

    }
    public TopicEvaluate(String id, String topicId, User user, String time,String content){
        this.id=id;
        this.topicId=topicId;
        this.user=user;
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

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
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
