package com.appchallengers.appchallengers.dao.daoimpl;

import com.appchallengers.appchallengers.dao.dao.RelationshipDao;
import com.appchallengers.appchallengers.model.entity.Relationship;
import com.appchallengers.appchallengers.model.entity.Users;
import com.appchallengers.appchallengers.model.response.UsersBaseDataResponseModel;
import com.appchallengers.appchallengers.util.JpaFactory;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.util.List;


public class RelationshipDaoImpl implements RelationshipDao {


    public void addRelationship(long firstUserId, long secondUserId, long actionId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Relationship relationship = getRelationship(firstUserId, secondUserId);
        Relationship relationship1 = entityManager.find(Relationship.class, relationship.getId());
        if (relationship1 == null) {
            entityManager.getTransaction().begin();
            entityManager.persist(new Relationship(
                    entityManager.find(Users.class, firstUserId),
                    entityManager.find(Users.class, secondUserId),
                    actionId, Relationship.Type.SEND_REQUEST
            ));
            entityManager.flush();
            entityManager.getTransaction().commit();
        }
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
    }

    public boolean acceptRelationship(long firstUser, long secondUser, long actionId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Relationship relationship = getRelationship(firstUser, secondUser);
        entityManager.getTransaction().begin();
        if (relationship.getStatus() == Relationship.Type.FRIEND) {
            return false;
        } else {
            relationship.setStatus(Relationship.Type.FRIEND);
            relationship.setUserActionId(actionId);
            entityManager.merge(relationship);
            entityManager.getTransaction().commit();
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
            return true;
        }

    }

    public void deleteRelationship(long firstUser, long secondUser) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        Relationship relationship = getRelationship(firstUser, secondUser);
        Relationship relationship1 = entityManager.find(Relationship.class, relationship.getId());
        if (relationship1 != null) {
            entityManager.getTransaction().begin();
            entityManager.remove(relationship1);
            entityManager.flush();
            entityManager.getTransaction().commit();
        }
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
    }

    public Long checkRelationship(long firstUser, long secondUser) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Long> longTypedQuery = entityManager.createNamedQuery("Relationship.checkRelationship", Long.class);
        longTypedQuery.setParameter("firstuser", firstUser);
        longTypedQuery.setParameter("seconduser", secondUser);
        long status = longTypedQuery.getSingleResult();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return status;
    }

    public Relationship getRelationship(long firstUser, long secondUser) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<Relationship> relationshipTypedQuery = entityManager.createNamedQuery("Relationship.getRelationship", Relationship.class);
        relationshipTypedQuery.setParameter("firstuser", firstUser);
        relationshipTypedQuery.setParameter("seconduser", secondUser);
        try {
            return relationshipTypedQuery.getSingleResult();
        } catch (NoResultException e) {
            return new Relationship();
        } finally {
            entityManager.close();
            JpaFactory.getInstance().CloseFactory();
        }
    }

    public List<UsersBaseDataResponseModel> getFriends(long userId) {
        EntityManager entityManager = JpaFactory.getInstance().getEntityManager();
        TypedQuery<UsersBaseDataResponseModel> query = entityManager.createNamedQuery("Relationship.getRelationships", UsersBaseDataResponseModel.class);
        query.setParameter(1, userId);
        query.setParameter(2, userId);
        List<UsersBaseDataResponseModel> resultList = query.getResultList();
        entityManager.close();
        JpaFactory.getInstance().CloseFactory();
        return resultList;
    }


}
