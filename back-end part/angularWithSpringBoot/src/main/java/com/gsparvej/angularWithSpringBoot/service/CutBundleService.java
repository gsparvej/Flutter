package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.CutBundleDTO;
import com.gsparvej.angularWithSpringBoot.dto.CuttingPlanResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.ProductionOrderResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.UomResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.CutBundle;
import com.gsparvej.angularWithSpringBoot.entity.CuttingPlan;
import com.gsparvej.angularWithSpringBoot.entity.ProductionOrder;
import com.gsparvej.angularWithSpringBoot.entity.UOM;
import com.gsparvej.angularWithSpringBoot.repository.ICutBundleRepo;
import com.gsparvej.angularWithSpringBoot.repository.ICuttingPlanRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CutBundleService {

    @Autowired
    private ICutBundleRepo cutBundleRepo;

    @Autowired
    private ICuttingPlanRepo cuttingPlanRepo;

    public List<CutBundle> getAllCutBundles() {
        return cutBundleRepo.findAll();
    }
    public Optional<CutBundle> getCutBundleById (Integer id) {
        return cutBundleRepo.findById(id);
    }
    public CutBundle saveOrUpdate(CutBundle cutBundle) {
        CuttingPlan cuttingPlan = cuttingPlanRepo.findById(cutBundle.getCuttingPlan().getId())
                .orElseThrow(() -> new RuntimeException("Cutting Plan not found with id: " + cutBundle.getCuttingPlan().getId()));


        cutBundle.setCuttingPlan(cuttingPlan);


        return cutBundleRepo.save(cutBundle);
    }

    public void deleteById(Integer id) {
        cuttingPlanRepo.deleteById(id);
    }


    public List<CutBundleDTO> getAllCutBundleDTOS() {
        return cutBundleRepo.findAll().stream().map(cutting -> {
            CutBundleDTO dto = new CutBundleDTO();
            dto.setId(cutting.getId());
            dto.setBundleNo(cutting.getBundleNo());
            dto.setSize(cutting.getSize());
            dto.setColor(cutting.getColor());
            dto.setPlannedQty(cutting.getPlannedQty());
            dto.setCutBundleDate(cutting.getCutBundleDate());

            CuttingPlan cut = cutting.getCuttingPlan();
            if (cut != null) {
                CuttingPlanResponseDTO cuttingPlanResponseDTO = new CuttingPlanResponseDTO();
                cuttingPlanResponseDTO.setId(cut.getId());

                dto.setCuttingPlan(cuttingPlanResponseDTO);


            }
            return dto;
        }).toList();
    }
}
