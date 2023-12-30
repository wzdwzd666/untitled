package com.servlet;

import com.bean.Admin;
import com.bean.Canteen;
import com.dao.AdminDao;
import com.dao.CanteenDao;
import com.dao.UserDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="AdminServlet", value="/AdminServlet")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type=req.getParameter("type");
        switch (type) {
            case "getAll":{
                getAll(resp);
                break;
            }
            case "edit": {
                String id = req.getParameter("id");
                String name = req.getParameter("name");
                String password = req.getParameter("password");
                AdminDao.editAdmin(id,name,password);
                getAll(resp);
                break;
            }
            case "insert": {
                String account=req.getParameter("account");
                String name=req.getParameter("name");
                String password=req.getParameter("password");
                String canteenId=req.getParameter("canteenId");
                if (AdminDao.findAdminByAccount(account) == null&& UserDao.findUserByAccount(account) == null) {
                    AdminDao.insertAdmin(account,name,password,canteenId);
                    getAll(resp);
                } else {
                    PrintWriter out = resp.getWriter();
                    resp.setContentType("text/plain;charset=UTF-8");
                    out.write("{\"message\": \"账号已存在\"}");
                    out.close();
                }
            }
                break;
            case "delete": {
                String id=req.getParameter("id");
                AdminDao.deleteAdmin(id);
                getAll(resp);
                break;
            }
            default:
        }
    }
    public void getAll(HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<Admin> adminList=AdminDao.findAllAdmin();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(adminList));
        out.close();
    }
}
