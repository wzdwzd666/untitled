package com.servlet;

import com.bean.Canteen;
import com.dao.CanteenDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="CanteenServlet", value="/CanteenServlet")
public class CanteenServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type=req.getParameter("type");
        String id=req.getParameter("id");
        String name=req.getParameter("newName");
        String startTime=req.getParameter("newStartTime");
        String endTime=req.getParameter("newEndTime");
        String info=req.getParameter("newInfo");
        Canteen canteen=new Canteen(id,name,startTime,endTime,info);
        ServletContext context=req.getServletContext();
        List<Canteen> canteenList= (List<Canteen>) context.getAttribute("canteenList");
        int i;
        switch (type) {
            case "edit":
                CanteenDao.editCanteenById(canteen);
                for(i=0;i<canteenList.size();i++){
                    if(canteenList.get(i).getId().equals(id)){
                        canteenList.set(i,canteen);
                        break;
                    }
                }
                break;
            case "insert":
                int newId=CanteenDao.insertCanteen(canteen);
                canteen.setId(String.valueOf(newId));
                canteenList.add(canteen);
                resp.setContentType("text/plain;charset=UTF-8");
                // 获取输出流
                resp.getWriter().println(newId);
                break;
            case "delete":
                System.out.println("8888888888888888888888");
                CanteenDao.deleteCanteen(id);
                for(i=0;i<canteenList.size();i++){
                    if(canteenList.get(i).getId().equals(id)){
                        canteenList.remove(i);
                        break;
                    }
                }
                break;
            default:
                return;
        }
        context.setAttribute("canteenList",canteenList);
    }
}
