package com.appchallengers.appchallengers.endpoint.service;

import com.appchallengers.appchallengers.dao.dao.UserNotifications;
import com.appchallengers.appchallengers.dao.daoimpl.UserNotificationsImpl;
import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;
import com.appchallengers.appchallengers.util.GlobalGson;
import com.appchallengers.appchallengers.util.Util;
import com.google.gson.Gson;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/...")
public class UserNotificationService {

    UserNotifications userNotifications = new UserNotificationsImpl();

    @GET
    @Path("/get_user_notification")
    @Produces("application/json")
    public Response getUserNotification(@HeaderParam("token") String token) throws CommonExceptionHandler {

        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            List<ChallengedModel> challengedModels = userNotifications.getUserNotifications(Util.getId(token));
            return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(challengedModels)).build();
        }
    }

    @GET
    @Path("/has_notification")
    @Produces("application/json")
    public Response hasNotification(@HeaderParam("token") String token) throws CommonExceptionHandler {

        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            if (userNotifications.hasNotifications(Util.getId(token))) {
                return Response.status(200).build();
            }else{
                return Response.status(404).build();
            }

        }
    }

}
