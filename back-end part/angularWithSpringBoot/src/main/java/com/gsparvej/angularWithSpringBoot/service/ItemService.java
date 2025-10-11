package com.gsparvej.angularWithSpringBoot.service;


import com.gsparvej.angularWithSpringBoot.dto.ItemResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.VendorResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Item;
import com.gsparvej.angularWithSpringBoot.repository.IItemRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemService {

    @Autowired
    private IItemRepo itemRepo;

    public List<Item> getAllItems() {
        return itemRepo.findAll();
    }
    public Item saveItems(Item items) {
        return itemRepo.save(items);
    }
    public void deleteById(Integer id) {
        itemRepo.deleteById(id);
    }

    public List<ItemResponseDTO> getAllItemResponseDTOS() {
        return itemRepo.findAll().stream().map(item -> {
            ItemResponseDTO dto = new ItemResponseDTO();
            dto.setId(item.getId());
            dto.setCategoryName(item.getCategoryName());
            dto.setUnit(item.getUnit());


            return dto;
        }).toList();
    }
}
