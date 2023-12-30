package com.dao;

import com.bean.Admin;
import com.bean.Canteen;
import com.bean.Complaint;
import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDao {
    public static List<Complaint> getByCanteenId(String canteenId){
        List<Complaint> complaintList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT complaint.*, user.name AS user_name, canteen.name AS canteen_name, admin.name AS admin_name FROM complaint\n"+
                    "LEFT JOIN user ON user.user_id = complaint.user_id\n"+
                    "LEFT JOIN canteen ON canteen_id = complaint.canteen_id\n"+
                    "LEFT JOIN admin ON admin_id = complaint.admin_id\n"+
                    "WHERE complaint.canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteenId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("complaint_id");
                User user=new User();
                user.setName(rs.getString("user_name"));
                Canteen canteen=new Canteen();
                canteen.setName(rs.getString("canteen_name"));
                String time=rs.getString("time");
                String content=rs.getString("content");
                Admin admin=new Admin();
                admin.setName(rs.getString("admin_name"));
                String reply_content=rs.getString("reply_content");
                complaintList.add(new Complaint(id,user,canteen,time,content,admin,reply_content));
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
            String sql="UPDATE complaint SET admin_id = ?, reply_content = ? WHERE complaint_id=?";
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
