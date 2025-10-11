package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.DepartmentResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.DesignationResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.BomStyle;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.repository.IBomStyleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BomStyleService {

    @Autowired
    private IBomStyleRepo bomStyleRepo;

    public List<BomStyle> getAllBomStyle() {
        return bomStyleRepo.findAll();
    }
    public BomStyle saveBomStyle(BomStyle bomStyle) {
        return bomStyleRepo.save(bomStyle);
    }
    public void deleteById(Integer id) {
        bomStyleRepo.deleteById(id);
    }

    public List<BomStyleResponseDTO> getAllBomStyleResponseDTOS() {
        return bomStyleRepo.findAll().stream().map(style -> {
            BomStyleResponseDTO dto = new BomStyleResponseDTO();
            dto.setId(style.getId());
            dto.setStyleCode(style.getStyleCode());
            dto.setStyleType(style.getStyleType());
            dto.setDescription(style.getDescription());

            return dto;
        }).toList();
    }
}
