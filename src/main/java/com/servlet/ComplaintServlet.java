package com.servlet;

import com.bean.Admin;
import com.bean.Complaint;
import com.dao.ComplaintDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="ComplaintServlet", value="/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        Admin admin= (Admin) req.getSession().getAttribute("admin");
        Gson gson=new Gson();
        switch (type) {
            case "getListByCanteenId": {
                String canteenId=admin.getCanteenId();
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(getListByCanteenId(canteenId)));
                out.close();
                break;
            }
            case "edit": {
                String id = req.getParameter("id");
                String canteenId=admin.getCanteenId();
                String replyContent = req.getParameter("replyContent");
                //回复的管理员
                String adminId = admin.getId();
                ComplaintDao.editComplaintById(id, adminId, replyContent);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(getListByCanteenId(canteenId)));
                out.close();
                break;
            }
        }
    }
    public List<Complaint> getListByCanteenId(String canteenId){
        String sql="SELECT * FROM complaint WHERE canteen_id="+canteenId;
        return ComplaintDao.findComplaint(sql);
    }
}
