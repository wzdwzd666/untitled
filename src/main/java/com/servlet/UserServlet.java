package com.servlet;

import com.bean.User;
import com.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="UserServlet", value="/UserServlet")
public class UserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        System.out.println(type);
        switch (type){
            case "edit":
                User user= (User) req.getSession().getAttribute("user");
                String id=user.getId();
                String name=req.getParameter("name");
                String password=req.getParameter("password");
                String userType=req.getParameter("userType");
                UserDao.editUser(new User(id,null,name,password,userType));
                User loginUser= (User) req.getSession().getAttribute("user");
                loginUser.setName(name);
                loginUser.setPassword(password);
                loginUser.setType(type);
                req.getSession().setAttribute("user",loginUser);
                break;
        }
    }
}
