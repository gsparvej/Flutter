package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.BuyerResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.service.BuyerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/buyer")

public class BuyerRestController {

    @Autowired
    private BuyerService buyerService;

    @GetMapping("/all")
    public List<Buyer> getAllBuyers() {
        return buyerService.getAllBuyers();
    }
    @GetMapping("")
    public List<BuyerResponseDTO> getAllBuyersDtos() {
        return buyerService.getAllBuyerResponseDTOS();
    }


    @PostMapping("")
    public ResponseEntity<Buyer> createBuyer(@RequestBody Buyer buyer) {
        Buyer savedBuyer = buyerService.saveBuyer(buyer);
        return ResponseEntity.ok(savedBuyer);
    }


    // Get single Department by id
    @GetMapping("/{id}")
    public ResponseEntity<Buyer> getBuyerById(@PathVariable int id) {
        Optional<Buyer> buyer = buyerService.getAllBuyers()
                .stream()
                .filter(buy -> buy.getId() == id)
                .findFirst();

        return buyer.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());

    }

    @PutMapping("/{id}")
    public ResponseEntity<Buyer> updateBuyer(@PathVariable int id ,@RequestBody Buyer buyer) {
        Optional<Buyer> existingBuyer = buyerService.getAllBuyers()
                .stream()
                .filter(buy-> buy.getId() == id)
                .findFirst();

        if (existingBuyer.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Buyer b = existingBuyer.get();
        b.setName(buyer.getName());
        b.setCountry(buyer.getCountry());
        b.setAddress(buyer.getAddress());
        b.setPhone(buyer.getPhone());
        b.setEmail(buyer.getEmail());
        b.setContactPerson(buyer.getContactPerson());
        b.setWebsite(buyer.getWebsite());



        Buyer updatedBuyer = buyerService.saveBuyer(b);
        return ResponseEntity.ok(updatedBuyer);

    }

    // Delete Buyer by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBuyer(@PathVariable int id) {
        Optional<Buyer> existingBuyerOpt = buyerService.getAllBuyers()
                .stream()
                .filter(b -> b.getId() == id)
                .findFirst();

        if (existingBuyerOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        buyerService.saveBuyer(existingBuyerOpt.get()); // you can remove this line if unnecessary
        buyerService.deleteById(id);
        return ResponseEntity.noContent().build();
    }



}
