package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.GetUserInfoDao;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetUserInfoResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

public class GetUserInfoDaoImpl implements GetUserInfoDao {

    public GetUserInfoResponseModel getUserInfo(long user_id, long info_user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        GetUserInfoResponseModel getUserInfoResponseModel=new GetUserInfoResponseModel();
        Query query = entityManager.createNamedQuery("Users.getInfo");
        long first = 0;
        long second = 0;
        if (user_id < info_user_id) {
            first = user_id;
            second = info_user_id;
        } else {
            first = info_user_id;
            second = user_id;
        }
        query.setParameter(1, first);
        query.setParameter(2, second);
        query.setParameter(3, info_user_id);
        query.setParameter(4, info_user_id);
        query.setParameter(5, info_user_id);
        query.setParameter(6, info_user_id);
        try{
            getUserInfoResponseModel = (GetUserInfoResponseModel) query.getSingleResult();
        }catch (Exception e){
            return  getUserInfoResponseModel;
        }finally {
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
        }

        return getUserInfoResponseModel;
    }

    public List<ChallengeResponseModel> getUserChallenges(long user_id, long info_user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> query = entityManager.createNamedQuery("Challenges.getUserChallenges",ChallengeResponseModel.class);
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        query.setParameter(3, info_user_id);
        query.setParameter(4, info_user_id);
        List<ChallengeResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }

    public List<ChallengeResponseModel> getUserAcceptedChallenges(long user_id, long info_user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> query = entityManager.createNamedQuery("Challenges.getAcceptedChallenges",ChallengeResponseModel.class);
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        query.setParameter(3, info_user_id);
        query.setParameter(4, info_user_id);
        List<ChallengeResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }

    public List<UsersBaseDataResponseModel> getUserRelationships(long info_user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<UsersBaseDataResponseModel> query = entityManager.createNamedQuery("Relationship.getRelationships",UsersBaseDataResponseModel.class);
        query.setParameter(1, info_user_id);
        query.setParameter(2, info_user_id);
        List<UsersBaseDataResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }
}
