package com.portfolio.project.service;

import com.portfolio.project.dao.BannerDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BannerServiceImpl implements BannerService{

    @Autowired
    BannerDao bannerDao;

    @Override
    public List<String> listBanner() throws Exception {
        return bannerDao.listBanner();
    }
}
