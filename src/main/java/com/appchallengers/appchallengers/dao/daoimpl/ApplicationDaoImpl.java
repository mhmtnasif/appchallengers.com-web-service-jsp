package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.ApplicationDao;
import com.appchallengers.appchallengers.model.entity.Country;
import com.appchallengers.appchallengers.model.response.GetTrendsResponseModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;


public class ApplicationDaoImpl implements ApplicationDao {

    public List<Country> getCountryList() {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Country> countryTypedQuery = entityManager.createNamedQuery("Country.getCountryList",Country.class);
        List<Country> resultList = countryTypedQuery.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return resultList;
    }

    public List<GetTrendsResponseModel> getTrendsList() {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<GetTrendsResponseModel> namedQuery = entityManager.createNamedQuery("Challenges.getTrends",GetTrendsResponseModel.class);
        List<GetTrendsResponseModel> getTrendsResponsModels = namedQuery.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getTrendsResponsModels;
    }
}
