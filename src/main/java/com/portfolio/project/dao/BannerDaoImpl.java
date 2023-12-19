package com.portfolio.project.dao;

import com.portfolio.project.domain.BoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BannerDaoImpl implements BannerDao{
    private static String namespace = "com.portfolio.project.dao.BannerMapper.";

    @Autowired
    private SqlSession session;


    @Override
    public List<String> listBanner() throws Exception {
        return session.selectList(namespace+"selectAll");
    } // List<E> selectList(String statement)

}
