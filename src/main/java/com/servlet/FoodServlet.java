package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="FoodServlet", value="/FoodServlet")
public class FoodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        String id=req.getParameter("foodId");
        String canteenId=req.getParameter("canteenId");
        String name=req.getParameter("name");
        String cuisine=req.getParameter("cuisine");
        String image=req.getParameter("price");
        switch (type){
            case "edit":
                break;
            case "delete":
                break;
            case "insert":
                break;
        }
    }
}
