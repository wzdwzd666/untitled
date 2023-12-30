package com.servlet;

import com.bean.Admin;
import com.bean.CanteenEvaluate;
import com.bean.User;
import com.dao.CanteenEvaluateListDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PipedReader;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="CanteenEvaluateServlet", value="/CanteenEvaluateServlet")
public class CanteenEvaluateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type=req.getParameter("type");
        switch (type) {
            case "getListByCanteenId": {
                String canteenId = req.getParameter("canteenId");
                if(canteenId==null){
                    Admin admin= (Admin) req.getSession().getAttribute("admin");
                    canteenId=admin.getCanteen().getId();
                }
                System.out.println(canteenId);
                getListByCanteenId(canteenId,resp);
                break;
            }
            case "edit": {
                String id = req.getParameter("id");
                String canteenId = req.getParameter("canteenId");
                if(canteenId==null){
                    Admin admin= (Admin) req.getSession().getAttribute("admin");
                    canteenId=admin.getCanteen().getId();
                }
                String replyContent = req.getParameter("replyContent");
                //回复的管理员
                Admin admin= (Admin)req.getSession().getAttribute("admin");
                String adminId = admin.getId();
                CanteenEvaluateListDao.editCanteenEvaluateById(id, adminId, replyContent);
                getListByCanteenId(canteenId,resp);
                break;
            }
            case "delete": {
                String id = req.getParameter("id");
                String canteenId = req.getParameter("canteenId");
                CanteenEvaluateListDao.deleteCanteenEvaluate(id);
                getListByCanteenId(canteenId,resp);
                break;
            }
            case "userReply":
                String canteenId=req.getParameter("canteenId");
                String reply=req.getParameter("reply");
                double rating = Double.parseDouble(req.getParameter("rating"));
                User user= (User) req.getSession().getAttribute("user");
                CanteenEvaluateListDao.insertEvaluate(user.getId(),canteenId,reply,rating);
                getListByCanteenId(canteenId,resp);
                break;
        }
    }
    public void getListByCanteenId(String canteenId,HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<CanteenEvaluate> canteenEvaluateList = CanteenEvaluateListDao.findEvaluateByCanteenId(canteenId);
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(canteenEvaluateList));
        out.close();
    }
}
