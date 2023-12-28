package com.listener;

import com.bean.*;
import com.dao.AdminDao;
import com.dao.CanteenDao;
import com.dao.CanteenEvaluateListDao;
import com.dao.FoodDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.ArrayList;
import java.util.List;
@WebListener
public class ContextListener implements ServletContextListener {
    List<Admin> adminList=new ArrayList<>();
    List<Canteen> canteenList=new ArrayList<>();
    List<Food> foodList=new ArrayList<>();
    List<String> cuisineList=new ArrayList<>();
    List<Topic> topicList=new ArrayList<>();
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("ServletContext启动");
        ServletContext context=sce.getServletContext();
        adminList = AdminDao.findAllAdmin();
        canteenList = CanteenDao.findAllCanteen();
        foodList = FoodDao.findAllFood();
        cuisineList=FoodDao.findAllCuisine();
        System.out.println(foodList);
        context.setAttribute("adminList",adminList);
        context.setAttribute("canteenList",canteenList);
        context.setAttribute("foodList",foodList);
        context.setAttribute("cuisineList",cuisineList);
    }
}
