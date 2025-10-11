package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.dto.ProductionSummaryResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.BOM;
import com.gsparvej.angularWithSpringBoot.entity.ProductionOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IProductionOrderRepo extends JpaRepository<ProductionOrder, Integer> {

    // Find all Production Order by Order Id
    @Query("SELECT b FROM ProductionOrder b WHERE b.order.id = :id")
    List<ProductionOrder> findAllProductionOrderByOrderId(@Param("id") int id);



//
//
//    @Query("""
//    SELECT new com.gsparvej.angularWithSpringBoot.dto.ProductionSummaryResponseDTO(
//        po.id,
//        po.planQty,
//        COALESCE(SUM(dwp.shortSQty + dwp.shortMQty + dwp.shortLQty + dwp.shortXLQty
//                   + dwp.fullSQty + dwp.fullMQty + dwp.fullLQty + dwp.fullXLQty), 0),
//        po.planQty - COALESCE(SUM(dwp.shortSQty + dwp.shortMQty + dwp.shortLQty + dwp.shortXLQty
//                   + dwp.fullSQty + dwp.fullMQty + dwp.fullLQty + dwp.fullXLQty), 0),
//        CASE WHEN COALESCE(SUM(dwp.shortSQty + dwp.shortMQty + dwp.shortLQty + dwp.shortXLQty
//                   + dwp.fullSQty + dwp.fullMQty + dwp.fullLQty + dwp.fullXLQty), 0) >= po.planQty
//             THEN 'Completed'
//             ELSE 'In Progress'
//        END
//    )
//    FROM ProductionOrder po
//    LEFT JOIN po.dayWiseProductions dwp
//    GROUP BY po.id, po.planQty
//""")
//    List<ProductionSummaryResponseDTO> fetchProductionSummary();
}
