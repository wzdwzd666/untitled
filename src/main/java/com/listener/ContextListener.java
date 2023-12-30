package com.listener;

import com.bean.*;
import com.dao.*;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.ArrayList;
import java.util.List;
@WebListener
public class ContextListener implements ServletContextListener {
    List<String> cuisineList=new ArrayList<>();
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("ServletContext启动");
        ServletContext context=sce.getServletContext();
//        adminList = AdminDao.findAllAdmin();
//        canteenList = CanteenDao.findAllCanteen();
//        foodList = FoodDao.findAllFood();
        cuisineList=FoodDao.findAllCuisine();
//        userList=UserDao.findAllUser();
//        topicEvaluateList=TopicEvaluateDao.getList();
//        context.setAttribute("adminList",adminList);
//        context.setAttribute("canteenList",canteenList);
//        context.setAttribute("foodList",foodList);
        context.setAttribute("cuisineList",cuisineList);
//        context.setAttribute("user",userList);
//        context.setAttribute("topicEvaluateList",topicEvaluateList);
    }
}
