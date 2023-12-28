package com.servlet;

import com.bean.Admin;
import com.bean.Food;
import com.dao.CanteenDao;
import com.dao.FoodDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name="FoodServlet", value="/FoodServlet")
public class FoodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        String id=req.getParameter("id");
        Admin admin=(Admin)req.getSession().getAttribute("admin");
        String canteenId=admin.getCanteenId();
        String name=req.getParameter("name");
        String cuisine=req.getParameter("cuisine");
        String image=req.getParameter("image");
        String price=req.getParameter("price");
        Food food=new Food(id,name,canteenId,cuisine,image,price);
        ServletContext context=req.getServletContext();
        List<Food> foodList= (List<Food>) context.getAttribute("foodList");
        System.out.println("图片"+image);
        int i;
        switch (type){
            case "edit":
                FoodDao.editFood(food);
                for(i=0;i<foodList.size();i++){
                    if(foodList.get(i).getId().equals(id)){
                        foodList.set(i,food);
                        break;
                    }
                }
                break;
            case "delete":
                FoodDao.deleteFood(id);
                for(i=0;i<foodList.size();i++){
                    if(foodList.get(i).getId().equals(id)){
                        foodList.remove(i);
                        break;
                    }
                }
                break;
            case "insert":
                int newId= FoodDao.insertFood(food);
                food.setId(String.valueOf(newId));
                foodList.add(food);
                break;
        }
        context.setAttribute("foodList",foodList);
    }
}
