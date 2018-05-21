package com.appchallengers.appchallengers.endpoint.service;

import com.appchallengers.appchallengers.dao.dao.ChallengesDao;
import com.appchallengers.appchallengers.dao.dao.ChallengesDetailDao;
import com.appchallengers.appchallengers.dao.dao.UserDao;
import com.appchallengers.appchallengers.dao.daoimpl.ChallengesDaoImpl;
import com.appchallengers.appchallengers.dao.daoimpl.ChallengesDetailDaoImpl;
import com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl;
import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import com.appchallengers.appchallengers.model.entity.ChallengeDetail;
import com.appchallengers.appchallengers.model.entity.Challenges;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.mongodb.dao.ChallengedDao;
import com.appchallengers.appchallengers.util.GlobalGson;
import com.appchallengers.appchallengers.util.Util;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.xml.registry.infomodel.User;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

@Path("/...")
public class ChallengesDetailService {

    ChallengesDetailDao challengesDetailDao =new ChallengesDetailDaoImpl();
    UserDao userDao=new UserDaoImpl();
    ChallengesDao challengesDao=new ChallengesDaoImpl();
    private String url = "http://appchallengers.com/images/";

    @POST
    @Path("/info")
    @Produces("application/json")
    public Response getChallengeInfo(@HeaderParam("token") String token, @FormParam("challengeId") long challengeId) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengesDetailDao.getChallengeDetailInfo(id,challengeId))).build();
        }
    }

    @POST
    @Path("/get_latest_challenges")
    @Produces("application/json")
    public Response getChallengeDetailOrderByTime(@HeaderParam("token") String token, @FormParam("challengeId") long challengeId) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengesDetailDao.getChallengeDetailOrderByTime(id,challengeId))).build();
        }
    }
    @POST
    @Path("/get_popular_challenges")
    @Produces("application/json")
    public Response getChallengeDetailOrderByLikes(@HeaderParam("token") String token, @FormParam("challengeId") long challengeId) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengesDetailDao.getChallengeDetailOrderByLikes(id,challengeId))).build();
        }
    }

    @POST
    @Path("/add_challenge_detail")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces("application/json")
    public Response addChallengeDetail(@HeaderParam("token") String token,
                                 @FormDataParam("video") InputStream uploadedInputStream,
                                 @FormDataParam("video") FormDataContentDisposition fileDetail,
                                 @FormDataParam("challengeId") long challengeId) throws CommonExceptionHandler {

        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
            String uploadedFileLocation ;
            String filename;
            try {
                filename = Util.hashMD5(currentTimestamp.toString() + token) + fileDetail.getFileName();
                uploadedFileLocation = "C:\\Users\\Administrator\\Desktop\\appchallengers\\med\\profileimages\\" + filename;
            } catch (NoSuchAlgorithmException e) {
                throw new CommonExceptionHandler("290");
            }
            Users users = userDao.findUserById(Util.getId(token));
            if (!Util.writeToFile(uploadedInputStream, uploadedFileLocation)) {
                throw new CommonExceptionHandler("290");
            }
            Challenges challenges = challengesDao.getChallenge(challengeId);
            ChallengeDetail challengeDetail = challengesDetailDao.addChallengesDetail(new ChallengeDetail(
                    challenges, users, url+filename, currentTimestamp
            ));
            ChallengeResponseModel challengeResponseModel = new ChallengeResponseModel(
                    users.getId(), users.getFullName(), users.getProfilePicture(),
                    challengeDetail.getChallenge().getId(),
                    challengeDetail.getId(),
                    challengeDetail.getChallenge_url(),
                    challengeDetail.getChallenge().getHeadLine(),
                    0, 0
            );
            return Response.status(Response.Status.OK).entity(GlobalGson.getGlobalGson().getGson().toJson(challengeResponseModel)).build();
        }

    }

    @POST
    @Path("/add_challenge_detail_notification")
    @Produces("application/json")
    public Response addChallengeDetilNotification(@HeaderParam("token") String token,
                                             @FormParam("ChallengeId") long challengeId,
                                             @FormParam("ChallengedList") String ChallengedList) throws CommonExceptionHandler {

        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            List<UsersBaseDataResponseModel> challengedListObject=GlobalGson.getGlobalGson().getGson().fromJson(ChallengedList,new TypeToken<List<UsersBaseDataResponseModel>>(){}.getType());
            Users users = userDao.findUserById(Util.getId(token));
            Challenges challenges = challengesDao.getChallenge(challengeId);
            challengesDao.addChallengeNotification(challenges,users,challengedListObject);
            return Response.status(200).build();
        }

    }
}
