package com.servlet;

import com.bean.Admin;
import com.bean.Notice;
import com.bean.Topic;
import com.dao.NoticeDao;
import com.dao.TopicDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name="NoticeServlet", value="/NoticeServlet")
public class NoticeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        Gson gson=new Gson();
        System.out.println(type);
        switch (type){
            case "getList":{
                List<Notice> noticeList= NoticeDao.findAllList();
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(noticeList));
                out.close();
                break;
            }
            case "pushNotice":{
                String title=req.getParameter("title");
                String content=req.getParameter("content");
                Admin admin= (Admin) req.getSession().getAttribute("admin");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time=formatter.format(new Date());
                NoticeDao.pushNotice(admin.getId(),title,time,content);
            }
            case "getByCanteen" :{
                Admin admin= (Admin) req.getSession().getAttribute("admin");
                getByCanteen(admin.getCanteen().getId(),resp);
//                List<Notice> noticeList=NoticeDao.getByCanteen(admin.getCanteen().getId());
//                PrintWriter out=resp.getWriter();
//                resp.setContentType("text/plain;charset=UTF-8");
//                out.println(gson.toJson(noticeList));
//                out.close();
                break;
            }
            case "edit" :{
                String id=req.getParameter("id");
                String title=req.getParameter("title");
                String content=req.getParameter("content");
                Admin admin= (Admin) req.getSession().getAttribute("admin");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time=formatter.format(new Date());
                NoticeDao.editNotice(id,admin.getId(),title,time,content);
                getByCanteen(admin.getCanteen().getId(),resp);
                break;
            }
            case "delete": {
                String id=req.getParameter("id");
                NoticeDao.deleteNotice(id);
                Admin admin= (Admin) req.getSession().getAttribute("admin");
                getByCanteen(admin.getCanteen().getId(),resp);
            }
            case "insert":{
                String title=req.getParameter("title");
                String content=req.getParameter("content");
                Admin admin= (Admin) req.getSession().getAttribute("admin");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time=formatter.format(new Date());
                NoticeDao.insertNotice(admin.getId(),title,time,content);
                getByCanteen(admin.getCanteen().getId(),resp);
            }
        }
    }
    public void getByCanteen(String canteenId,HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        List<Notice> noticeList=NoticeDao.getByCanteen(canteenId);
        PrintWriter out=resp.getWriter();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(noticeList));
        out.close();
    }
}
