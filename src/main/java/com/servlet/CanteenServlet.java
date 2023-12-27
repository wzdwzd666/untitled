package com.servlet;

import com.bean.Canteen;
import com.dao.CanteenDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
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
                if(CanteenDao.findCanteenByName(canteen.getName())==null){
                    int newId=CanteenDao.insertCanteen(canteen);
                    canteen.setId(String.valueOf(newId));
                    canteenList.add(canteen);
                    // 获取输出流
                    resp.setContentType("text/plain;charset=UTF-8");
                    resp.getWriter().println(newId);
                }else {
                    // 获取输出流
                    resp.setContentType("text/plain;charset=UTF-8");
                    resp.getWriter().println("食堂名称已存在");
                }
                break;
            case "delete":
                CanteenDao.deleteCanteen(id);
                for(i=0;i<canteenList.size();i++){
                    if(canteenList.get(i).getId().equals(id)){
                        canteenList.remove(i);
                        break;
                    }
                }
                break;
            case "staffEdit":
                String canteenId=req.getParameter("canteenId");
                String canteenName=req.getParameter("canteenName");
                String canteenStartTime=req.getParameter("canteenStartTime");
                String canteenEndTime=req.getParameter("canteenEndTime");
                String canteenInfo=req.getParameter("canteenInfo");
                Canteen canteen1=new Canteen(canteenId,canteenName,canteenStartTime,canteenEndTime,canteenInfo);
                CanteenDao.editCanteenById(canteen1);
                for(i=0;i<canteenList.size();i++){
                    if(canteenList.get(i).getId().equals(canteenId)){
                        canteenList.set(i,canteen1);
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
