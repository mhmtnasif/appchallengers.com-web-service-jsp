package com.appchallengers.appchallengers.endpoint.service;



import com.appchallengers.appchallengers.dao.dao.ChallengesDao;
import com.appchallengers.appchallengers.dao.dao.UserDao;
import com.appchallengers.appchallengers.dao.daoimpl.ChallengesDaoImpl;
import com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl;
import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import com.appchallengers.appchallengers.model.response.SearchChallengesResponseModel;
import com.appchallengers.appchallengers.model.response.SearchResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.GlobalGson;
import com.google.gson.Gson;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/....")
public class UserSearchService {

    UserDao userDao=new UserDaoImpl();
    ChallengesDao challengesDao=new ChallengesDaoImpl();

    @POST
    @Path("/search")
    @Produces("application/json")
    public Response search(@HeaderParam("token") String token, @FormParam("param") String param) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            String de="%"+param+"%";
            List<UsersBaseDataResponseModel> users=userDao.search(de.toLowerCase());
            List<SearchChallengesResponseModel> challenges=challengesDao.search(de.toLowerCase());
            return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(new SearchResponseModel(users,challenges))).build();
        }
    }

}
