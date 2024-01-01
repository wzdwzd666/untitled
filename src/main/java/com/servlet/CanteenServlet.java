package com.servlet;

import com.bean.Admin;
import com.bean.Canteen;
import com.bean.User;
import com.dao.AdminDao;
import com.dao.CanteenDao;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletContext;
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
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String startTime = req.getParameter("startTime");
        String endTime = req.getParameter("endTime");
        String info = req.getParameter("info");
        Canteen canteen = new Canteen(id, name, startTime, endTime, info);
        Gson gson=new Gson();
        switch (type) {
            case "getAll":{
                getAll(resp);
                break;
            }
            case "getCanteen":{
                String canteenId=req.getParameter("canteenId");
                if(canteenId==null){
                    Admin admin= (Admin) req.getSession().getAttribute("admin");
                    canteenId=admin.getCanteen().getId();
                }
                Canteen canteen1=CanteenDao.getCanteen(canteenId);
                PrintWriter out=resp.getWriter();
                System.out.println(canteen1);
                // 获取输出流
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(canteen1));
                out.close();
                break;
            }
            case "getDetailCanteen":{
                String canteenId=req.getParameter("canteenId");
                User user= (User) req.getSession().getAttribute("user");
                Canteen canteen1=CanteenDao.getCanteen(canteenId,user.getId());
                PrintWriter out=resp.getWriter();
                // 获取输出流
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(canteen1));
                out.close();
                break;
            }
            case "getPopularCanteen":{
                User user= (User) req.getSession().getAttribute("user");
                List<Canteen> canteenList=CanteenDao.getPopularCanteen(user.getId());
                System.out.println(canteenList);
                PrintWriter out=resp.getWriter();
                // 获取输出流
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(canteenList));
                out.close();
                break;
            }
            case "edit": {
                CanteenDao.editCanteenById(canteen);
                getAll(resp);
                break;
            }
            case "insert": {
                if (CanteenDao.findCanteenByName(canteen.getName()) == null) {
                    CanteenDao.insertCanteen(canteen);
                    getAll(resp);
                } else {
                    PrintWriter out=resp.getWriter();
                    // 获取输出流
                    resp.setContentType("text/plain;charset=UTF-8");
                    out.write("{\"message\": \"食堂名称已存在\"}");
                    out.close();
                }
                break;
            }
            case "delete":
                CanteenDao.deleteCanteen(id);
                List<Canteen> canteenList=CanteenDao.findAllCanteen();
                PrintWriter out=resp.getWriter();
                resp.setContentType("text/plain;charset=UTF-8");
                out.println(gson.toJson(canteenList));
                out.close();
                break;
            case "staffEdit": {
                String canteenId = req.getParameter("canteenId");
                String canteenName = req.getParameter("canteenName");
                String canteenStartTime = req.getParameter("canteenStartTime");
                String canteenEndTime = req.getParameter("canteenEndTime");
                String canteenInfo = req.getParameter("canteenInfo");
                Canteen canteen1 = new Canteen(canteenId, canteenName, canteenStartTime, canteenEndTime, canteenInfo);
                CanteenDao.editCanteenById(canteen1);
                break;
            }
            default:
        }
    }
    public void getAll(HttpServletResponse resp) throws IOException {
        Gson gson=new Gson();
        PrintWriter out=resp.getWriter();
        List<Canteen> canteenList= CanteenDao.findAllCanteen();
        resp.setContentType("text/plain;charset=UTF-8");
        out.println(gson.toJson(canteenList));
        out.close();
    }
}
