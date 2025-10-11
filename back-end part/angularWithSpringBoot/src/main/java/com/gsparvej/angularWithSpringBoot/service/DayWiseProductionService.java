package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IDayWiseProductionRepo;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IProductionOrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DayWiseProductionService {

    @Autowired
    private IDayWiseProductionRepo dayWiseProductionRepo;
    @Autowired
    private IOrderRepo orderRepo;
    @Autowired
    private IProductionOrderRepo productionOrderRepo;

    public List<DayWiseProduction> getAllDayWise() {
        return dayWiseProductionRepo.findAll();
    }

    public DayWiseProduction saveOrUpdate(DayWiseProduction dayWiseProduction) {
        ProductionOrder productionOrder = productionOrderRepo.findById(dayWiseProduction.getProductionOrder().getId())
                .orElseThrow(() -> new RuntimeException("Production Order not found with id: " + dayWiseProduction.getProductionOrder().getId()));

        Order order = orderRepo.findById(dayWiseProduction.getOrder().getId())
                .orElseThrow(() -> new RuntimeException("UOM not found with id: " + dayWiseProduction.getOrder().getId()));

        dayWiseProduction.setProductionOrder(productionOrder);
        dayWiseProduction.setOrder(order);

        return  dayWiseProductionRepo.save(dayWiseProduction);
    }

    public void deleteById(Integer id) {
        dayWiseProductionRepo.deleteById(id);
    }

    public List<DayWiseProductionResponseDTO> getAllDayWiseProductionResponseDTOS() {
        return dayWiseProductionRepo.findAll().stream().map(dayWise -> {
            DayWiseProductionResponseDTO dto = new DayWiseProductionResponseDTO();

            dto.setId(dayWise.getId());
            dto.setUpdatedDate(dayWise.getUpdatedDate());

            dto.setShortSQty(dayWise.getShortSQty());
            dto.setShortMQty(dayWise.getShortMQty());
            dto.setShortLQty(dayWise.getShortMQty());
            dto.setShortXLQty(dayWise.getShortXLQty());

            dto.setFullSQty(dayWise.getFullSQty());
            dto.setFullMQty(dayWise.getFullMQty());
            dto.setFullLQty(dayWise.getFullLQty());
            dto.setFullXLQty(dayWise.getFullXLQty());


            ProductionOrder order = dayWise.getProductionOrder();
            if (order != null) {
                ProductionOrderResponseDTO productionOrderResponseDTO = new ProductionOrderResponseDTO();
                productionOrderResponseDTO.setId(order.getId());

                dto.setProductionOrder(productionOrderResponseDTO);


            }

            Order or = dayWise.getOrder();
            if (or != null) {
                OrderResponseDTO orderResponseDTO = new OrderResponseDTO();
                orderResponseDTO.setId(or.getId());

                dto.setOrder(orderResponseDTO);
            }


            return dto;
        }).toList();
    }

}
