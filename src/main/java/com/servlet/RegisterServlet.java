package com.servlet;

import com.bean.User;
import com.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="RegisterServlet", value="/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    UserService userService;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        User user= userService.findUserByAccount(username);
        if(user!=null){
        }
    }
}
