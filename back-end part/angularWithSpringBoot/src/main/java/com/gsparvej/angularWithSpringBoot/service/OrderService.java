package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IBomStyleRepo;
import com.gsparvej.angularWithSpringBoot.repository.IBuyerRepo;
import com.gsparvej.angularWithSpringBoot.repository.IEmployeeRepo;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderService {

    @Autowired
    private IBomStyleRepo bomStyleRepo;

    @Autowired
    private IBuyerRepo buyerRepo;

    @Autowired
    private IEmployeeRepo employeeRepo;

    @Autowired
    private IOrderRepo orderRepo;


    public List<Order> getAllOrders() {
        return orderRepo.findAll();
    }


    public Optional<Order> getOrderById(Integer id) {
        return orderRepo.findById(id);
    }
    public Order saveOrUpdate(Order order, BomStyle bomStyle, Buyer buyer) {
        // Relations
        order.setBomStyle(bomStyle);
        order.setBuyer(buyer);

        // SubTotal Calculation (all sizes * unit price)
        double subTotal =
                (order.getShortSmallSize() * order.getShortSPrice()) +
                        (order.getShortMediumSize() * order.getShortMPrice()) +
                        (order.getShortLargeSize() * order.getShortLPrice()) +
                        (order.getShortXLSize() * order.getShortXLPrice()) +
                        (order.getFullSmallSize() * order.getFullSPrice()) +
                        (order.getFullMediumSize() * order.getFullMPrice()) +
                        (order.getFullLargeSize() * order.getFullLPrice()) +
                        (order.getFullXLSize() * order.getFullXLPrice());

        order.setSubTotal(subTotal);


        double vatAmount = order.getVat() != 0 ? order.getVat() : 0;
        double total = subTotal + vatAmount;
        order.setTotal(total);

        // Due Amount
        double paidAmount = order.getPaidAmount() != 0 ? order.getPaidAmount() : 0;
        double dueAmount = total - paidAmount;
        order.setDueAmount(dueAmount);

        return orderRepo.save(order);
    }


    public void deleteById(Integer id) {
        orderRepo.deleteById(id);
    }
    public Order getProfileById(Integer id) {
        return orderRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }


    public List<OrderResponseDTO> getAllOrderResponseDTOS() {
        return orderRepo.findAll().stream().map(order -> {
            OrderResponseDTO dto = new OrderResponseDTO();
            dto.setId(order.getId());

            dto.setDeliveryDate(order.getDeliveryDate());

            Buyer buyer = order.getBuyer();
            if (buyer != null) {
                BuyerResponseDTO buyerResponseDTO = new BuyerResponseDTO();
                buyerResponseDTO.setId(buyer.getId());
                buyerResponseDTO.setName(buyer.getName());

                dto.setBuyer(buyerResponseDTO);


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


    public List<FullOrderViewResponseDTO> getViewOrderViewResponseDTOS(int id) {
        return orderRepo.findById(id).stream().map(order -> {
            FullOrderViewResponseDTO dto = new FullOrderViewResponseDTO();
            dto.setId(order.getId());

            dto.setOrderDate(order.getOrderDate());
            dto.setDeliveryDate(order.getDeliveryDate());

            // Short Sleeve Sizes & Prices
            dto.setShortSmallSize(order.getShortSmallSize());
            dto.setShortSPrice(order.getShortSPrice());
            dto.setShortMediumSize(order.getShortMediumSize());
            dto.setShortMPrice(order.getShortMPrice());
            dto.setShortLargeSize(order.getShortLargeSize());
            dto.setShortLPrice(order.getShortLPrice());
            dto.setShortXLSize(order.getShortXLSize());
            dto.setShortXLPrice(order.getShortXLPrice());

            // Full Sleeve Sizes & Prices
            dto.setFullSmallSize(order.getFullSmallSize());
            dto.setFullSPrice(order.getFullSPrice());
            dto.setFullMediumSize(order.getFullMediumSize());
            dto.setFullMPrice(order.getFullMPrice());
            dto.setFullLargeSize(order.getFullLargeSize());
            dto.setFullLPrice(order.getFullLPrice());
            dto.setFullXLSize(order.getFullXLSize());
            dto.setFullXLPrice(order.getFullXLPrice());

            // Financial
            dto.setSubTotal(order.getSubTotal());
            dto.setVat(order.getVat());
            dto.setPaidAmount(order.getPaidAmount());
            dto.setDueAmount(order.getDueAmount());
            dto.setTotal(order.getTotal());
            dto.setRemarks(order.getRemarks());
            dto.setOrderStatus(order.getOrderStatus());


            Buyer buyer = order.getBuyer();
            if (buyer != null) {
                BuyerResponseDTO buyerResponseDTO = new BuyerResponseDTO();
                buyerResponseDTO.setName(buyer.getName());
                buyerResponseDTO.setAddress(buyer.getAddress());

                dto.setBuyer(buyerResponseDTO);


            }

            BomStyle bomStyle = order.getBomStyle();
            if (bomStyle != null) {
                BomStyleResponseDTO bomStyleResponseDTO = new BomStyleResponseDTO();
                bomStyleResponseDTO.setStyleCode(bomStyle.getStyleCode());
                dto.setBomStyle(bomStyleResponseDTO);
            }

            return dto;
        }).toList();
    }




    public List<FullOrderViewResponseDTO> getOrdersByStyleCode(String styleCode) {
        List<Order> orders = orderRepo.findByBomStyle_StyleCode(styleCode);

        return orders.stream().map(this::mapToDTO).toList();
    }

    private FullOrderViewResponseDTO mapToDTO(Order order) {
        BomStyleResponseDTO bomStyleDTO = new BomStyleResponseDTO(
                order.getBomStyle().getId(),
                order.getBomStyle().getStyleCode()

        );

        BuyerResponseDTO buyerDTO = new BuyerResponseDTO(
                order.getBuyer().getId(),
                order.getBuyer().getName(),
                order.getBuyer().getContactPerson(),
                order.getBuyer().getEmail()
        );

        return new FullOrderViewResponseDTO(
                order.getId(),
                order.getOrderDate(),
                order.getDeliveryDate(),
                order.getShortSmallSize(),
                order.getShortSPrice(),
                order.getShortMediumSize(),
                order.getShortMPrice(),
                order.getShortLargeSize(),
                order.getShortLPrice(),
                order.getShortXLSize(),
                order.getShortXLPrice(),
                order.getFullSmallSize(),
                order.getFullSPrice(),
                order.getFullMediumSize(),
                order.getFullMPrice(),
                order.getFullLargeSize(),
                order.getFullLPrice(),
                order.getFullXLSize(),
                order.getFullXLPrice(),
                order.getSubTotal(),
                order.getVat(),
                order.getPaidAmount(),
                order.getDueAmount(),
                order.getTotal(),
                order.getRemarks(),
                order.getOrderStatus(),
                bomStyleDTO,
                buyerDTO
        );
    }
}




