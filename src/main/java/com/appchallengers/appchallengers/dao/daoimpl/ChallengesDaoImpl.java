package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.ChallengesDao;
import com.appchallengers.appchallengers.model.entity.Challenges;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.SearchChallengesResponseModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.mongodb.dao.ChallengedDao;
import com.appchallengers.appchallengers.mongodb.daoimpl.ChallengedDaoImpl;
import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.Collection;
import java.util.List;

public class ChallengesDaoImpl implements ChallengesDao {

    public Challenges addChallenge(Challenges challenge) {
        EntityManager entityManager= JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(challenge);
        entityManager.flush();
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return challenge;
    }

    public List<SearchChallengesResponseModel> search(String param) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<SearchChallengesResponseModel> query = entityManager.createNamedQuery("Challenges.search", SearchChallengesResponseModel.class);
        query.setParameter(1, param);
        List<SearchChallengesResponseModel> resultList =query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return resultList;
    }

    public Challenges getChallenge(long challengeId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Challenges challenge=entityManager.find(Challenges.class, challengeId);
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return challenge;
    }

    public void addChallengeNotification(Challenges challenges,Users users, List<UsersBaseDataResponseModel> usersBaseDataResponseModels) {
        ChallengedDao challengedDao=new ChallengedDaoImpl();
        for (UsersBaseDataResponseModel usersBaseDataResponseModel:usersBaseDataResponseModels){
            challengedDao.insert(
                    new ChallengedModel(
                            users.getId(),
                            users.getFullName(),
                            users.getProfilePicture(),
                            usersBaseDataResponseModel.getId(),0,
                            challenges.getHeadLine(),
                            users.getId(),0
                    )
            );
        }
    }
}
