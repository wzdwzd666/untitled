package com.service;

import com.bean.User;
import com.dao.UserDao;

public class UserService {
    public User findUserByAccount(String account){
        return UserDao.findUserByName(account);
    }

}
