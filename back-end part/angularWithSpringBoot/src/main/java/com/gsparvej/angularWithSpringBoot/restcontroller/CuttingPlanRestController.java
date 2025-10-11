package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.CuttingPlanResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.CuttingPlan;
import com.gsparvej.angularWithSpringBoot.service.CuttingPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cutting_plan")
@CrossOrigin("*")
public class CuttingPlanRestController {

    @Autowired
    private CuttingPlanService cuttingPlanService;

    @GetMapping("all")
    public List<CuttingPlan> getAllCuttingPlan() {
        return cuttingPlanService.getAllCuttingPlans();
    }
    @GetMapping("")
    public List<CuttingPlanResponseDTO> getCuttingPlanResponseDTOS() {
        return cuttingPlanService.getAllCuttingPlanResponseDTOS();
    }


    @PostMapping("")
    public ResponseEntity<CuttingPlan> createCuttingPlan(
            @RequestBody CuttingPlan cuttingPlan

    ) {

        CuttingPlan saved = cuttingPlanService.saveOrUpdate(cuttingPlan);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }

    @GetMapping("/production_OrderId/{id}")
    public List<CuttingPlanResponseDTO> getCuttingPlanById(@PathVariable int id) {
        return cuttingPlanService.getCuttingPlanByProductionOrderId(id);
    }
}
