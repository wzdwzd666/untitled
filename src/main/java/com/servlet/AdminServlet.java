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
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="AdminServlet", value="/AdminServlet")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type=req.getParameter("type");
        String id=req.getParameter("id");
        String account=req.getParameter("newAccount");
        String name=req.getParameter("newName");
        String password=req.getParameter("newPassword");
        String canteenId=req.getParameter("newCanteenId");
        Admin admin=new Admin(id,account,name,password,canteenId);
        ServletContext context=req.getServletContext();
        List<Admin> adminList= (List<Admin>) context.getAttribute("adminList");
        String sql;
        int i;
        switch (type) {
            case "edit":
                sql = "UPDATE admin SET name = '" + admin.getName() + "', password = '" + admin.getPassword() + "', canteen_id = '" + admin.getCanteenId() + "' WHERE id = " + admin.getId();
                AdminDao.editAdmin(sql);
                for(i=0;i<adminList.size();i++){
                    if(adminList.get(i).getId().equals(id)){
                        adminList.set(i,admin);
                        break;
                    }
                }
                break;
            case "insert":
                PrintWriter out=resp.getWriter();
                if(AdminDao.findAdminByAccount(account)==null){
                    int newId=AdminDao.insertAdmin(admin);
                    admin.setId(String.valueOf(newId));
                    adminList.add(admin);
                    resp.setContentType("text/plain;charset=UTF-8");
                    out.println(newId);
                }else {
                    resp.setContentType("text/plain;charset=UTF-8");
                    out.println("accountError");
                }
                out.close();
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
            case "adminEdit":
                sql = "UPDATE admin SET name = '" + name + "', password = '" + password + "' WHERE id = " + id;
                AdminDao.editAdmin(sql);
                for(i=0;i<adminList.size();i++){
                    if(adminList.get(i).getId().equals(id)){
                        Admin admin1=adminList.get(i);
                        admin1.setName(name);
                        admin1.setPassword(password);
                        adminList.set(i,admin1);
                        req.getSession().setAttribute("admin",admin1);
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
