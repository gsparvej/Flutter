package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.ItemResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.StockInResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.StockOutResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Item;
import com.gsparvej.angularWithSpringBoot.repository.IStockOutRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockOutService {
    @Autowired
    private IStockOutRepo stockOutRepo;

    public List<StockOutResponseDTO> getAllStockOutResponseDTOS() {
        return stockOutRepo.findAll().stream().map(raw -> {
            StockOutResponseDTO dto = new StockOutResponseDTO();
            dto.setId(raw.getId());
            dto.setQuantity(raw.getQuantity());
            dto.setTransactionDate(raw.getTransactionDate());


            Item item = raw.getItem();
            if (item != null) {
                ItemResponseDTO itemResponseDTO = new ItemResponseDTO();
                itemResponseDTO.setId(item.getId());
                itemResponseDTO.setCategoryName(item.getCategoryName());

                dto.setItem(itemResponseDTO);


            }
            return dto;
        }).toList();
    }


}
