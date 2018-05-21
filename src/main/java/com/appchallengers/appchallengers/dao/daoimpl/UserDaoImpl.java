package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.UserDao;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.JpaFactory;
import com.appchallengers.appchallengers.util.Util;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.io.File;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;
import java.util.Locale;

public class UserDaoImpl implements UserDao {


    public Users saveUser(Users users) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(users);
        entityManager.flush();
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return users;
    }

    public Users findByEmail(String email) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Users> usersTypedQuery = entityManager.createNamedQuery("Users.findUserByEmail", Users.class);
        usersTypedQuery.setParameter("email", email);
        Users user = usersTypedQuery.getSingleResult();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return user;
    }


    public Long checkEmail(String email) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Long> longTypedQuery = entityManager.createNamedQuery("Users.checkEmail", Long.class);
        longTypedQuery.setParameter("email", email);
        long status=longTypedQuery.getSingleResult();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return status;
    }

    public Long checkIdAndPasswordSalt(long id, String passwordSalt) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Long> longTypedQuery = entityManager.createNamedQuery("Users.checkIdAndPasswordSalt", Long.class);
        longTypedQuery.setParameter("id", id);
        longTypedQuery.setParameter("passwordSalt", passwordSalt);
        long status=longTypedQuery.getSingleResult();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return status;
    }

    public void confirmEmail(long id, String passwordSalt) {
        if (checkIdAndPasswordSalt(id, passwordSalt) == 1) {
            EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
            entityManager.getTransaction().begin();
            Users user = entityManager.find(Users.class, id);
            user.setActive(Users.Active.ACTIVE);
            try {
                user.setPasswordSalt(Util.hashMD5(user.getPasswordHash() + user.getPasswordSalt()));
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
            entityManager.merge(user);
            entityManager.getTransaction().commit();
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
        }

    }

    public void changePassword(long id, String passwordHash) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Users user = entityManager.find(Users.class, id);
        user.setPasswordHash(passwordHash);
        user.setUpdateDate(currentTimestamp);
        try {
            user.setPasswordSalt(Util.hashMD5(user.getPasswordHash() + user.getPasswordSalt()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        entityManager.merge(user);
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
    }


    public Users findUserById(long id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Users users = entityManager.find(Users.class, id);
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return users;
    }

    public Long login(String email, String passwordHash) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Long> longTypedQuery = entityManager.createNamedQuery("Users.login", Long.class);
        longTypedQuery.setParameter("email", email);
        longTypedQuery.setParameter("passwordHash", passwordHash);
        long status=longTypedQuery.getSingleResult();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return status;
    }

    public void updateEmail(long id, String email) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Users user = entityManager.find(Users.class, id);
        user.setEmail(email);
        user.setActive(Users.Active.NOT_CONFİRMED);
        user.setUpdateDate(currentTimestamp);
        entityManager.merge(user);
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
    }

    public void updateProfileWithPhoto(long id,String uploadedFileLocation, String name, String country) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Users user = entityManager.find(Users.class, id);
        user.setCountry(country);
        user.setFullName(name);
        user.setProfilePicture(uploadedFileLocation);
        user.setUpdateDate(currentTimestamp);
        entityManager.merge(user);
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
    }

    public void updateProfileWithoutPhoto(long id, String name, String country) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Users user = entityManager.find(Users.class, id);
        user.setCountry(country);
        user.setFullName(name);
        user.setUpdateDate(currentTimestamp);
        entityManager.merge(user);
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
    }

    public void deleteProfilePhoto(long id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance(Locale.US).getTime().getTime());
        Users user = entityManager.find(Users.class, id);
        user.setProfilePicture(null);
        user.setUpdateDate(currentTimestamp);
        entityManager.merge(user);
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();

    }


    public List<UsersBaseDataResponseModel> search(String param) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<UsersBaseDataResponseModel> query = entityManager.createNamedQuery("Users.search", UsersBaseDataResponseModel.class);
        query.setParameter(1, param);
        query.setParameter(2, param);
        List<UsersBaseDataResponseModel> usersBaseDatumResponseModels =query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return usersBaseDatumResponseModels;
    }
}
