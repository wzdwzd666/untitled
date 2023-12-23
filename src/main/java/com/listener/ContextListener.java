package com.listener;

import com.bean.Canteen;
import com.bean.Food;
import com.dao.CanteenDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.ArrayList;
import java.util.List;
@WebListener
public class ContextListener implements ServletContextListener {
    List<Canteen> canteenList=new ArrayList<>();
    List<Food> foodList=new ArrayList<>();
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        canteenList= CanteenDao.findAllCanteen();
        ServletContext context=sce.getServletContext();
        context.setAttribute("canteenList",canteenList);
    }
}
