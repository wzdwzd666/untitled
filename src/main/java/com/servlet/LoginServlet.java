package com.servlet;

import com.bean.Admin;
import com.bean.User;
import com.dao.AdminDao;
import com.dao.UserDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name="LoginServlet", value="/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type=request.getParameter("type");
        String account=request.getParameter("account");
        String password=request.getParameter("password");
        ServletContext context=request.getServletContext();
        if(type.equals("user")){
            User user= UserDao.findUserByAccount(account);
            if(user==null) {
                request.getRequestDispatcher("/index.jsp?error=userAccount").forward(request,response);
            }else if (user.getPassword().equals(password)) {
                HttpSession session=request.getSession();
                session.setAttribute("user",user);
                request.getRequestDispatcher("/canteenHome.jsp").forward(request,response);
            }else {
                request.getRequestDispatcher("/index.jsp?error=password").forward(request,response);
            }
        }else {
            Admin admin= AdminDao.findAdminByAccount(account);
            if(admin==null){
                request.getRequestDispatcher("/index.jsp?error=adminAccount").forward(request,response);
            } else if (admin.getPassword().equals(password)) {
                HttpSession session=request.getSession();
                session.setAttribute("admin",admin);
                if(admin.getCanteenId()==null){
                    List<Admin> adminList=AdminDao.findAllAdmin();
                    context.setAttribute("adminList",adminList);
                    request.getRequestDispatcher("/systemPage.jsp").forward(request,response);
                }else {
                    request.getRequestDispatcher("/staffCanteenPage.jsp").forward(request,response);
                }
            }else {
                request.getRequestDispatcher("/index.jsp?error=adminPassword").forward(request,response);
            }
        }
    }
}
