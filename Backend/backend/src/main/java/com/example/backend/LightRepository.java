package com.example.backend;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import antlr.collections.impl.LList;

import javax.persistence.EntityManagerFactory;
import javax.transaction.Transactional;

import com.example.backend.*;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface LightRepository extends JpaRepository<Light, Long> {
       
  
   
}