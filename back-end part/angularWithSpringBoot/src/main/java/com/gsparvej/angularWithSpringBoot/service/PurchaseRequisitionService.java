package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IDepartmentRepo;
import com.gsparvej.angularWithSpringBoot.repository.IItemRepo;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IPurchaseRequisitionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PurchaseRequisitionService {

    @Autowired
    private IPurchaseRequisitionRepo requisitionRepo;
    @Autowired
    private IOrderRepo orderRepo;
    @Autowired
    private IDepartmentRepo departmentRepo;
    @Autowired
    private IItemRepo itemRepo;

    public List<PurchaseRequisition> getAllPurchaseRequisitions() {
        return requisitionRepo.findAll();
    }

    public PurchaseRequisition saveOrUpdate(PurchaseRequisition requisition) {
        Order order = orderRepo.findById(requisition.getOrder().getId())
                .orElseThrow(() -> new RuntimeException("Order not found with id: " + requisition.getOrder().getId()));

        Department department = departmentRepo.findById(requisition.getDepartment().getId())
                .orElseThrow(() -> new RuntimeException("Department not found with id: " + requisition.getDepartment().getId()));

        Item item = itemRepo.findById(requisition.getItem().getId())
                        .orElseThrow(()-> new RuntimeException("Item not found with id: " + requisition.getItem().getId()));
        requisition.setOrder(order);
        requisition.setDepartment(department);
        requisition.setItem(item);


        return requisitionRepo.save(requisition);
    }


    public void deleteById(Integer id) {
        requisitionRepo.deleteById(id);
    }
    public PurchaseRequisition getById(Integer id) {
        return requisitionRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Purchase Requisition not found"));
    }


    public List<PurchaseRequisitionDTO> getAllRequisitionsDTOs() {
        return requisitionRepo.findAll().stream().map(req -> {
            PurchaseRequisitionDTO dto = new PurchaseRequisitionDTO();
            dto.setId(req.getId());
            dto.setPrDate(req.getPrDate());
            dto.setRequestedBy(req.getRequestedBy());
            dto.setPrStatus(req.getPrStatus());
            return dto;
        }).toList();
    }


    public List<FullRequisitionResponseDTO> getFullRequisitionResponseDTOS(int id) {
        return requisitionRepo.findById(id).stream().map(requ -> {
            FullRequisitionResponseDTO dto = new FullRequisitionResponseDTO();
            dto.setId(requ.getId());
            dto.setPrDate(requ.getPrDate());
            dto.setRequestedBy(requ.getRequestedBy());
            dto.setPrStatus(requ.getPrStatus());
            dto.setQuantity(requ.getQuantity());
            dto.setApproxUnitPrice(requ.getApproxUnitPrice());
            dto.setTotalEstPrice(requ.getTotalEstPrice());

            Order order = requ.getOrder();
            if (order != null) {
                OrderResponseDTO orderResponseDTO = new OrderResponseDTO();
                orderResponseDTO.setId(order.getId());

                dto.setOrder(orderResponseDTO);


            }

            Item item = requ.getItem();
            if (item != null) {
                ItemResponseDTO itemResponseDTO = new ItemResponseDTO();
                itemResponseDTO.setCategoryName(item.getCategoryName());

                dto.setItem(itemResponseDTO);

            }
            Department department = requ.getDepartment();
            if (department != null) {
                DepartmentResponseDTO departmentResponseDTO = new DepartmentResponseDTO();
                departmentResponseDTO.setName(department.getName());
                dto.setDepartment(departmentResponseDTO);
            }

            return dto;
        }).toList();
    }
}
