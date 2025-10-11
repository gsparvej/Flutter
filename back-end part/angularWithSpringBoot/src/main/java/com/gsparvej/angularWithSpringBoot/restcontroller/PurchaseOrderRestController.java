package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.FullOrderViewResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.PurchaseOrderResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.PurchaseOrder;
import com.gsparvej.angularWithSpringBoot.entity.PurchaseRequisition;
import com.gsparvej.angularWithSpringBoot.service.PurchaseOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/po")
@CrossOrigin("*")
public class PurchaseOrderRestController {

    @Autowired
    private PurchaseOrderService purchaseOrderService;

    @GetMapping("all")
    public List<PurchaseOrder> getAllPOs() {
        return purchaseOrderService.getAllPurchaseOrders();
    }
    @GetMapping("")
    public List<PurchaseOrderResponseDTO> getAllPurchaseOrderDTOS() {
        return purchaseOrderService.getAllPurchaseOrderResponseDTOS();
    }

    @GetMapping("/id/{id}")
    public List<PurchaseOrderResponseDTO> getPOOrderByIdFromDTOs(@PathVariable int id) {
        return purchaseOrderService.getPurchaseOrderFullViewResponseDTOS(id);
    }



    // create new Purchase
    @PostMapping("")
    public ResponseEntity<PurchaseOrder> createPurchase(
            @RequestBody PurchaseOrder purchaseOrder

    ) {

        PurchaseOrder saved = purchaseOrderService.saveOrUpdate(purchaseOrder);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }


}
