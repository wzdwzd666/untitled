package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {
    private static final String HOST_ADDRESS="localhost";
    private static  final String DATABASE_NAME="canteen_design";

    private static final String USER="root";
    private static final String PASS_WORD="2003";

//    private static final String USER="canteen_design";
//    private static final String PASS_WORD="123456";
    private  static  final String DBURL="jdbc:mysql://"+HOST_ADDRESS+":3306/"+DATABASE_NAME+"?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DBURL,USER,PASS_WORD);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        catch (SQLException e){
            System.out.println(e.getMessage());
        }
        return  null;
    }
}
