package com.dao;

import com.bean.Canteen;
import com.bean.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CanteenDao {
    public static List<Canteen> findAllCanteen() {
        List<Canteen> canteenList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="select id,name,start_time,end_time,info from canteen";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String name=rs.getString(2);
                String starTime=rs.getString(3);
                String endTime=rs.getString(4);
                String info=rs.getString(5);
                canteenList.add(new Canteen(id,name,starTime,endTime,info));
            }
            rs.close();
            statement.close();
            connection.close();
            return canteenList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
