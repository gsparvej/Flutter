package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.RawMaterialsResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.StockInResponseDTO;
import com.gsparvej.angularWithSpringBoot.service.StockInService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/stock_in")
@CrossOrigin("*")
public class StockInRestController {
    @Autowired
    private StockInService stockInService;


    @GetMapping("")
    public List<StockInResponseDTO> getAllStockIn() {
        return stockInService.getAllStockInResponseDTOS();
    }
}
