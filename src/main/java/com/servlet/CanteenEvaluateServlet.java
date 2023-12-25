package com.servlet;

import com.bean.CanteenEvaluate;
import com.dao.CanteenEvaluateListDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name="CanteenEvaluateServlet", value="/CanteenEvaluateServlet")
public class CanteenEvaluateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        Gson gson=new Gson();
        if(type.equals("getListByCanteenId")){
            String canteenId=req.getParameter("canteenId");
            String sql="SELECT id,user_id,canteen_id,content,reply_admin_id,reply_content FROM canteen_evaluate WHERE canteen_id="+canteenId;
            List<CanteenEvaluate> canteenEvaluateList= CanteenEvaluateListDao.findCanteenEvaluate(sql);
            PrintWriter out=resp.getWriter();
            resp.setContentType("text/plain;charset=UTF-8");
            out.println(gson.toJson(canteenEvaluateList));
            out.close();
        } else if (type.equals("getListByAdminId")) {
            String s;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
