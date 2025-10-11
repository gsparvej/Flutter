package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.BomResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IBomStyleRepo;
import com.gsparvej.angularWithSpringBoot.repository.IUOMRepo;
import com.gsparvej.angularWithSpringBoot.service.BOMService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/bom")
public class BOMRestController {

    @Autowired
    private BOMService bomService;
    @Autowired
    private IBomStyleRepo bomStyleRepo;
    @Autowired
    private IUOMRepo uomRepo;

    @GetMapping("")
    public List<BOM> getAllBom() {
        return bomService.getAllBoms();
    }
    // Get single BOM by styleCode
//    @GetMapping("/{stylecode}")
//    public ResponseEntity<BOM> getBomByStyleCode(@PathVariable String styleCode) {
//        Optional<BOM> bom = bomService.getAllBoms()
//                .stream()
//                .filter(b -> b.getBomStyle() == styleCode)
//                .findFirst();
//
//        return bom.map(ResponseEntity::ok)
//                .orElseGet(() -> ResponseEntity.notFound().build());
//
//    }

    // create new Bom
    @PostMapping
    public ResponseEntity<BOM> createBom(
            @RequestBody BOM bom

    ) {

        BOM saved = bomService.saveOrUpdate(bom);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }


    @GetMapping("/style/{styleCode}")
    public List<BomResponseDTO> getBOMsByStyleCode(@PathVariable String styleCode) {
        return bomService.getBOMsByStyleCode(styleCode);
    }


}
