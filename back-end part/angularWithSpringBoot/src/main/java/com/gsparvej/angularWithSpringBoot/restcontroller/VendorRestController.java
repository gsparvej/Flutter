package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.VendorResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.BomStyle;
import com.gsparvej.angularWithSpringBoot.entity.Vendor;
import com.gsparvej.angularWithSpringBoot.service.VendorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/vendor")
@CrossOrigin("*")
public class VendorRestController {

    @Autowired
    private VendorService vendorService;

    @GetMapping("/all")
    public List<Vendor> getAllVendor() {
        return vendorService.getAllVendors();
    }

    @GetMapping("")
    public List<VendorResponseDTO> getAllvendorDtos() {
        return vendorService.getAllVendorResponseDTOS();
    }

    @PostMapping("")
    public ResponseEntity<Vendor> createVendor(@RequestBody Vendor vendor) {
        Vendor savedVendor = vendorService.saveVendor(vendor);
        return ResponseEntity.ok(savedVendor);
    }

    // Get single Vendor by id
    @GetMapping("/{id}")
    public ResponseEntity<Vendor> getVendorById(@PathVariable int id) {
        Optional<Vendor> ven = vendorService.getAllVendors()
                .stream()
                .filter(buy -> buy.getId() == id)
                .findFirst();

        return ven.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());

    }

    @PutMapping("/{id}")
    public ResponseEntity<Vendor> updateVendor(@PathVariable int id ,@RequestBody Vendor vendor) {
        Optional<Vendor> existingVendor = vendorService.getAllVendors()
                .stream()
                .filter(ven-> ven.getId() == id)
                .findFirst();

        if (existingVendor.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Vendor v = existingVendor.get();
        v.setVendorName(vendor.getVendorName());
        v.setAddress(vendor.getAddress());


        Vendor updatedVendor = vendorService.saveVendor(vendor);
        return ResponseEntity.ok(updatedVendor);

    }

    // Delete BomStyle by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVendor(@PathVariable int id) {
        Optional<Vendor> existingVendorOpt = vendorService.getAllVendors()
                .stream()
                .filter(b -> b.getId() == id)
                .findFirst();

        if (existingVendorOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        vendorService.saveVendor(existingVendorOpt.get()); // you can remove this line if unnecessary
        vendorService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
