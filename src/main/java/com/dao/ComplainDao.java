package com.dao;

import com.bean.CanteenEvaluate;
import com.bean.Complaint;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplainDao {
    public static List<Complaint> findComplaint(String sql){
        List<Complaint> complaintList=new ArrayList<>();
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
                String canteen_id=rs.getString(3);
                String time=rs.getString(4);
                String content=rs.getString(5);
                String admin_id=rs.getString(6);
                String reply_content=rs.getString(7);
                complaintList.add(new Complaint(id,user_id,canteen_id,time,content,admin_id,reply_content));
            }
            rs.close();
            statement.close();
            connection.close();
            return complaintList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void editComplaintById(String id,String adminId,String replyContent) {
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE complaint SET admin_id = ?, reply_content = ? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,adminId);
            statement.setString(2,replyContent);
            statement.setString(3,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
