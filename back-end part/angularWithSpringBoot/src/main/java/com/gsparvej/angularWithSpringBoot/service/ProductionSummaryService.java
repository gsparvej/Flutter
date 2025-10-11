package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.DayWiseProduction;
import com.gsparvej.angularWithSpringBoot.entity.Order;
import com.gsparvej.angularWithSpringBoot.entity.ProductionOrder;
import com.gsparvej.angularWithSpringBoot.repository.IDayWiseProductionRepo;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IProductionOrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductionSummaryService {

    @Autowired
    private IProductionOrderRepo productionOrderRepo;
    @Autowired
    private IOrderRepo orderRepo;

    @Autowired
    private IDayWiseProductionRepo dayWiseProductionRepo;

//    public List<ProductionSummaryResponseDTO> getProductionSummary() {
//        return productionOrderRepo.fetchProductionSummary();
//    }

    public ReportDTO findByOrder(Order order) {
        List<DayWiseProduction> dayWiseList = dayWiseProductionRepo.findDayWiseProductionByOrder(order);

        ReportDTO result = new ReportDTO();

        for (DayWiseProduction report : dayWiseList) {
            result.setShortSTotal(result.getShortSTotal() + report.getShortSQty());
            result.setShortMTotal(result.getShortMTotal() + report.getShortMQty());
            result.setShortLTotal(result.getShortLTotal() + report.getShortLQty());
            result.setShortXLTotal(result.getShortXLTotal() + report.getShortXLQty());

            result.setFullSTotal(result.getFullSTotal() + report.getFullSQty());
            result.setFullMTotal(result.getFullMTotal() + report.getFullMQty());
            result.setFullLTotal(result.getFullLTotal() + report.getFullLQty());
            result.setFullXLTotal(result.getFullXLTotal() + report.getFullXLQty());
        }

        return result;
    }

    public ReportDTO findByOrderId(Integer orderId) {
        Order order = orderRepo.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found with id: " + orderId));

        // এখন আগের মতোই কাজ করো
        List<DayWiseProduction> dayWiseList = dayWiseProductionRepo.findDayWiseProductionByOrder(order);

        ReportDTO result = new ReportDTO();

        for (DayWiseProduction report : dayWiseList) {
            result.setShortSTotal(result.getShortSTotal() + report.getShortSQty());
            result.setShortMTotal(result.getShortMTotal() + report.getShortMQty());
            result.setShortLTotal(result.getShortLTotal() + report.getShortLQty());
            result.setShortXLTotal(result.getShortXLTotal() + report.getShortXLQty());

            result.setFullSTotal(result.getFullSTotal() + report.getFullSQty());
            result.setFullMTotal(result.getFullMTotal() + report.getFullMQty());
            result.setFullLTotal(result.getFullLTotal() + report.getFullLQty());
            result.setFullXLTotal(result.getFullXLTotal() + report.getFullXLQty());
        }

        result.setRemainingShortSQty(order.getShortSmallSize() - result.getShortSTotal());
        result.setRemainingShortMQty(order.getShortMediumSize() - result.getShortMTotal());
        result.setRemainingShortLQty(order.getShortLargeSize() - result.getShortLTotal());
        result.setRemainingShortXLQty(order.getShortXLSize() - result.getShortXLTotal());

        result.setRemainingFullSQty(order.getFullSmallSize() - result.getFullSTotal());
        result.setRemainingFullMQty(order.getFullMediumSize() - result.getFullMTotal());
        result.setRemainingFullLQty(order.getFullLargeSize() - result.getFullLTotal());
        result.setRemainingFullXLQty(order.getFullXLSize() - result.getFullXLTotal());

        return result;
    }


}
