package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.ChallengesDetailDao;
import com.appchallengers.appchallengers.model.entity.ChallengeDetail;
import com.appchallengers.appchallengers.model.entity.Challenges;
import com.appchallengers.appchallengers.model.entity.Relationship;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.ChallengeResponseModel;
import com.appchallengers.appchallengers.model.response.GetChallengeDetailInfoModel;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.mongodb.dao.ChallengedDao;
import com.appchallengers.appchallengers.mongodb.daoimpl.ChallengedDaoImpl;
import com.appchallengers.appchallengers.mongodb.model.ChallengedModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;
public class ChallengesDetailDaoImpl implements ChallengesDetailDao {

    public GetChallengeDetailInfoModel getChallengeDetailInfo(long userId,long challengeId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        GetChallengeDetailInfoModel result=new GetChallengeDetailInfoModel();
        Query namedQuery = entityManager.createNamedQuery("ChallengeDetail.getChallengeDetailInfo");
        namedQuery.setParameter(1, challengeId);
        namedQuery.setParameter(2, challengeId);
        namedQuery.setParameter(3, userId);
        try{
            result=(GetChallengeDetailInfoModel) namedQuery.getSingleResult();
        }catch (Exception e){
            return result;
        }finally {
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
        }

        return result;
    }

    public List<ChallengeResponseModel> getChallengeDetailOrderByTime(long userId, long challengeId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> query = entityManager.createNamedQuery("ChallengeDetail.getChallengeDetailOrderByTime",ChallengeResponseModel.class);
        query.setParameter(1, userId);
        query.setParameter(2, userId);
        query.setParameter(3, challengeId);
        List<ChallengeResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }
    public List<ChallengeResponseModel> getChallengeDetailOrderByLikes(long userId, long challengeId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> query = entityManager.createNamedQuery("ChallengeDetail.getChallengeDetailOrderByLikes",ChallengeResponseModel.class);
        query.setParameter(1, userId);
        query.setParameter(2, userId);
        query.setParameter(3, challengeId);
        List<ChallengeResponseModel> getUserChallengesList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return getUserChallengesList;
    }
    public ChallengeDetail addChallengesDetail(ChallengeDetail challengeDetail) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(challengeDetail);
        entityManager.flush();
        entityManager.getTransaction().commit();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return challengeDetail;
    }

    public ChallengeDetail getChallengeDetail(long challenge_detail_id) {
        EntityManager entityManager=JpaFactory.getInstance().getEntityManager();
        ChallengeDetail challengeDetail=entityManager.find(ChallengeDetail.class,challenge_detail_id);
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return challengeDetail;
    }

    public List<ChallengeResponseModel> getUserChallengeFeedList(long userId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<ChallengeResponseModel> namedQuery = entityManager.createNamedQuery("ChallengeDetail.getUserChallengeDetail",ChallengeResponseModel.class);
        namedQuery.setParameter(1, userId);
        namedQuery.setParameter(2, userId);
        namedQuery.setParameter(3, userId);
        namedQuery.setParameter(4, userId);
        namedQuery.setParameter(5, Relationship.Type.FRIEND.ordinal());
        List<ChallengeResponseModel> resultList=namedQuery.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return resultList;

    }
    public void addChallengeDetailNotification(Challenges challenges, Users users, List<UsersBaseDataResponseModel> usersBaseDataResponseModels) {
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
