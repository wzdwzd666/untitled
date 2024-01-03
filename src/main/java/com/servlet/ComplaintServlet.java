package com.servlet;

import com.bean.Admin;
import com.bean.Complaint;
import com.bean.Food;
import com.dao.ComplaintDao;
import com.dao.FoodDao;
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
        switch (type) {
            case "getListByCanteenId": {
                String canteenId=admin.getCanteen().getId();
                getAll(canteenId,resp);
                break;
            }
            case "edit": {
                String id = req.getParameter("id");
                String replyContent = req.getParameter("replyContent");
                String adminId = admin.getId();
                ComplaintDao.editComplaintById(id, adminId, replyContent);
                String canteenId=admin.getCanteen().getId();
                getAll(canteenId,resp);
                break;
            }
        }
    }
    public void getAll(String canteenId, HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<Complaint> complaintList= ComplaintDao.getByCanteenId(canteenId);
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(complaintList));
        out.close();
    }
}
