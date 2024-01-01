package com.dao;

import com.bean.Canteen;

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
            String sql="SELECT * FROM canteen";
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
    public static Canteen getCanteen(String canteenId){
        Canteen canteen=null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT * FROM canteen WHERE canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteenId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString(1);
                String name=rs.getString(2);
                String starTime=rs.getString(3);
                String endTime=rs.getString(4);
                String info=rs.getString(5);
                canteen=new Canteen(id,name,starTime,endTime,info);
            }
            rs.close();
            statement.close();
            connection.close();
            return canteen;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static Canteen getCanteen(String canteenId,String userId){
        Canteen canteen=null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT\n" +
                    "    canteen.*,\n" +
                    "    avg_rating.average_rating,\n" +
                    "    user_rating.user_rating\n" +
                    "FROM\n" +
                    "    canteen\n" +
                    "LEFT JOIN (\n" +
                    "    SELECT\n" +
                    "        canteen_id,\n" +
                    "        AVG(rating) AS average_rating\n" +
                    "    FROM\n" +
                    "        canteen_evaluate\n" +
                    "    GROUP BY\n" +
                    "        canteen_id\n" +
                    ") AS avg_rating ON canteen.canteen_id = avg_rating.canteen_id\n" +
                    "LEFT JOIN (\n" +
                    "    SELECT\n" +
                    "        canteen_id,\n" +
                    "        rating AS user_rating\n" +
                    "    FROM\n" +
                    "        canteen_evaluate\n" +
                    "    WHERE\n" +
                    "        user_id = ?\n" +
                    ") AS user_rating ON canteen.canteen_id = user_rating.canteen_id\n" +
                    "WHERE\n" +
                    "    canteen.canteen_id = ?  -- 添加特定 canteen_id 的条件\n" +
                    "ORDER BY\n" +
                    "    avg_rating.average_rating DESC;\n";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,userId);
            statement.setString(2,canteenId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("canteen_id");
                String name=rs.getString("name");
                String starTime=rs.getString("start_time");
                String endTime=rs.getString("end_time");
                String info=rs.getString("info");
                String averageRating=rs.getString("average_rating");
                if(averageRating==null){
                    averageRating="暂无数据";
                }
                String userRating=rs.getString("user_rating");
                if(userRating==null){
                    userRating="还没评分";
                }
                canteen=new Canteen(id,name,starTime,endTime,info,averageRating,userRating);
            }
            rs.close();
            statement.close();
            connection.close();
            return canteen;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<Canteen> getPopularCanteen(String userId){
        List<Canteen> canteenList=new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT\n" +
                    "    canteen.*,\n" +
                    "    avg_rating.average_rating,\n" +
                    "    user_rating.user_rating\n" +
                    "FROM\n" +
                    "    canteen\n" +
                    "LEFT JOIN (\n" +
                    "    SELECT\n" +
                    "        canteen_id,\n" +
                    "        AVG(rating) AS average_rating\n" +
                    "    FROM\n" +
                    "        canteen_evaluate\n" +
                    "    GROUP BY\n" +
                    "        canteen_id\n" +
                    ") AS avg_rating ON canteen.canteen_id = avg_rating.canteen_id\n" +
                    "LEFT JOIN (\n" +
                    "    SELECT\n" +
                    "        canteen_id,\n" +
                    "        rating AS user_rating\n" +
                    "    FROM\n" +
                    "        canteen_evaluate\n" +
                    "    WHERE\n" +
                    "        user_id = ?\n" +
                    ") AS user_rating ON canteen.canteen_id = user_rating.canteen_id\n" +
                    "ORDER BY\n" +
                    "    avg_rating.average_rating DESC;\n";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,userId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                String id=rs.getString("canteen_id");
                String name=rs.getString("name");
                String starTime=rs.getString("start_time");
                String endTime=rs.getString("end_time");
                String info=rs.getString("info");
                String averageRating=rs.getString("average_rating");
                if(averageRating==null){
                    averageRating="暂无数据";
                }
                String userRating=rs.getString("user_rating");
                if(userRating==null){
                    userRating="还没评分";
                }
                canteenList.add(new Canteen(id,name,starTime,endTime,info,averageRating,userRating));
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
            String sql="UPDATE canteen SET name = ?, start_time = ?, end_time=?, info=? WHERE canteen_id=?";
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
    public static void insertCanteen(Canteen canteen){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO canteen(name,start_time,end_time,info) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteen.getName());
            statement.setString(2,canteen.getStartTime());
            statement.setString(3,canteen.getEndTime());
            statement.setString(4,canteen.getInfo());
            statement.execute();
            statement.close();
            connection.close();
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
            String sql="DELETE FROM canteen WHERE canteen_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static String findCanteenByName(String name){
        String id = null;
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT name FROM canteen where name=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,name);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                id=rs.getString(1);
            }
            rs.close();
            statement.close();
            connection.close();
            return id;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
