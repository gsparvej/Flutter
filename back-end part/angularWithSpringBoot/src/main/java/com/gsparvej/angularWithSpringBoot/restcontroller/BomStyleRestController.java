package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.BomStyle;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.service.BomStyleService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/bomstyle")

public class BomStyleRestController {

    @Autowired
    private BomStyleService bomStyleService;

    @GetMapping("/all")
    public List<BomStyle> getAllBomStyle() {
        return bomStyleService.getAllBomStyle();
    }

    @GetMapping("")
    public List<BomStyleResponseDTO> getAllBomStyleDtos() {
        return bomStyleService.getAllBomStyleResponseDTOS();
    }

    @PostMapping("")
    public ResponseEntity<BomStyle> createBomStyle(@RequestBody BomStyle bomStyle) {
        BomStyle savedstyle = bomStyleService.saveBomStyle(bomStyle);
        return ResponseEntity.ok(savedstyle);// For testing, just return what you receive
    }


    // Get single BomStyle by id
    @GetMapping("/{id}")
    public ResponseEntity<BomStyle> getStyleById(@PathVariable int id) {
        Optional<BomStyle> style = bomStyleService.getAllBomStyle()
                .stream()
                .filter(buy -> buy.getId() == id)
                .findFirst();

        return style.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());

    }

    @PutMapping("/{id}")
    public ResponseEntity<BomStyle> updateStyle(@PathVariable int id ,@RequestBody BomStyle style) {
        Optional<BomStyle> existingStyle = bomStyleService.getAllBomStyle()
                .stream()
                .filter(buy-> buy.getId() == id)
                .findFirst();

        if (existingStyle.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        BomStyle bom = existingStyle.get();
        bom.setStyleCode(style.getStyleCode());
        bom.setStyleType(style.getStyleType());
        bom.setDescription(style.getDescription());

        BomStyle updatedStyle = bomStyleService.saveBomStyle(bom);
        return ResponseEntity.ok(updatedStyle);

    }

    // Delete BomStyle by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBomStyle(@PathVariable int id) {
        Optional<BomStyle> existingStyleOpt = bomStyleService.getAllBomStyle()
                .stream()
                .filter(b -> b.getId() == id)
                .findFirst();

        if (existingStyleOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        bomStyleService.saveBomStyle(existingStyleOpt.get()); // you can remove this line if unnecessary
        bomStyleService.deleteById(id);
        return ResponseEntity.noContent().build();
    }


}
