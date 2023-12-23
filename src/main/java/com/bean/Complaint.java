package com.bean;

import java.io.Serializable;

public class Complaint implements Serializable {
    String id;
    String userId;
    String canteenId;
    String time;
    String content;
    String replyId;
    public Complaint(){

    }
}
