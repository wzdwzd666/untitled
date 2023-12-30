package com.servlet;

import com.bean.Topic;
import com.dao.TopicDao;
import com.dao.UserDao;
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
        switch (type) {
            case "getAll": {
                getAll(resp);
                break;
            }
//            //获取当前时间
//            Date date=new Date();
//            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String time=formatter.format(date);
            case "delete": {
                String id = req.getParameter("id");
                TopicDao.deleteTopic(id);
                getAll(resp);
                break;
            }
            case "searchByTitle": {
                Gson gson=new Gson();
                String searchTitle=req.getParameter("searchTitle");
                List<Topic> topicList=TopicDao.searchByTitle(searchTitle);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(topicList));
                out.close();
            }
            case "like": {
//                String id = req.getParameter("id");
//                String like = req.getParameter("like");
//                int likeCount = Integer.parseInt(like + 1);
//                TopicDao.addLike(id, String.valueOf(likeCount));
//                String sql = "SELECT * FROM topic";
//                List<Topic> topicList = TopicDao.findTopic(sql);
//                PrintWriter out = resp.getWriter();
//                resp.setContentType("text/plain;charset=UTF-8");
//                out.println(gson.toJson(topicList));
//                out.close();
//                break;
            }
            case "getTopic": {
                Gson gson=new Gson();
                String id = req.getParameter("id");
                Topic topic=TopicDao.getTopicById(id);
                PrintWriter out = resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(topic));
                out.close();
                break;
            }
        }
    }
    public void getAll(HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<Topic> topicList= TopicDao.findAllTopic();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(topicList));
        out.close();
    }
}
