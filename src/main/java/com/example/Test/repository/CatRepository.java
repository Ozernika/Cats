package com.example.Test.repository;

import com.example.Test.models.Cat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface CatRepository extends JpaRepository<Cat, Long> {
    Optional<Cat> findByName(String url);
    @Query("SELECT c from Cat c WHERE c.name LIKE CONCAT('%', :query, '%')")
    List<Cat> searchCats(String query);
}

