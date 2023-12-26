package com.bean;

import java.io.Serializable;
import java.util.StringTokenizer;

public class TopicEvaluate implements Serializable {
    private String id;
    private String topicId;
    private String personId;
    private String time;
    private String content;
    private String personType;
    public TopicEvaluate(){

    }
    public TopicEvaluate(String id, String topicId, String personId, String time,String content,String personType){
        this.id=id;
        this.topicId=topicId;
        this.personId=personId;
        this.time=time;
        this.content=content;
        this.personType=personType;
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

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPersonId() {
        return personId;
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

    public void setPersonType(String personType) {
        this.personType = personType;
    }

    public String getPersonType() {
        return personType;
    }
}
