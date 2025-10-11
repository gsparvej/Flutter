package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.InventoryResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.OrderResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.ProductionOrderResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IInventoryRepo;
import com.gsparvej.angularWithSpringBoot.repository.IItemRepo;
import com.gsparvej.angularWithSpringBoot.repository.IStockInRepo;
import com.gsparvej.angularWithSpringBoot.repository.IStockOutRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Date;
import java.util.List;

@Service
public class InventoryService {

    @Autowired
    private IInventoryRepo inventoryRepo;
    @Autowired
    private IStockInRepo stockInRepo;
    @Autowired
    private IStockOutRepo stockOutRepo;
    @Autowired
    private IItemRepo  itemRepo;

    public void addStock(int itemId, int quantity) {
        // Fetch the existing Item object from the database
        Item item = itemRepo.findById(itemId).orElse(null);

        if (item == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Item with ID " + itemId + " not found.");
        }

        InventoryModel inventory = inventoryRepo.findByItemId(itemId);
        if (inventory != null) {
            // Update existing inventory
            inventory.setQuantity(inventory.getQuantity() + quantity);
            inventoryRepo.save(inventory);
        } else {
            // If inventory doesn't exist, create a new inventory record
            InventoryModel newInventory = new InventoryModel(0, quantity, item);
            inventoryRepo.save(newInventory);
        }

        // Create a StockIn entry (save the stock entry)
        StockInModel stockIn = new StockInModel(0, new Date(), quantity, item);
        stockInRepo.save(stockIn);
    }


    // Method to remove stock (Stock Out)
    public void addStockOut(int itemId, int quantity) {
        // Fetch the existing Item object from the database
        Item item = itemRepo.findById(itemId).orElse(null);

        if (item == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Item with ID " + itemId + " not found.");
        }

        // Fetch inventory entry
        InventoryModel inventory = inventoryRepo.findByItemId(itemId);

        if (inventory != null) {
            // Check if there's enough stock for stock-out
            if (inventory.getQuantity() < quantity) {
                throw new RuntimeException("Insufficient stock for item ID " + itemId);
            }

            // Update inventory quantity (subtracting the stock-out quantity)
            inventory.setQuantity(inventory.getQuantity() - quantity);
            inventoryRepo.save(inventory);
        } else {
            // If inventory doesn't exist, throw an error or handle accordingly
            throw new RuntimeException("No inventory record found for item ID " + itemId);
        }

        // Create a StockOut entry (save the stock-out transaction)
        StockOutModel stockOut = new StockOutModel(0, new Date(), quantity, item);
        stockOutRepo.save(stockOut);
    }


    public List<InventoryResponseDTO> getAllInventoryResponseDTOS() {
        return inventoryRepo.findAll().stream().map(inventory -> {
            InventoryResponseDTO dto = new InventoryResponseDTO();
            dto.setId(inventory.getId());
            dto.setQuantity(inventory.getQuantity());
            dto.setCategoryName(inventory.getItem().getCategoryName());




            return dto;
        }).toList();
    }

}
