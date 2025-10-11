package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.DayWiseProductionResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.ProductionSummaryResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.ReportDTO;
import com.gsparvej.angularWithSpringBoot.entity.DayWiseProduction;
import com.gsparvej.angularWithSpringBoot.entity.Order;
import com.gsparvej.angularWithSpringBoot.service.ProductionSummaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/proSummaryorder")
public class ProductionSummaryRestController {

    @Autowired
    private ProductionSummaryService productionSummaryService;

    @GetMapping("/production-summary")
    public ReportDTO getProductionSummary(
            @RequestParam Integer orderId
    ) {
        Order order = new Order();
        order.setId(orderId);
        return productionSummaryService.findByOrder(order);
    }

    //    its works perfectly
    @GetMapping("/production-summaryAll")
    public ReportDTO getProductionSummaryAll(@RequestParam Integer orderId) {
        return productionSummaryService.findByOrderId(orderId);
    }


}
