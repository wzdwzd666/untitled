package com.servlet;

import com.bean.Admin;
import com.bean.User;
import com.dao.AdminDao;
import com.dao.UserDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="UserServlet", value="/UserServlet")
public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
                String userType = req.getParameter("userType");
                UserDao.editUser(new User(id,null,name,password,userType));
                getAll(resp);
                break;
            }
            case "insert": {
                String account=req.getParameter("account");
                String name=req.getParameter("name");
                String password=req.getParameter("password");
                String userType=req.getParameter("userType");
                if (AdminDao.findAdminByAccount(account) == null&& UserDao.findUserByAccount(account) == null) {
                    UserDao.insertUser(new User(null,account,name,password,userType));
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
                UserDao.deleteUser(id);
                getAll(resp);
                break;
            }
            default:
        }
    }
    public void getAll(HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<User> userList=UserDao.findAllUser();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(userList));
        out.close();
    }
}
