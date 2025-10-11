package com.gsparvej.angularWithSpringBoot.restcontroller;
import com.gsparvej.angularWithSpringBoot.dto.DayWiseProductionResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.DayWiseProduction;
import com.gsparvej.angularWithSpringBoot.service.DayWiseProductionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dayWisePro")
@CrossOrigin("*")
public class DayWiseProductionRestController {

    @Autowired
    private DayWiseProductionService dayWiseProductionService;

//    @GetMapping("/all")
//    public List<DayWiseProduction> getAllPro() {
//        return dayWiseProductionService.getAllDayWise();
//    }
    @GetMapping("/all")
    public List<DayWiseProductionResponseDTO> getDayWise() {
        return dayWiseProductionService.getAllDayWiseProductionResponseDTOS();
    }


    @PostMapping("")
    public ResponseEntity<DayWiseProduction> createDayWise(
            @RequestBody DayWiseProduction dayWiseProduction

    ) {

        DayWiseProduction saved = dayWiseProductionService.saveOrUpdate(dayWiseProduction);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }
}
