package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.CutBundleDTO;
import com.gsparvej.angularWithSpringBoot.dto.CuttingPlanResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.CutBundle;
import com.gsparvej.angularWithSpringBoot.entity.CuttingPlan;
import com.gsparvej.angularWithSpringBoot.service.CutBundleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cutBundle")
@CrossOrigin("*")
public class CutBundleRestController {

    @Autowired
    private CutBundleService cutBundleService;

    @GetMapping("all")
    public List<CutBundle> getAllCutBundle() {
        return cutBundleService.getAllCutBundles();
    }

    @GetMapping("")
    public List<CutBundleDTO> getAllCutBunDTOs() {
        return cutBundleService.getAllCutBundleDTOS();
    }
    @PostMapping("")
    public ResponseEntity<CutBundle> createCutBundle(
            @RequestBody CutBundle cutBundle

    ) {

        CutBundle saved = cutBundleService.saveOrUpdate(cutBundle);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }
}
