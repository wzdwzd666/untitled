package com.servlet;

import com.bean.Topic;
import com.dao.TopicDao;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="TopicServlet", value="/TopicServlet")
public class TopicServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        Gson gson=new Gson();
        switch (type) {
            case "getList": {
                String sql="SELECT * FROM topic";
                List<Topic> topicList = TopicDao.findTopic(sql);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(topicList));
                out.close();
                break;
            }
//            //获取当前时间
//            Date date=new Date();
//            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String time=formatter.format(date);
//            case "edit": {
//                String id = req.getParameter("id");
//                String canteenId = req.getParameter("canteenId");
//                String replyContent = req.getParameter("replyContent");
//                //回复的管理员
//                Admin admin= (Admin)req.getSession().getAttribute("admin");
//                String adminId = admin.getId();
//                CanteenEvaluateListDao.editCanteenEvaluateById(id, adminId, replyContent);
//                PrintWriter out = resp.getWriter();
//                resp.setContentType("text/plain;charset=UTF-8");
//                out.println(gson.toJson(getListByCanteenId(canteenId)));
//                out.close();
//                break;
//            }
            case "delete": {
                String id = req.getParameter("id");
                TopicDao.deleteTopic(id);
                break;
            }
            case "searchByTitle": {
                String searchTitle=req.getParameter("searchTitle");
                String sql="SELECT * FROM topic WHERE title like '%"+searchTitle+"%'";
                List<Topic> topicList=TopicDao.findTopic(sql);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(topicList));
                out.close();
            }
        }
    }
}
