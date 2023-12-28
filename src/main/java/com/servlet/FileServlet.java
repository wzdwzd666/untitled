package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Path;
import java.nio.file.Paths;

//@WebServlet(name="FileServlet", value="/FileServlet")
//@MultipartConfig
//public class FileServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String type
//        String url;
//        switch (type) {
//            case "image":
//                url = "/assets/image/food/";
//                break;
//            case "topic":
//                url = "/assets/image/topic/";
//                break;
//            case "delete":
//                //删除
//                String path = request.getParameter("path");
//                System.out.println("删除文件：" + path);
//                Path targetPath = Paths.get(getServletContext().getRealPath("/"), path);
//                System.out.println("文件路径：" + targetPath);
//                boolean b = deleteFile(targetPath.toString());
//                if (b) {
//                    System.out.println("删除成功");
//                } else {
//                    System.out.println("删除失败");
//                }
//                return;
//            default:
//                return;
//        }
//        //保存
//        String path = null;
//        for (Part part : request.getParts()) {
//            if (part.getContentType() != null) {
//                // 获取上传文件的名称（包括后缀名）
//                String fileName = getFileName(part);
//                System.out.println("下载文件: " + fileName);
//                String targetPath = getServletContext().getRealPath(url) + fileName;
//                path=url+fileName;
//                // 将文件保存到目标路径
//                part.write(targetPath);
//                System.out.println("文件保存至: " + targetPath);
//            }
//        }
//        response.getWriter().println(path);
//    }
//    private String getFileName(Part part) {
//        String submittedFileName = part.getSubmittedFileName();
//
//        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
//            for (String contentDisposition : part.getHeader("content-disposition").split(";")) {
//                if (contentDisposition.trim().startsWith("filename")) {
//                    return contentDisposition.substring(contentDisposition.indexOf("=") + 2, contentDisposition.length() - 1);
//                }
//            }
//        }
//        return submittedFileName;
//    }
//    public boolean deleteFile(String filePath) {
//        try {
//            // 创建 File 对象
//            File fileToDelete = new File(filePath);
//
//            // 判断文件是否存在，然后进行删除操作
//            if (fileToDelete.exists()) {
//                return fileToDelete.delete();
//            }
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//        }
//        return false;
//    }
//}
@WebServlet(name = "FileServlet", value = "/FileServlet")
@MultipartConfig
public class FileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取 type 参数的 Part 对象
        Part typePart = request.getPart("type");
        System.out.println(typePart);
        if (typePart != null) {
            // 从 Part 对象中获取 type 参数值
            String type = readPartContent(typePart);
            System.out.println("Type parameter value: " + type);

            String url;
            switch (type) {
                case "image":
                    url = "/assets/image/food/";
                    break;
                case "topic":
                    url = "/assets/image/topic/";
                    break;
                case "delete":
                    // 删除
                    String path = request.getParameter("path");
                    path=path.replace("/untitled_war_exploded","");
                    System.out.println("删除文件：" + path);
                    Path targetPath = Paths.get(getServletContext().getRealPath("/"), path);
                    System.out.println(getServletContext().getRealPath("/"));
                    System.out.println("文件路径：" + targetPath);
                    boolean b = deleteFile(targetPath.toString());
                    if (b) {
                        System.out.println("删除成功");
                    } else {
                        System.out.println("删除失败");
                    }
                    return;
                default:
                    return;
            }

            // 保存
            String path = null;
            for (Part part : request.getParts()) {
                if (part.getContentType() != null) {
                    // 获取上传文件的名称（包括后缀名）
                    String fileName = getFileName(part);
                    System.out.println("下载文件: " + fileName);
                    String targetPath = getServletContext().getRealPath(url) + fileName;
                    path = "/untitled_war_exploded"+url + fileName;
                    // 将文件保存到目标路径
                    part.write(targetPath);
                    System.out.println("文件保存至: " + targetPath);
                }
            }
            response.getWriter().println(path);
        } else {
            // 处理 type 参数不存在的情况
            System.out.println("Type parameter is missing");
        }
    }

    private String readPartContent(Part part) throws IOException {
        StringBuilder content = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
        }
        return content.toString().trim();
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

    public boolean deleteFile(String filePath) {
        try {
            // 创建 File 对象
            File fileToDelete = new File(filePath);

            // 判断文件是否存在，然后进行删除操作
            if (fileToDelete.exists()) {
                return fileToDelete.delete();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}

