package com.dao;

import com.bean.Admin;
import com.bean.Canteen;
import com.bean.Notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoticeDao {
    public static List<Notice> findAllList(){
        List<Notice> noticeList = new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql="SELECT notice.*, admin.*, canteen.name AS canteen_name\n" +
                    "FROM notice\n" +
                    "JOIN admin ON notice.admin_id = admin.admin_id\n" +
                    "JOIN canteen ON admin.canteen_id = canteen.canteen_id\n" +
                    "ORDER BY notice.time DESC;\n";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                Admin admin = new Admin();
                admin.setId(rs.getString("admin_id"));
                admin.setName(rs.getString("name"));

                Canteen canteen = new Canteen();
                canteen.setId(rs.getString("canteen_id"));
                canteen.setName(rs.getString("canteen_name"));
                admin.setCanteen(canteen);

                Notice notice = new Notice();
                notice.setId(rs.getString("notice_id"));
                notice.setAdmin(admin);
                notice.setTitle(rs.getString("title"));
                notice.setTime(rs.getString("time"));
                notice.setContent(rs.getString("content"));
                noticeList.add(notice);
            }
            rs.close();
            statement.close();
            connection.close();
            return noticeList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void pushNotice(String adminId,String title,String time,String content){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO notice(admin_id,title,time,content) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,adminId);
            statement.setString(2,title);
            statement.setString(3,time);
            statement.setString(4,content);
            statement.execute();

            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static List<Notice> getByCanteen(String canteenId){
        List<Notice> noticeList = new ArrayList<>();
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return null;
        }
        try {
            String sql = "SELECT notice.*, admin.*, canteen.name AS canteen_name\n" +
                    "FROM notice\n" +
                    "JOIN admin ON notice.admin_id = admin.admin_id\n" +
                    "JOIN canteen ON admin.canteen_id = canteen.canteen_id\n" +
                    "WHERE canteen.canteen_id = ?\n" +  // 添加WHERE子句
                    "ORDER BY notice.time DESC;";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,canteenId);
            ResultSet rs=statement.executeQuery();
            while (rs.next()){
                Admin admin = new Admin();
                admin.setId(rs.getString("admin_id"));
                admin.setName(rs.getString("name"));

                Canteen canteen = new Canteen();
                canteen.setId(rs.getString("canteen_id"));
                canteen.setName(rs.getString("canteen_name"));
                admin.setCanteen(canteen);

                Notice notice = new Notice();
                notice.setId(rs.getString("notice_id"));
                notice.setAdmin(admin);
                notice.setTitle(rs.getString("title"));
                notice.setTime(rs.getString("time"));
                notice.setContent(rs.getString("content"));
                noticeList.add(notice);
            }
            rs.close();
            statement.close();
            connection.close();
            return noticeList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void editNotice(String id,String adminId, String title,String time,String content){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="UPDATE notice SET admin_id = ?, title = ?, time=?, content=? WHERE notice_id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,adminId);
            statement.setString(2,title);
            statement.setString(3,time);
            statement.setString(4,content);
            statement.setString(5,id);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void deleteNotice(String id){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="DELETE FROM notice WHERE notice_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(id));
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public static void insertNotice(String adminId, String title,String time,String content){
        Connection connection= MyConnection.getConnection();
        if(connection==null){
            return;
        }
        try {
            String sql="INSERT INTO notice(admin_id,title,time,content) VALUES (?,?,?,?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,adminId);
            statement.setString(2,title);
            statement.setString(3,time);
            statement.setString(4,content);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
