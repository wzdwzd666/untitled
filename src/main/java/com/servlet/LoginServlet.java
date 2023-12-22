package com.servlet;

import com.bean.User;
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
    UserService userService=new UserService();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        User user= userService.findUserByName(username);
        if(user==null) {
            request.getRequestDispatcher("/index.jsp?error=username").forward(request,response);
        }else if (user.getPassword().equals(password)) {
            HttpSession session=request.getSession();
            session.setAttribute("user",user);
            request.getRequestDispatcher("/canteenHome.jsp").forward(request,response);
        }else {
            request.getRequestDispatcher("/index.jsp?error=password").forward(request,response);
        }
    }
}
