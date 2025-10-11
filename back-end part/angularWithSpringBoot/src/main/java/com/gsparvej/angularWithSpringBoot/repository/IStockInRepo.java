package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.StockInModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IStockInRepo extends JpaRepository<StockInModel,Integer> {

    List<StockInModel> findByItemId(int itemId);
}
