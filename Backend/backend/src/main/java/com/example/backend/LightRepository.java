package com.example.backend;

import org.springframework.data.repository.CrudRepository;

import com.example.backend.*;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface LightRepository extends CrudRepository<Light, Integer> {

}