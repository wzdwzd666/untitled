package com.servlet;

import com.bean.Topic;
import com.bean.User;
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
            case "addLike": {
                String id = req.getParameter("id");
                User user= (User) req.getSession().getAttribute("user");
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                if(TopicDao.checkLike(id,user.getId())){
                    out.write("{\"message\": \"点赞过了\"}");
                }else {
                    TopicDao.addLike(id,user.getId());
                    String like=TopicDao.getLike(id);
                    out.write("{\"message\": \""+like+"\"}");
                }
                out.close();
                break;
            }
            case "cancelLike": {
                String id = req.getParameter("id");
                User user= (User) req.getSession().getAttribute("user");
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                if(TopicDao.checkLike(id,user.getId())){
                    TopicDao.cancelLike(id,user.getId());
                    String like=TopicDao.getLike(id);
                    out.write("{\"message\": \""+like+"\"}");
                }else {
                    out.write("{\"message\": \"还没点赞\"}");
                }
                out.close();
                break;
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
        System.out.println(topicList);
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(topicList));
        out.close();
    }
}
