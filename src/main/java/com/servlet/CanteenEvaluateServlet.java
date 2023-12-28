package com.servlet;

import com.bean.Admin;
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
import java.util.List;

@WebServlet(name="CanteenEvaluateServlet", value="/CanteenEvaluateServlet")
public class CanteenEvaluateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type=req.getParameter("type");
        Gson gson=new Gson();
        switch (type) {
            case "getListByCanteenId": {
                String canteenId = req.getParameter("canteenId");
                if(canteenId==null){
                    Admin admin= (Admin) req.getSession().getAttribute("admin");
                    canteenId=admin.getCanteenId();
                }
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(getListByCanteenId(canteenId)));
                out.close();
                break;
            }
            case "edit": {
                String id = req.getParameter("id");
                String canteenId = req.getParameter("canteenId");
                if(canteenId==null){
                    Admin admin= (Admin) req.getSession().getAttribute("admin");
                    canteenId=admin.getCanteenId();
                }
                String replyContent = req.getParameter("replyContent");
                //回复的管理员
                Admin admin= (Admin)req.getSession().getAttribute("admin");
                String adminId = admin.getId();
                CanteenEvaluateListDao.editCanteenEvaluateById(id, adminId, replyContent);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(getListByCanteenId(canteenId)));
                out.close();
                break;
            }
            case "delete": {
                String id = req.getParameter("id");
                String canteenId = req.getParameter("canteenId");
                CanteenEvaluateListDao.deleteCanteenEvaluate(id);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(getListByCanteenId(canteenId)));
                out.close();
                break;
            }
        }
    }
    public List<CanteenEvaluate> getListByCanteenId(String canteenId){
        String sql="SELECT id,user_id,canteen_id,content,reply_admin_id,reply_content FROM canteen_evaluate WHERE canteen_id="+canteenId;
        return CanteenEvaluateListDao.findCanteenEvaluate(sql);
    }
}
