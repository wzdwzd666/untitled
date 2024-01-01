package com.servlet;

import com.bean.Topic;
import com.bean.User;
import com.dao.TopicDao;
import com.dao.UserDao;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
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
            case "getByUserId": {
                String userId=req.getParameter("userId");
                List<Topic> topicList=TopicDao.findUserTopic(userId);
                Gson gson=new Gson();
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(topicList));
                out.close();
                break;
            }
//            //获取当前时间
//            Date date=new Date();
//            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String time=formatter.format(date);
            case "getPopularTopic":{
                List<Topic> topicList=TopicDao.getPopularTopic();
                Gson gson=new Gson();
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(topicList));
                out.close();
                break;
            }
            case "delete": {
                String id = req.getParameter("id");
                TopicDao.deleteTopic(id);
                getAll(resp);
                break;
            }
            case "searchTopic": {
                Gson gson=new Gson();
                String searchContent=req.getParameter("searchContent");
                List<Topic> topicList=TopicDao.searchTopic(searchContent);
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
            case "checkLike":{
                String topicId=req.getParameter("topicId");
                User user= (User) req.getSession().getAttribute("user");
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                if(TopicDao.checkLike(topicId,user.getId())){
                    out.write("{\"message\": \"已点赞\"}");
                }else {
                    out.write("{\"message\": \"点赞\"}");
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
            case "like": {
                String id = req.getParameter("id");
                User user= (User) req.getSession().getAttribute("user");
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                if(TopicDao.checkLike(id,user.getId())){
                    TopicDao.cancelLike(id,user.getId());
                    String like=TopicDao.getLike(id);
                    // 将数据组织成一个 JSON 对象
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("message", "点赞");
                    jsonResponse.addProperty("like", like);
                    out.write(jsonResponse.toString());
                }else {
                    TopicDao.addLike(id,user.getId());
                    String like=TopicDao.getLike(id);
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("message", "取消点赞");
                    jsonResponse.addProperty("like", like);
                    out.write(jsonResponse.toString());
                }
                out.close();
                break;
            }
            case "addTopic": {
                String image=req.getParameter("image");
                String content=req.getParameter("content");
                User user= (User) req.getSession().getAttribute("user");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time=formatter.format(new Date());
                TopicDao.insertTopic(user.getId(),time,content,image);
                getAll(resp);
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
