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
                admin.setCanteenId(rs.getString("canteen_id"));

                Canteen canteen = new Canteen();
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
}
