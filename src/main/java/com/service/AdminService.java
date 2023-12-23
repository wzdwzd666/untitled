package com.service;

import com.bean.Admin;
import com.dao.AdminDao;

public class AdminService {
    public Admin findUserByAccount(String account){
        return AdminDao.findAdminByName(account);
    }
}
