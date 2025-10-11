package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.CuttingPlan;
import com.gsparvej.angularWithSpringBoot.entity.ProductionOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ICuttingPlanRepo extends JpaRepository<CuttingPlan, Integer> {

    @Query("SELECT b FROM CuttingPlan b WHERE b.productionOrder.id = :id")
    List<CuttingPlan> findAllCuttingPlanByProductionOrderId(@Param("id") int id);
}
