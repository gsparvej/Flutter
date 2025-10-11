package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.InventoryResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.StockRequestDTO;
import com.gsparvej.angularWithSpringBoot.entity.InventoryModel;
import com.gsparvej.angularWithSpringBoot.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/inventory")
@CrossOrigin("*")
public class InventoryRestController {

    @Autowired
    private InventoryService inventoryService;

    @PostMapping("/add")
    public String addStock(@RequestBody InventoryModel stockRequest) {
        int itemId = stockRequest.getItem().getId();  // ✔️ cleaner and more correct
        int quantity = stockRequest.getQuantity();

        inventoryService.addStock(itemId, quantity);
        return "Stock added successfully!";
    }


    @PostMapping("/remove")
    public String removeStock(@RequestBody InventoryModel stockRequest) {
        int itemId = stockRequest.getItem().getId();
        int quantity = stockRequest.getQuantity();

        inventoryService.addStockOut(itemId, quantity);
        return "Stock removed successfully!";
    }

    @GetMapping("")
    public List<InventoryResponseDTO> getAllInventories() {
        return inventoryService.getAllInventoryResponseDTOS();
    }

//    @GetMapping("/check/{itemId}")
//    public InventoryModel checkInventory(@PathVariable int itemId) {
//        return inventoryService.checkInventory(itemId);
//    }
}
