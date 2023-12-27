package com.utils;

import java.io.File;

public class FileUtils {
    public boolean deleteFile(String filePath) {
        try {
            System.out.println(filePath);
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
