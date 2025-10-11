package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.UomResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.VendorResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.entity.UOM;
import com.gsparvej.angularWithSpringBoot.repository.IBuyerRepo;
import com.gsparvej.angularWithSpringBoot.repository.IUOMRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UOMService {

    @Autowired
    private IUOMRepo uomRepo;

    public List<UOM> getAllUOM() {
        return uomRepo.findAll();
    }

    public List<UomResponseDTO> getAllUomResponseDTOS() {
        return uomRepo.findAll().stream().map(uom -> {
            UomResponseDTO dto = new UomResponseDTO();
            dto.setId(uom.getId());
            dto.setProductName(uom.getProductName());
            dto.setBody(uom.getBody());
            dto.setPocket(uom.getPocket());
            dto.setSize(uom.getSize());
            dto.setShrinkage(uom.getShrinkage());
            dto.setSleeve(uom.getSleeve());
            dto.setBaseFabric(uom.getBaseFabric());
            dto.setWastage(uom.getWastage());



            return dto;
        }).toList();
    }
    public UOM saveUom(UOM uom) {

        float p = (uom.getBody()+uom.getPocket()+uom.getSleeve()) + ((uom.getBody()+uom.getPocket()+uom.getSleeve())*((uom.getWastage()+ uom.getShrinkage())/100));
        uom.setBaseFabric(p);
        return uomRepo.save(uom);
    }
    public void deleteById(Integer id) {
        uomRepo.deleteById(id);
    }

//    public double calculateBaseFabric(float body, float sleeve, float pocket, float wastage, float shrinkage , float baseFabric) {
//     baseFabric = (body+pocket+sleeve) + ((body+pocket+sleeve)*((wastage+ shrinkage)/100));
//     return baseFabric;
//    }


    public void calculateBaseFabric(UOM  uom) {
    float p = (uom.getBody()+uom.getPocket()+uom.getSleeve()) + (uom.getBody()+uom.getPocket()+uom.getSleeve()*((uom.getWastage()+ uom.getShrinkage())/100));
    uom.setBaseFabric(p);

    }
}
