package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.GetProfileDao;
import com.appchallengers.appchallengers.dao.dao.GetUserInfoDao;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetUserInfoResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

public class GetProfileDaoImpl implements GetProfileDao {

    public GetUserInfoResponseModel getProfileInfo(long user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Query query = entityManager.createNamedQuery("Users.getInfo");
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        query.setParameter(3, user_id);
        query.setParameter(4, user_id);
        query.setParameter(5, user_id);
        query.setParameter(6, user_id);
        GetUserInfoResponseModel getUserInfoResponseModel = (GetUserInfoResponseModel) query.getSingleResult();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserInfoResponseModel;
    }

    public List<ChallengeResponseModel> getProfileChallenges(long user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> query = entityManager.createNamedQuery("Challenges.getUserChallenges",ChallengeResponseModel.class);
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        query.setParameter(3, user_id);
        query.setParameter(4, user_id);
        List<ChallengeResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }

    public List<ChallengeResponseModel> getProfileAcceptedChallenges(long user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> query = entityManager.createNamedQuery("Challenges.getAcceptedChallenges",ChallengeResponseModel.class);
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        query.setParameter(3, user_id);
        query.setParameter(4, user_id);
        List<ChallengeResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }

    public List<UsersBaseDataResponseModel> getProfileRelationships(long user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<UsersBaseDataResponseModel> query = entityManager.createNamedQuery("Relationship.getRelationships",UsersBaseDataResponseModel.class);
        query.setParameter(1, user_id);
        query.setParameter(2, user_id);
        List<UsersBaseDataResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }
}
