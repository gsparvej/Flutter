package com.gsparvej.angularWithSpringBoot.service;


import com.gsparvej.angularWithSpringBoot.dto.BomResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.UomResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IBOMRepo;
import com.gsparvej.angularWithSpringBoot.repository.IBomStyleRepo;
import com.gsparvej.angularWithSpringBoot.repository.IUOMRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class BOMService {

    @Autowired
    private IBOMRepo bomRepo;
    @Autowired
    private IBomStyleRepo bomStyleRepo;
    @Autowired
    private IUOMRepo uomRepo;

    public List<BOM> getAllBoms() {
        return bomRepo.findAll();
    }
    public Optional<BOM> getBomById(Integer id) {
        return bomRepo.findById(id);
    }

    public BOM saveOrUpdate(BOM bom) {
        BomStyle bomStyle = bomStyleRepo.findById(bom.getBomStyle().getId())
                .orElseThrow(() -> new RuntimeException("BomStyle not found with id: " + bom.getBomStyle().getId()));

        UOM uom = uomRepo.findById(bom.getUom().getId())
                .orElseThrow(() -> new RuntimeException("UOM not found with id: " + bom.getUom().getId()));

        bom.setBomStyle(bomStyle);
        bom.setUom(uom);

        return bomRepo.save(bom);
    }


    public void deleteById(Integer id) {
        bomRepo.deleteById(id);
    }
    public BOM getById(Integer id) {
        return bomRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("BOM not found"));
    }


//    // ✅ New Service Method: Get BOMs by Style Code
//    public List<BOM> getBOMsByStyleCode(String styleCode) {
//        return bomRepo.findAllByStyleCode(styleCode);
//    }


    // ✅ Get BOMs by Style Code and return as DTOs
    public List<BomResponseDTO> getBOMsByStyleCode(String styleCode) {
        List<BOM> boms = bomRepo.findAllByStyleCode(styleCode);

        return boms.stream().map(bom -> {
            // Map UOM
            UOM uom = bom.getUom();
            UomResponseDTO uomDto = null;
            if (uom != null) {
                uomDto = new UomResponseDTO();
                uomDto.setId(uom.getId());
                uomDto.setProductName(uom.getProductName());
                uomDto.setSize(uom.getSize());
                uomDto.setBody(uom.getBody());
                uomDto.setSleeve(uom.getSleeve());
                uomDto.setPocket(uom.getPocket());
                uomDto.setWastage(uom.getWastage());
                uomDto.setShrinkage(uom.getShrinkage());
                uomDto.setBaseFabric(uom.getBaseFabric());
            }

            // Map BomStyle
            BomStyle style = bom.getBomStyle();
            BomStyleResponseDTO styleDto = null;
            if (style != null) {
                styleDto = new BomStyleResponseDTO();
                styleDto.setId(style.getId());
                styleDto.setStyleCode(style.getStyleCode());
                styleDto.setStyleType(style.getStyleType());
                styleDto.setDescription(style.getDescription());
            }

            // Map BOM
            BomResponseDTO bomDto = new BomResponseDTO();
            bomDto.setId(bom.getId());
            bomDto.setSerial(bom.getSerial());
            bomDto.setMaterial(bom.getMaterial());
            bomDto.setUnit(bom.getUnit());
            bomDto.setQuantity(bom.getQuantity());
            bomDto.setUnitPrice(bom.getUnitPrice());
            bomDto.setTotalCost(bom.getTotalCost());
            bomDto.setUom(uomDto);
            bomDto.setBomStyle(styleDto);

            return bomDto;
        }).collect(Collectors.toList());
    }




}

