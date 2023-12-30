package com.servlet;

import com.bean.Admin;
import com.bean.Canteen;
import com.bean.Food;
import com.dao.CanteenDao;
import com.dao.FoodDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="FoodServlet", value="/FoodServlet")
public class FoodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        System.out.println(type);
        switch (type){
            case "getAll":{
                getAll(resp);
                return;
            }
            case "edit": {
                String id=req.getParameter("id");
                String name=req.getParameter("name");
                String cuisine=req.getParameter("cuisine");
                String image=req.getParameter("image");
                String price=req.getParameter("price");
                System.out.println("图片" + image);
                FoodDao.editFood(id,name,cuisine,image,price);
                getAll(resp);
                break;
            }
            case "delete": {
                String id=req.getParameter("id");
                FoodDao.deleteFood(id);
                getAll(resp);
                break;
            }
            case "insert": {
                String id=req.getParameter("id");
                String name=req.getParameter("name");
                Canteen canteen=new Canteen();
                Admin admin= (Admin) req.getSession().getAttribute("admin");
                canteen.setId(admin.getCanteenId());
                String cuisine=req.getParameter("cuisine");
                String image=req.getParameter("image");
                String price=req.getParameter("price");
                Food food=new Food(id,name,canteen,cuisine,image,price,null,null);
                FoodDao.insertFood(food);
                getAll(resp);
                System.out.println("图片" + image);
                break;
            }
            case "addRecommend": {
                String id = req.getParameter("id");
                FoodDao.addRecommend(id);
                getAll(resp);
                break;
            }
            case "deleteRecommend": {
                String id = req.getParameter("id");
                FoodDao.deleteRecommend(id);
                getAll(resp);
                break;
            }
        }
    }
    public void getAll(HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<Food> foodList=FoodDao.findAllFood();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(foodList));
        out.close();
    }
}
