package com.servlet;

import com.bean.Admin;
import com.bean.Canteen;
import com.dao.AdminDao;
import com.dao.CanteenDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name="AdminServlet", value="/AdminServlet")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type=req.getParameter("type");
        String id=req.getParameter("id");
        String account=req.getParameter("account");
        String name=req.getParameter("name");
        String password=req.getParameter("password");
        String canteenId=req.getParameter("canteenId");
        Admin admin=new Admin(id,account,name,password,canteenId);
        ServletContext context=req.getServletContext();
        List<Admin> adminList= (List<Admin>) context.getAttribute("adminList");
        int i;
        switch (type) {
            case "edit":
                AdminDao.editAdminById(admin);
                for(i=0;i<adminList.size();i++){
                    if(adminList.get(i).getId().equals(id)){
                        adminList.set(i,admin);
                        break;
                    }
                }
                break;
            case "insert":
                int newId=AdminDao.insertAdmin(admin);
                admin.setId(String.valueOf(newId));
                adminList.add(admin);
                resp.setContentType("text/plain;charset=UTF-8");
                // 获取输出流
                resp.getWriter().println(newId);
                break;
            case "delete":
                AdminDao.deleteAdmin(admin.getId());
                for(i=0;i<adminList.size();i++){
                    if(adminList.get(i).getId().equals(id)){
                        adminList.remove(i);
                        break;
                    }
                }
                break;
            default:
                return;
        }
        context.setAttribute("adminList",adminList);
    }
}
