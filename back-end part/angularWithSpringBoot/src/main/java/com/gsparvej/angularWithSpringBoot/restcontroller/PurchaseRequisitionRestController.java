package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.FullOrderViewResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.FullRequisitionResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.PurchaseRequisitionDTO;
import com.gsparvej.angularWithSpringBoot.entity.BOM;
import com.gsparvej.angularWithSpringBoot.entity.PurchaseRequisition;
import com.gsparvej.angularWithSpringBoot.repository.IPurchaseRequisitionRepo;
import com.gsparvej.angularWithSpringBoot.service.PurchaseRequisitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/requisition")
@CrossOrigin("*")
public class PurchaseRequisitionRestController {

    @Autowired
    private PurchaseRequisitionService requisitionService;

    @Autowired
    private IPurchaseRequisitionRepo requisitionRepo;

    @GetMapping("all")
    public List<PurchaseRequisition> getAllRequisitions() {
        return requisitionService.getAllPurchaseRequisitions();
    }


    @GetMapping("")
    public List<PurchaseRequisitionDTO> getAllRequisitionsDTO() {
        return requisitionService.getAllRequisitionsDTOs();
    }

    @GetMapping("/id/{id}")
    public List<FullRequisitionResponseDTO> getRequisitionByIdFromDTOs(@PathVariable int id) {
        return requisitionService.getFullRequisitionResponseDTOS(id);
    }


    // create new Requisition
    @PostMapping("")
    public ResponseEntity<PurchaseRequisition> createRequisition(
            @RequestBody PurchaseRequisition purchaseRequisition

    ) {

        PurchaseRequisition saved = requisitionService.saveOrUpdate(purchaseRequisition);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }


    // GET requisition by ID
    @GetMapping("/{id}")
    public ResponseEntity<PurchaseRequisition> getRequisitionById(@PathVariable int id) {
        return requisitionRepo.findById(id)
                .map(requisition -> ResponseEntity.ok(requisition))
                .orElse(ResponseEntity.notFound().build());
    }

//    // GET requisition by ID
//    @GetMapping("/{id}")
//    public ResponseEntity<PurchaseRequisitionDTO> getRequisitionById(@PathVariable int id) {
//        return requisitionRepo.findById(id)
//                .map(requisition -> {
//                    // Map entity to DTO
//                    PurchaseRequisitionDTO dto = new PurchaseRequisitionDTO(
//                            requisition.getId(),
//                            requisition.getPrDate(),
//                            requisition.getRequestedBy(),
//                            requisition.getPrStatus()
//                    );
//                    return ResponseEntity.ok(dto);
//                })
//                .orElse(ResponseEntity.notFound().build());
//    }




}
