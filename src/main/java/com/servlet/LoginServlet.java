package com.servlet;

import com.bean.Admin;
import com.bean.User;
import com.service.AdminService;
import com.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name="LoginServlet", value="/LoginServlet")
public class LoginServlet extends HttpServlet {
    UserService userService;
    AdminService adminService;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type=request.getParameter("type");
        String account=request.getParameter("account");
        String password=request.getParameter("password");
        if(type.equals("user")){
            User user= userService.findUserByAccount(account);
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
            Admin admin=adminService.findUserByAccount(account);
            if(admin==null){
                request.getRequestDispatcher("/index.jsp?error=adminAccount").forward(request,response);
            } else if (admin.getPassword().equals(password)) {
                HttpSession session=request.getSession();
                session.setAttribute("admin",admin);
                if(admin.getType().equals("0")){
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
