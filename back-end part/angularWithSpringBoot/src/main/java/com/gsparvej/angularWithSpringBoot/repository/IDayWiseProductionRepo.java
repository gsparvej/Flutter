package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.dto.DayWiseProductionResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.ProductionSummaryResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.DayWiseProduction;
import com.gsparvej.angularWithSpringBoot.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IDayWiseProductionRepo extends JpaRepository<DayWiseProduction, Integer> {
    List<DayWiseProduction> findDayWiseProductionByOrder(Order order);
}
