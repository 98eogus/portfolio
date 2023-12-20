package com.portfolio.project.service;

import com.portfolio.project.domain.CommentDto;
import com.portfolio.project.domain.User;

public interface RegisterService {

    int add(User user) throws Exception;
}
