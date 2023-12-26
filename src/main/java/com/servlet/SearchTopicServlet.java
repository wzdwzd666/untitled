package com.servlet;

import com.bean.Topic;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchTopic")
public class SearchTopicServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");

        // 调用业务逻辑处理搜索操作
//        List<Topic> topics = TopicService.searchTopicsByTitle(title);

        // 将搜索结果放入 request 对象
//        request.setAttribute("topics", topics);

        // 转发到显示搜索结果的部分视图
        request.getRequestDispatcher("/topicListTable.jsp").forward(request, response);
    }
}
