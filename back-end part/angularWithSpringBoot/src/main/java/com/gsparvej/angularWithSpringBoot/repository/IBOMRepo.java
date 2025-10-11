package com.gsparvej.angularWithSpringBoot.repository;


import com.gsparvej.angularWithSpringBoot.entity.BOM;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IBOMRepo extends JpaRepository<BOM, Integer> {

     // Find all BOMs by style code
     @Query("SELECT b FROM BOM b WHERE b.bomStyle.styleCode = :styleCode")
     List<BOM> findAllByStyleCode(@Param("styleCode") String styleCode);


}
