package com.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

//@WebFilter("/*")
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        //1.强制转换
        HttpServletRequest request = (HttpServletRequest) req;
        //2.获取请求资源路径
        String requestURI = request.getRequestURI();
        //3.判断是否包含登录相关资源路径,同时排除css,js，图片等
        if (requestURI.contains("/index.jsp") || requestURI.contains("/LoginServlet")||requestURI.contains("/assets/")) {
            //放行
            chain.doFilter(req, resp);
        } else {
            //4.判断是否登录
            Object user = request.getSession().getAttribute("user");
            if (user != null) {
                //已登录，放行
                chain.doFilter(req, resp);
            }else {
                //未登录，跳转登陆页面
                request.setAttribute("login_msg","您未登录");
                request.getRequestDispatcher("/index.jsp").forward(request,resp);
            }
        }
    }
    @Override
    public void destroy() {

    }
}


