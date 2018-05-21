package com.appchallengers.appchallengers.endpoint.service;

import com.appchallengers.appchallengers.dao.dao.ApplicationDao;
import com.appchallengers.appchallengers.dao.daoimpl.ApplicationDaoImpl;
import com.appchallengers.appchallengers.model.response.GetTrendsResponseModel;
import com.appchallengers.appchallengers.util.GlobalGson;
import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/...")
public class ApplicationService {

    ApplicationDao applicationDao = new ApplicationDaoImpl();

    @GET
    @Path("/get_country_list")
    @Produces("application/json")
    public Response getCountrList() {
        return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(applicationDao.getCountryList())).build();
    }

    @GET
    @Path("/get_trends_list")
    @Produces("application/json")
    public Response getTrendsList() {
        List<GetTrendsResponseModel> getTrendsResponseModelList = applicationDao.getTrendsList();
        return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(getTrendsResponseModelList)).build();
    }
}
