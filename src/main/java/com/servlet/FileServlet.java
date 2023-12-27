package com.servlet;

import com.utils.FileUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

@WebServlet(name="FileServlet", value="/FileServlet")
@MultipartConfig
public class FileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        for (Part part : request.getParts()) {
            // 获取上传文件的名称（包括后缀名）
            String fileName = getFileName(part);
            System.out.println("Uploaded file name: " + fileName);

            // 获取项目的根目录
            String rootPath = getServletContext().getRealPath("/");

            // 拼接保存文件的目标路径
//            String targetPath = rootPath + File.separator + "uploads" + File.separator + fileName;
            String targetPath = getServletContext().getRealPath("/assets/image/food/") + fileName;
            System.out.println(targetPath);
            // 将文件保存到目标路径
            part.write(targetPath);

            System.out.println("File saved to: " + targetPath);
        }
        response.getWriter().println("File(s) uploaded successfully.");
    }

    private String getFileName(Part part) {
        String submittedFileName = part.getSubmittedFileName();

        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
            for (String contentDisposition : part.getHeader("content-disposition").split(";")) {
                if (contentDisposition.trim().startsWith("filename")) {
                    return contentDisposition.substring(contentDisposition.indexOf("=") + 2, contentDisposition.length() - 1);
                }
            }
        }
        return submittedFileName;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path=req.getParameter("path");
        FileUtils fileUtils=new FileUtils();
        String targetPath = getServletContext() + path;
        boolean b=fileUtils.deleteFile(targetPath);
        if(b){
            System.out.println("wwwwwwwwwwwww");
        }else {
            System.out.println("llllllllll");
        }
    }
}
