package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.UomResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.VendorResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.entity.UOM;
import com.gsparvej.angularWithSpringBoot.service.UOMService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/uom")

public class UOMRestController {

    @Autowired
    private UOMService uomService;

    @GetMapping("all")
    public List<UOM> getAllUom() {
        return uomService.getAllUOM();
    }


    @GetMapping("")
    public List<UomResponseDTO> getAllUomDtos() {
        return uomService.getAllUomResponseDTOS();
    }

    @PostMapping("")
    public ResponseEntity<UOM> createUom(@RequestBody UOM uom) {
        UOM savedUom = uomService.saveUom(uom);

        return ResponseEntity.ok(savedUom);
    }


    // Get single Department by id
    @GetMapping("/{id}")
    public ResponseEntity<UOM> getUomById(@PathVariable int id) {
        Optional<UOM> uom = uomService.getAllUOM()
                .stream()
                .filter(u -> u.getId() == id)
                .findFirst();

        return uom.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());

    }

    @PutMapping("/{id}")
    public ResponseEntity<UOM> updateUom(@PathVariable int id ,@RequestBody UOM uom) {
        Optional<UOM> existingUom = uomService.getAllUOM()
                .stream()
                .filter(u-> u.getId() == id)
                .findFirst();

        if (existingUom.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        UOM uo = existingUom.get();
        uo.setProductName(uo.getProductName());
        uo.setSize(uo.getSize());
        uo.setBody(uo.getBody());
        uo.setSleeve(uo.getSleeve());
        uo.setPocket(uo.getPocket());
        uo.setShrinkage(uo.getShrinkage());
        uo.setWastage(uo.getWastage());
        uo.setBaseFabric(uo.getBaseFabric());

        UOM updatedUom = uomService.saveUom(uo);
        return ResponseEntity.ok(updatedUom);

    }

    // Delete Buyer by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUom(@PathVariable int id) {
        Optional<UOM> existingUomOpt = uomService.getAllUOM()
                .stream()
                .filter(u -> u.getId() == id)
                .findFirst();

        if (existingUomOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        uomService.saveUom(existingUomOpt.get()); // you can remove this line if unnecessary
        uomService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
