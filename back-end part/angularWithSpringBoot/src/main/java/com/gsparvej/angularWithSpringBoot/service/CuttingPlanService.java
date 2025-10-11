package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.ICuttingPlanRepo;
import com.gsparvej.angularWithSpringBoot.repository.IProductionOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IUOMRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CuttingPlanService {

    @Autowired
    private ICuttingPlanRepo cuttingPlanRepo;

    @Autowired
    private IUOMRepo uomRepo;

    @Autowired
    private IProductionOrderRepo productionOrderRepo;

    public List<CuttingPlan> getAllCuttingPlans() {
        return cuttingPlanRepo.findAll();
    }
    public Optional<CuttingPlan> getCuttingPlanById (Integer id) {
        return cuttingPlanRepo.findById(id);
    }
    public CuttingPlan saveOrUpdate(CuttingPlan cuttingPlan) {
        ProductionOrder productionOrder = productionOrderRepo.findById(cuttingPlan.getProductionOrder().getId())
                .orElseThrow(() -> new RuntimeException("Production Order not found with id: " + cuttingPlan.getProductionOrder().getId()));

        UOM uom = uomRepo.findById(cuttingPlan.getUom().getId())
                .orElseThrow(() -> new RuntimeException("UOM not found with id: " + cuttingPlan.getUom().getId()));

        cuttingPlan.setProductionOrder(productionOrder);
        cuttingPlan.setUom(uom);

        return cuttingPlanRepo.save(cuttingPlan);
    }

    public void deleteById(Integer id) {
        cuttingPlanRepo.deleteById(id);
    }


    public List<CuttingPlanResponseDTO> getAllCuttingPlanResponseDTOS() {
        return cuttingPlanRepo.findAll().stream().map(cutting -> {
            CuttingPlanResponseDTO dto = new CuttingPlanResponseDTO();
            dto.setId(cutting.getId());
            dto.setCuttingDate(cutting.getCuttingDate());
            dto.setPlannedPcs(cutting.getPlannedPcs());
            dto.setFabricUsed(cutting.getFabricUsed());
            dto.setFabricWidth(cutting.getFabricWidth());
            dto.setLayCount(cutting.getLayCount());
            dto.setMarkerNo(cutting.getMarkerNo());
            dto.setStatus(cutting.getStatus());

            dto.setActualPcs(cutting.getActualPcs());
            dto.setCreatedBy(cutting.getCreatedBy());
            dto.setFabricLength(cutting.getFabricLength());
            dto.setMarkerEfficiency(cutting.getMarkerEfficiency());
            dto.setRemarks(cutting.getRemarks());
            dto.setMarkerCount(cutting.getMarkerCount());
            dto.setDescription(cutting.getDescription());
            dto.setMarkerOutput(cutting.getMarkerOutput());




            ProductionOrder order = cutting.getProductionOrder();
            if (order != null) {
                ProductionOrderResponseDTO productionOrderResponseDTO = new ProductionOrderResponseDTO();
                productionOrderResponseDTO.setId(order.getId());

                dto.setProductionOrder(productionOrderResponseDTO);


            }

            UOM uom = cutting.getUom();
            if (uom != null) {
                UomResponseDTO uomResponseDTO = new UomResponseDTO();
                uomResponseDTO.setId(uom.getId());
                uomResponseDTO.setBaseFabric(uom.getBaseFabric());
                uomResponseDTO.setSize(uom.getSize());

                dto.setUom(uomResponseDTO);
            }


            return dto;
        }).toList();
    }

    // ✅ Get Cutting Plan  By Production Order Id  Code and return as DTOs

    public List<CuttingPlanResponseDTO> getCuttingPlanByProductionOrderId(int id) {
        List<CuttingPlan> cuttingPlans = cuttingPlanRepo.findAllCuttingPlanByProductionOrderId(id);

        return cuttingPlans.stream().map(cut -> {
            // Map Production Order
            ProductionOrder or = cut.getProductionOrder();
            ProductionOrderResponseDTO orderDTO = null;
            if (or != null) {
                orderDTO = new ProductionOrderResponseDTO();
                orderDTO.setId(or.getId());

            }

            // Map UOM

            UOM uom = cut.getUom();
            UomResponseDTO uomDTO = null;
            if (uom != null) {
                uomDTO = new UomResponseDTO();
                uomDTO.setId(uom.getId());
                uomDTO.setBaseFabric(uom.getBaseFabric());
                uomDTO.setSize(uom.getSize());

            }

            // Map Cutting Plan
            CuttingPlanResponseDTO cuttingPlanResponseDTO = new CuttingPlanResponseDTO();
            cuttingPlanResponseDTO.setId(cut.getId());
            cuttingPlanResponseDTO.setProductionOrder(orderDTO);
            cuttingPlanResponseDTO.setUom(uomDTO);
            cuttingPlanResponseDTO.setMarkerNo(cut.getMarkerNo());
            cuttingPlanResponseDTO.setFabricWidth(cut.getFabricWidth());
            cuttingPlanResponseDTO.setLayCount(cut.getLayCount());
            cuttingPlanResponseDTO.setPlannedPcs(cut.getPlannedPcs());
            cuttingPlanResponseDTO.setFabricUsed(cut.getFabricUsed());
            cuttingPlanResponseDTO.setStatus(cut.getStatus());
            cuttingPlanResponseDTO.setCuttingDate(cut.getCuttingDate());

            cuttingPlanResponseDTO.setActualPcs(cut.getActualPcs());
            cuttingPlanResponseDTO.setCreatedBy(cut.getCreatedBy());
            cuttingPlanResponseDTO.setFabricLength(cut.getFabricLength());
            cuttingPlanResponseDTO.setMarkerEfficiency(cut.getMarkerEfficiency());
            cuttingPlanResponseDTO.setRemarks(cut.getRemarks());
            cuttingPlanResponseDTO.setMarkerCount(cut.getMarkerCount());
            cuttingPlanResponseDTO.setDescription(cut.getDescription());
            cuttingPlanResponseDTO.setMarkerOutput(cut.getMarkerOutput());



            return cuttingPlanResponseDTO;
        }).collect(Collectors.toList());
    }
}
