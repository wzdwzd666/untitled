package com.servlet;

import com.bean.User;
import com.dao.AdminDao;
import com.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name="RegisterServlet", value="/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type=request.getParameter("type");
        String account=request.getParameter("account");
        String name=request.getParameter("name");
        String password=request.getParameter("password");
        if(AdminDao.findAdminByAccount(account) == null&& UserDao.findUserByAccount(account) == null){
            User newUser=new User(null,account,name,password,type);
            UserDao.insertUser(newUser);
            User user=UserDao.findUserByAccount(account);
            HttpSession session=request.getSession();
            session.setAttribute("user",user);
            request.getRequestDispatcher("/canteen-web.jsp").forward(request,response);
        }else {
            request.getRequestDispatcher("/register.jsp?error=registerAccount").forward(request,response);
        }
    }
}
