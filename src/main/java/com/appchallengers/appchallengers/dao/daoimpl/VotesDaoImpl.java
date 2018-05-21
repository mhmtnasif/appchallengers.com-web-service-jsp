package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.VotesDao;
import com.appchallengers.appchallengers.model.entity.Votes;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;

public class VotesDaoImpl implements VotesDao {

    public void addVote(Votes votes) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Votes votes1 = entityManager.find(Votes.class, votes.getId());
        if (votes1 == null) {
            entityManager.getTransaction().begin();
            entityManager.persist(votes);
            entityManager.flush();
            entityManager.getTransaction().commit();
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
        }

    }

    public void deleteVote(Votes votes) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Votes votes1 = entityManager.find(Votes.class, votes.getId());
        if (votes1 != null) {
            entityManager.getTransaction().begin();
            entityManager.remove(votes1);
            entityManager.flush();
            entityManager.getTransaction().commit();
        }
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();

    }

    public Votes getVote(long challenge_detail_id, long vote_user_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Query query = entityManager.createNamedQuery("Vote.getVote");
        query.setParameter(1, challenge_detail_id);
        query.setParameter(2, vote_user_id);
        try {
            return (Votes) query.getSingleResult();
        } catch (NoResultException e) {
            return new Votes();
        }finally {
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
        }

    }

    public List<UsersBaseDataResponseModel> getVotes(long challenge_detail_id) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<UsersBaseDataResponseModel> query = entityManager.createNamedQuery("Vote.getVoteList",UsersBaseDataResponseModel.class);
        query.setParameter(1, challenge_detail_id);
        List<UsersBaseDataResponseModel> usersBaseDatumResponseModels = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return usersBaseDatumResponseModels;
    }
}
