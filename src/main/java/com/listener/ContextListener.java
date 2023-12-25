package com.listener;

import com.bean.Canteen;
import com.bean.CanteenEvaluate;
import com.bean.Food;
import com.dao.CanteenDao;
import com.dao.CanteenEvaluateListDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.ArrayList;
import java.util.List;
@WebListener
public class ContextListener implements ServletContextListener {
    List<Canteen> canteenList=new ArrayList<>();
    List<CanteenEvaluate> canteenEvaluateList=new ArrayList<>();
    List<Food> foodList=new ArrayList<>();
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        canteenList= CanteenDao.findAllCanteen();
//        canteenEvaluateList= CanteenEvaluateListDao.findAllCanteenEvaluate();
        ServletContext context=sce.getServletContext();
        context.setAttribute("canteenEvaluateList",canteenEvaluateList);
        context.setAttribute("canteenList",canteenList);
    }
}
