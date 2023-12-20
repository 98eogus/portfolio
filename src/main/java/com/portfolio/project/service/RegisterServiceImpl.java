package com.portfolio.project.service;

import com.portfolio.project.dao.BannerDao;
import com.portfolio.project.dao.UserDao;
import com.portfolio.project.domain.CommentDto;
import com.portfolio.project.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegisterServiceImpl implements RegisterService {

    @Autowired
    UserDao userDao;

    @Override
    public int add(User user) throws Exception {
        return userDao.insertUser(user);
    }
}
