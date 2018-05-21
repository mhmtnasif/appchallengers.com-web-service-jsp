package com.appchallengers.appchallengers.endpoint.service;

import com.appchallengers.appchallengers.dao.dao.UserDao;
import com.appchallengers.appchallengers.dao.daoimpl.UserDaoImpl;
import com.appchallengers.appchallengers.endpoint.error_handling.CommonExceptionHandler;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.request.LoginRequestModel;
import com.appchallengers.appchallengers.model.request.SignUpRequestModel;
import com.appchallengers.appchallengers.model.response.UserPreferenceDataResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.EmailUtil;
import com.appchallengers.appchallengers.util.GlobalGson;
import com.appchallengers.appchallengers.util.Util;
import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

import javax.mail.MessagingException;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Locale;


@Path("/....")
public class UserAccountService {

    private UserDao mUserDao = new UserDaoImpl();
    private String url = "http://appchallengers.com/images/";

    @POST
    @Path("/create/with_image")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces("application/json")
    public Response createAccountWithImage(
            @FormDataParam("image") InputStream uploadedInputStream,
            @FormDataParam("image") FormDataContentDisposition fileDetail,
            @FormDataParam("fullName") String fullName,
            @FormDataParam("email") String email,
            @FormDataParam("password") String password,
            @FormDataParam("country") String country) throws CommonExceptionHandler {
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        String filename;
        String uploadedFileLocation;
        try {
            filename = Util.hashMD5(currentTimestamp.toString() + email) + fileDetail.getFileName();
            uploadedFileLocation = "C:\\Users\\Administrator\\Desktop\\appchallengers\\med\\profileimages\\" + filename;
        } catch (NoSuchAlgorithmException e) {
            throw new CommonExceptionHandler("290");
        }
        Long emailCheckStatus = mUserDao.checkEmail(email);
        if (emailCheckStatus == 0) {
            if (!Util.writeToFile(uploadedInputStream, uploadedFileLocation)) {
                uploadedFileLocation = null;
            }
            Users createdUser = null;
            try {
                createdUser = mUserDao.saveUser(new Users(
                        fullName.toLowerCase(), email.toLowerCase(), Util.hashMD5(password),
                        Util.hashMD5(currentTimestamp.toString() + password),
                        country.toLowerCase(), url + filename, Users.Active.NOT_CONFİRMED,
                        currentTimestamp, currentTimestamp
                ));
            } catch (NoSuchAlgorithmException e) {
                throw new CommonExceptionHandler("290");
            }
            UserPreferenceDataResponseModel userPreferenceDataResponseModel = null;
            try {
                userPreferenceDataResponseModel = new UserPreferenceDataResponseModel(
                        Util.createToken(createdUser.getEmail(), createdUser.getFullName(), createdUser.getId()),
                        createdUser.getFullName(), createdUser.getProfilePicture(),
                        createdUser.getEmail(), createdUser.getActive().ordinal(), createdUser.getCountry()
                );
            } catch (UnsupportedEncodingException e) {
                throw new CommonExceptionHandler("290");
            }
            String info="Bir mail Doğrulama isteğinde yada şifre değiştirme isteğinde " +
                    "bulunduysan aşağıdaki linki tarayıcıya yapıştır ve bilgilerini gir.Böyle bir istekte bulunmadıysan," +
                    "bu epostayı yoksayabilirsin";
            String url = "http://appchallengers.com/confirm.jsp?id=" + createdUser.getId() + "&" + "hash=" + createdUser.getPasswordSalt();
            try {
                EmailUtil.sendEmail(createdUser.getEmail(), "Confirm Email", info+url);
            } catch (MessagingException e) {
                e.printStackTrace();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            } finally {
                return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(userPreferenceDataResponseModel)).build();
            }
        } else if (emailCheckStatus == 1) {
            throw new CommonExceptionHandler("250");
        } else {
            throw new CommonExceptionHandler("290");
        }
    }

    @POST
    @Path("/create/without_image")
    @Consumes("application/json")
    @Produces("application/json")
    public Response createAccountWithoutImage(SignUpRequestModel signUpRequestModel) throws CommonExceptionHandler {
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Long emailCheckStatus = mUserDao.checkEmail(signUpRequestModel.getEmail());
        if (emailCheckStatus == 0) {
            Users createdUser = null;
            try {
                createdUser = mUserDao.saveUser(new Users(
                        signUpRequestModel.getFullName().toLowerCase(), signUpRequestModel.getEmail().toLowerCase(),
                        Util.hashMD5(signUpRequestModel.getPassword()),
                        Util.hashMD5(currentTimestamp.toString() + signUpRequestModel.getPassword()),
                        signUpRequestModel.getCountry().toLowerCase(), Users.Active.NOT_CONFİRMED,
                        currentTimestamp, currentTimestamp
                ));
            } catch (NoSuchAlgorithmException e) {
                throw new CommonExceptionHandler("290");
            }
            UserPreferenceDataResponseModel userPreferenceDataResponseModel = null;
            try {
                userPreferenceDataResponseModel = new UserPreferenceDataResponseModel(
                        Util.createToken(createdUser.getEmail(), createdUser.getFullName(), createdUser.getId()),
                        createdUser.getFullName(), createdUser.getProfilePicture(),
                        createdUser.getEmail(), createdUser.getActive().ordinal(), createdUser.getCountry()
                );
            } catch (UnsupportedEncodingException e) {
                throw new CommonExceptionHandler("290");
            }
            String info="Bir mail Doğrulama isteğinde yada şifre değiştirme isteğinde " +
                    "bulunduysan aşağıdaki linki tarayıcıya yapıştır ve bilgilerini gir.Böyle bir istekte bulunmadıysan," +
                    "bu epostayı yoksayabilirsin";
            String url = "http://appchallengers.com/confirm.jsp?id=" + createdUser.getId() + "&" + "hash=" + createdUser.getPasswordSalt();
            try {
                EmailUtil.sendEmail(createdUser.getEmail(), "Confirm Email", info+url);
            } catch (MessagingException e) {
                e.printStackTrace();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            } finally {
                return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(userPreferenceDataResponseModel)).build();
            }
        } else if (emailCheckStatus == 1) {
            throw new CommonExceptionHandler("250");
        } else {
            throw new CommonExceptionHandler("290");
        }
    }


    @POST
    @Path("/login")
    @Consumes("application/json")
    @Produces("application/json")
    public Response login(LoginRequestModel loginRequestModel) throws CommonExceptionHandler {
        Long status = null;
        try {
            status = (Long) mUserDao.login(loginRequestModel.getEmail(), Util.hashMD5(loginRequestModel.getPassword()));
        } catch (NoSuchAlgorithmException e) {
            throw new CommonExceptionHandler("290");
        }
        if (status == 0) {
            throw new CommonExceptionHandler("251");
        } else if (status == 1) {
            Users user = mUserDao.findByEmail(loginRequestModel.getEmail());
            UserPreferenceDataResponseModel userPreferenceDataResponseModel = null;
            try {
                userPreferenceDataResponseModel = new UserPreferenceDataResponseModel(
                        Util.createToken(user.getEmail(), user.getFullName(), user.getId()),
                        user.getFullName(), user.getProfilePicture(),
                        user.getEmail(), user.getActive().ordinal(), user.getCountry()
                );
            } catch (UnsupportedEncodingException e) {
                throw new CommonExceptionHandler("290");
            }
            return Response.status(200).entity(GlobalGson.getGlobalGson().getGson().toJson(userPreferenceDataResponseModel)).build();
        } else {
            throw new CommonExceptionHandler("290");
        }
    }

    @GET
    @Path("/send_email")
    @Produces("application/json")
    public Response resendConfirmEmail(@HeaderParam("token") String token) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            Users user = mUserDao.findUserById(Util.getId(token));
            String info="Bir mail Doğrulama isteğinde yada şifre değiştirme isteğinde " +
                    "bulunduysan aşağıdaki linki tarayıcıya yapıştır ve bilgilerini gir.Böyle bir istekte bulunmadıysan," +
                    "bu epostayı yoksayabilirsin";
            String url = "http://appchallengers.com/confirm.jsp?id=" + user.getId() + "&" + "hash=" + user.getPasswordSalt();
            try {
                EmailUtil.sendEmail(user.getEmail(), "Confirm Email", info+url);
            } catch (MessagingException e) {
                throw new CommonExceptionHandler("254");
            } catch (UnsupportedEncodingException e) {
                throw new CommonExceptionHandler("254");
            }
            return Response.status(200).build();
        }
    }

    @GET
    @Path("/check_confirm_email")
    @Produces("application/json")
    public Response checkConfirmEmail(@HeaderParam("token") String token) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            Users user = mUserDao.findUserById(Util.getId(token));
            if (user.getActive() == Users.Active.NOT_CONFİRMED) {
                throw new CommonExceptionHandler("253");
            } else {
                return Response.status(200).build();
            }
        }
    }

    @PUT
    @Path("/change_password")
    @Produces("application/json")
    public Response changePassword(@HeaderParam("token") String token,
                                   @FormParam("oldPassword") String oldPassword,
                                   @FormParam("newPassword") String newPassWord) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            Users user = mUserDao.findUserById(id);
            String oldPasswordHash = "";
            String newPasswordHash = "";
            try {
                oldPasswordHash = Util.hashMD5(oldPassword);
                newPasswordHash = Util.hashMD5(newPassWord);
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
                throw new CommonExceptionHandler("290");
            }
            if (oldPasswordHash.equals(user.getPasswordHash())) {
                mUserDao.changePassword(id, newPasswordHash);
                return Response.status(200).build();
            } else {
                throw new CommonExceptionHandler("255");
            }
        }
    }

    @PUT
    @Path("/update_email")
    @Produces("application/json")
    public Response updateEmail(@HeaderParam("token") String token,
                                @FormParam("oldEmail") String oldEmail,
                                @FormParam("newEmail") String newEmail) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            Users user = mUserDao.findUserById(id);
            if (user.getEmail().equalsIgnoreCase(oldEmail)) {
                if (mUserDao.checkEmail(newEmail) == 0) {
                    mUserDao.updateEmail(id, newEmail.toLowerCase());
                    String info="Bir mail Doğrulama isteğinde yada şifre değiştirme isteğinde " +
                            "bulunduysan aşağıdaki linki tarayıcıya yapıştır ve bilgilerini gir.Böyle bir istekte bulunmadıysan," +
                            "bu epostayı yoksayabilirsin";
                    String url = "http://appchallengers.com/confirm.jsp?id=" + user.getId() + "&" + "hash=" + user.getPasswordSalt();
                    try {
                        EmailUtil.sendEmail(user.getEmail(), "Confirm Email", info+url);
                    } catch (MessagingException e) {
                        throw new CommonExceptionHandler("254");
                    } catch (UnsupportedEncodingException e) {
                        throw new CommonExceptionHandler("254");
                    }
                    return Response.status(200).build();
                } else {
                    throw new CommonExceptionHandler("257");
                }

            } else {
                throw new CommonExceptionHandler("256");
            }
        }

    }

    @PUT
    @Path("/update_profile_with_photo")
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces("application/json")
    public Response updateProfileWithPhoto(
            @HeaderParam("token") String token,
            @FormDataParam("image") InputStream uploadedInputStream,
            @FormDataParam("image") FormDataContentDisposition fileDetail,
            @FormDataParam("fullName") String fullName,
            @FormDataParam("country") String country) throws CommonExceptionHandler {
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            String uploadedFileLocation;
            String filename;
            try {
                filename = Util.hashMD5(currentTimestamp.toString() + id) + fileDetail.getFileName();
                uploadedFileLocation = "C:\\Users\\Administrator\\Desktop\\appchallengers\\med\\profileimages\\" + filename;
            } catch (NoSuchAlgorithmException e) {
                throw new CommonExceptionHandler("290");
            }
            if (!Util.writeToFile(uploadedInputStream, uploadedFileLocation)) {
                throw new CommonExceptionHandler("290");
            }
            mUserDao.updateProfileWithPhoto(id, url + filename, fullName.toLowerCase(), country.toLowerCase());
            return Response.status(200).entity((GlobalGson.getGlobalGson().getGson().toJson(new UsersBaseDataResponseModel(id, fullName, url + filename)))).build();
        }
    }

    @PUT
    @Path("/update_profile_without_photo")
    @Produces("application/json")
    public Response updateProfileWithoutPhoto(
            @HeaderParam("token") String token,
            @FormParam("fullName") String fullName,
            @FormParam("country") String country) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            mUserDao.updateProfileWithoutPhoto(id, fullName.toLowerCase(), country.toLowerCase());
            return Response.status(200).build();
        }
    }

    @PUT
    @Path("/delete_profile_photo")
    @Produces("application/json")
    public Response deleteProfilePhoto(
            @HeaderParam("token") String token) throws CommonExceptionHandler {
        if (token == null || token.equals("")) {
            throw new CommonExceptionHandler("289");
        } else {
            long id = Util.getId(token);
            mUserDao.deleteProfilePhoto(id);
            return Response.status(200).build();
        }
    }
}




