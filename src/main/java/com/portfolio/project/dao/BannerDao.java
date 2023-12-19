package com.portfolio.project.dao;

import com.portfolio.project.domain.BoardDto;

import java.util.List;

public interface BannerDao {

    List<String> listBanner() throws Exception // List<E> selectList(String statement)
    ;
}
