package com.service;

import com.bean.User;
import com.dao.UserDao;

public class UserService {
    public User findUserByName(String username){
        return UserDao.findUserByName(username);
    }

}
