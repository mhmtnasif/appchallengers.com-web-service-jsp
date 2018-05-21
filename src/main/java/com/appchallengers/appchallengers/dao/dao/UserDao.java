package com.appchallengers.appchallengers.dao.dao;

import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;

import java.util.List;

public interface UserDao {

    Users saveUser(Users user);
    Users findByEmail(String email);
    Long checkEmail(String email);
    Long checkIdAndPasswordSalt(long id,String passwordSalt);
    void confirmEmail(long id,String passwordSalt);
    void changePassword(long id,String passwordHash);
    Users findUserById(long id);
    Long login(String email,String passwordHash);
    void updateEmail(long id,String email);
    void updateProfileWithPhoto(long id,String uploadedFileLocation,String name,String country);
    void updateProfileWithoutPhoto(long id,String name,String country);
    void deleteProfilePhoto(long id);
    List<UsersBaseDataResponseModel> search(String param);
}
