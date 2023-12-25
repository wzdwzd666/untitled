package com.dao;

import com.bean.Canteen;
import com.bean.CanteenEvaluate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CanteenEvaluateListDao {
    public static List<CanteenEvaluate> findAllCanteenEvaluate(){
        List<CanteenEvaluate> canteenEvaluateList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT id,user_id,canteen_id,content,reply_admin_id,reply_content FROM canteen_evaluate";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String user_id=rs.getString(2);
                String canteen_id=rs.getString(3);
                String content=rs.getString(4);
                String reply_admin_id=rs.getString(5);
                String reply_content=rs.getString(6);
                canteenEvaluateList.add(new CanteenEvaluate(id,user_id,canteen_id,content,reply_admin_id,reply_content));
            }
            rs.close();
            statement.close();
            connection.close();
            return canteenEvaluateList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
