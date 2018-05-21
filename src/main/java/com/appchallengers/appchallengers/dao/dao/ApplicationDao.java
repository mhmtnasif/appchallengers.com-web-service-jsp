package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.model.entity.Country;
import com.appchallengers.appchallengers.model.response.GetTrendsResponseModel;

import java.util.List;

public interface ApplicationDao {

    List<Country> getCountryList();
    List<GetTrendsResponseModel> getTrendsList();
}
