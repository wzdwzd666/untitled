package com.servlet;

import com.bean.TopicEvaluate;
import com.bean.User;
import com.dao.TopicEvaluateDao;
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

@WebServlet(name="TopicEvaluateServlet", value="/TopicEvaluateServlet")
public class TopicEvaluateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        switch (type){
            case "getById": {
                String topicId = req.getParameter("topicId");
                getById(topicId,resp);
                break;
            }
            case "postComment":{
                String topicId=req.getParameter("topicId");
                String content=req.getParameter("content");
                User user= (User) req.getSession().getAttribute("user");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time=formatter.format(new Date());
                TopicEvaluateDao.postEvaluate(topicId,user.getId(),time,content);
                getById(topicId,resp);
                break;
            }
        }
    }
    public void getById(String topicId,HttpServletResponse resp) throws IOException {
        Gson gson = new Gson();
        List<TopicEvaluate> topicEvaluateList = TopicEvaluateDao.getListById(topicId);
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(topicEvaluateList));
        out.close();
    }
}
