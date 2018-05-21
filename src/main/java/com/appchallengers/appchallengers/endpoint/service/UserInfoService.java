package com.appchallengers.appchallengers.endpoint.service;

import com.appchallengers.appchallengers.dao.dao.GetUserInfoDao;
import com.appchallengers.appchallengers.dao.daoimpl.GetUserInfoDaoImpl;
import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.GlobalGson;
import com.appchallengers.appchallengers.util.Util;
import com.google.gson.Gson;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/...")
public class UserInfoService {

    GetUserInfoDao getUserInfoDao = new GetUserInfoDaoImpl();

    @POST
    @Path("/info")
    @Produces("application/json")
    public Response getUserInfo(@HeaderParam("token") String token, @FormParam("get_user_id") long get_user_id) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(getUserInfoDao.getUserInfo(id, get_user_id))).build();
        }
    }

    @POST
    @Path("/get_challenges")
    @Produces("application/json")
    public Response getUserChallenges(@HeaderParam("token") String token, @FormParam("get_user_id") long get_user_id) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            List<ChallengeResponseModel> challengeResponsModels = getUserInfoDao.getUserChallenges(id, get_user_id);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengeResponsModels)).build();
        }
    }

    @POST
    @Path("/get_accepted_challenges")
    @Produces("application/json")
    public Response getUserAcceptedChallenges(@HeaderParam("token") String token, @FormParam("get_user_id") long get_user_id) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            List<ChallengeResponseModel> challengeResponsModels = getUserInfoDao.getUserAcceptedChallenges(id, get_user_id);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengeResponsModels)).build();
        }
    }
    @POST
    @Path("/get_relationships")
    @Produces("application/json")
    public Response getUserRelationships(@HeaderParam("token") String token, @FormParam("get_user_id") long get_user_id) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            List<UsersBaseDataResponseModel> challengeResponses = getUserInfoDao.getUserRelationships(get_user_id);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengeResponses)).build();
        }
    }
}
