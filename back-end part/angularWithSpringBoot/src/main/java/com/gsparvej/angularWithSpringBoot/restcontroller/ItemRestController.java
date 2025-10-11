package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.ItemResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.VendorResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Item;
import com.gsparvej.angularWithSpringBoot.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/item")
@CrossOrigin("*")
public class ItemRestController {

    @Autowired
    private ItemService itemService;

    @GetMapping("all")
    public List<Item> getAllItems() {
        return itemService.getAllItems();
    }



    @GetMapping("")
    public List<ItemResponseDTO> getAllItemsDTOs() {
        return itemService.getAllItemResponseDTOS();
    }


    @PostMapping("")
    public ResponseEntity<Item> createItems(@RequestBody Item items) {
        Item savedItems = itemService.saveItems(items);
        return ResponseEntity.ok(savedItems);
    }
}
