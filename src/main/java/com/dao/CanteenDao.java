package com.dao;

import com.bean.Canteen;
import com.bean.User;

import java.sql.*;
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
            String sql="SELECT id,name,start_time,end_time,info FROM canteen";
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
    public static void editCanteenById(Canteen canteen) {
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE canteen SET name = ?, start_time = ?, end_time=?, info=? WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteen.getName());
            statement.setString(2,canteen.getStartTime());
            statement.setString(3,canteen.getEndTime());
            statement.setString(4,canteen.getInfo());
            statement.setString(5,canteen.getId());
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static int insertCanteen(Canteen canteen){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return 0;
        }
        try {
            String sql="INSERT INTO canteen(name,start_time,end_time,info) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,canteen.getName());
            statement.setString(2,canteen.getStartTime());
            statement.setString(3,canteen.getEndTime());
            statement.setString(4,canteen.getInfo());
            int affectedRows = statement.executeUpdate();
            int id=0;
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        // 在这里使用获取到的自增主键值（id）
                        id = generatedKeys.getInt(1);
                    }
                }
            }
            statement.close();
            connection.close();
            return id;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteCanteen(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM canteen WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
