package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.StockInResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.StockOutResponseDTO;
import com.gsparvej.angularWithSpringBoot.service.StockOutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/stock_out")
@CrossOrigin("*")
public class StockOutRestController {

    @Autowired
    private StockOutService stockOutService;

    @GetMapping("")
    public List<StockOutResponseDTO> getAllStockOut() {
        return stockOutService.getAllStockOutResponseDTOS();
    }
}
