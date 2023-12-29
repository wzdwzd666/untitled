package com.servlet;

import com.bean.Notice;
import com.dao.NoticeDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="NoticeServlet", value="/NoticeServlet")
public class NoticeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        Gson gson=new Gson();
        switch (type){
            case "getList":{
                List<Notice> noticeList= NoticeDao.findAllList();
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(noticeList));
                out.close();
                break;
            }
        }
    }
}
