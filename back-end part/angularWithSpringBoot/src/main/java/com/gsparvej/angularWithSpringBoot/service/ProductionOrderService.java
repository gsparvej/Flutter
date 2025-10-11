package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IBomStyleRepo;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IProductionOrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductionOrderService {

    @Autowired
    private IProductionOrderRepo productionOrderRepo;
    @Autowired
    private IBomStyleRepo bomStyleRepo;
    @Autowired
    private IOrderRepo orderRepo;


    public List<ProductionOrder> getAllProductionOrders() {
        return productionOrderRepo.findAll();
    }

    public ProductionOrder saveOrUpdate(ProductionOrder productionOrder) {
        BomStyle bomStyle = bomStyleRepo.findById(productionOrder.getBomStyle().getId())
                .orElseThrow(() -> new RuntimeException("BomStyle not found with id: " + productionOrder.getBomStyle().getId()));


        Order order = orderRepo.findById(productionOrder.getOrder().getId())
                .orElseThrow(()-> new RuntimeException("Order not found with id: " + productionOrder.getOrder().getId()));
        productionOrder.setBomStyle(bomStyle);
        productionOrder.setOrder(order);


        return productionOrderRepo.save(productionOrder);
    }


    public void deleteById(Integer id) {
        productionOrderRepo.deleteById(id);
    }
    public ProductionOrder getById(Integer id) {
        return productionOrderRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Production Order not found"));
    }


    public List<ProductionOrderResponseDTO> getAProductionOrderResponseDTOS() {
        return productionOrderRepo.findAll().stream().map(order -> {
            ProductionOrderResponseDTO dto = new ProductionOrderResponseDTO();
            dto.setId(order.getId());
            dto.setDescription(order.getDescription());
            dto.setEndDate(order.getEndDate());
            dto.setStartDate(order.getStartDate());
            dto.setPriority(order.getPriority());
            dto.setPlanQty(order.getPlanQty());
            dto.setSize(order.getSize());
            dto.setStatus(order.getStatus());

            Order or = order.getOrder();
            if (or != null) {
                OrderResponseDTO orderResponseDTO = new OrderResponseDTO();
                orderResponseDTO.setId(or.getId());
                dto.setOrder(orderResponseDTO);


            }

            BomStyle bomStyle = order.getBomStyle();
            if (bomStyle != null) {
                BomStyleResponseDTO bomStyleResponseDTO = new BomStyleResponseDTO();
                bomStyleResponseDTO.setId(bomStyle.getId());
                bomStyleResponseDTO.setStyleCode(bomStyle.getStyleCode());
                dto.setBomStyle(bomStyleResponseDTO);
            }


            return dto;
        }).toList();
    }



    // ✅ Get Production Order By Order Id  Code and return as DTOs

    public List<ProductionOrderResponseDTO> getProductionByOrderId(int id) {
        List<ProductionOrder> productionOrders = productionOrderRepo.findAllProductionOrderByOrderId(id);

        return productionOrders.stream().map(orders -> {
            // Map Order
            Order or = orders.getOrder();
            OrderResponseDTO orderDTO = null;
            if (or != null) {
                orderDTO = new OrderResponseDTO();
                orderDTO.setId(or.getId());

            }

            // Map BomStyle

            BomStyle bStyle = orders.getBomStyle();
            BomStyleResponseDTO styleDto = null;
            if (bStyle != null) {
                styleDto = new BomStyleResponseDTO();
                styleDto.setId(bStyle.getId());
                styleDto.setStyleCode(bStyle.getStyleCode());
                styleDto.setStyleType(bStyle.getStyleType());
                styleDto.setDescription(bStyle.getDescription());
            }

            // Map Production Order
            ProductionOrderResponseDTO pDto = new ProductionOrderResponseDTO();
            pDto.setId(orders.getId());
            pDto.setOrder(orderDTO);
            pDto.setBomStyle(styleDto);
            pDto.setPlanQty(orders.getPlanQty());
            pDto.setSize(orders.getSize());
            pDto.setStatus(orders.getStatus());
            pDto.setStartDate(orders.getStartDate());
            pDto.setEndDate(orders.getEndDate());
            pDto.setPriority(orders.getPriority());


            return pDto;
        }).collect(Collectors.toList());
    }
}
