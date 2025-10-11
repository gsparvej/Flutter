package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IOrderRepo;
import com.gsparvej.angularWithSpringBoot.repository.IRawMaterialsRepo;
import com.gsparvej.angularWithSpringBoot.repository.IUOMRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RawMaterialsService {
    @Autowired
    private IRawMaterialsRepo rawMaterialsRepo;

    @Autowired
    private IUOMRepo  uomRepo;

    @Autowired
    private IOrderRepo orderRepo;

    public List<RawMaterialsModel> getAllRawMaterials() {
        return rawMaterialsRepo.findAll();
    }
    public Optional<RawMaterialsModel> getRawMaterialsById (Integer id) {
        return rawMaterialsRepo.findById(id);
    }
    public RawMaterialsModel saveOrUpdate(RawMaterialsModel rawMaterials) {

        Order order = orderRepo.findById(rawMaterials.getOrder().getId())
                .orElseThrow(() -> new RuntimeException("Order Not Found" + rawMaterials.getOrder().getId()));


//        UOM uom = uomRepo.findById(rawMaterials.getUom().getId())
//                .orElseThrow(() -> new RuntimeException("UOM not found with id: " + rawMaterials.getUom().getId()));

        rawMaterials.setOrder(order);
//        rawMaterials.setUom(uom);

        return rawMaterialsRepo.save(rawMaterials);
    }

    public void deleteById(Integer id) {
        rawMaterialsRepo.deleteById(id);
    }




    public List<RawMaterialsResponseDTO> getAllRawMaterialsResponseDTOS() {
        return rawMaterialsRepo.findAll().stream().map(raw -> {
            RawMaterialsResponseDTO dto = new RawMaterialsResponseDTO();
            dto.setId(raw.getId());
            dto.setShortSTotalQuantity(raw.getShortSTotalQuantity());
            dto.setShortMTotalQuantity(raw.getShortMTotalQuantity());
            dto.setShortLTotalQuantity(raw.getShortLTotalQuantity());
            dto.setShortXLTotalQuantity(raw.getShortXLTotalQuantity());
            dto.setFullSTotalQuantity(raw.getFullSTotalQuantity());
            dto.setFullMTotalQuantity(raw.getFullMTotalQuantity());
            dto.setFullLTotalQuantity(raw.getFullLTotalQuantity());
            dto.setFullXLTotalQuantity(raw.getFullXLTotalQuantity());
            dto.setTotalFabric(raw.getTotalFabric());




            Order order = raw.getOrder();
            if (order != null) {
                OrderResponseDTO orderResponseDTO = new OrderResponseDTO();
                orderResponseDTO.setId(order.getId());

                dto.setOrder(orderResponseDTO);


            }
            BomStyle bomStyle = raw.getOrder().getBomStyle();
            if(bomStyle != null) {
                BomStyleResponseDTO bomStyleResponseDTO = new BomStyleResponseDTO();
                bomStyleResponseDTO.setStyleCode(bomStyle.getStyleCode());

                dto.setBomStyle(bomStyleResponseDTO);

            }




            return dto;
        }).toList();
    }
}
