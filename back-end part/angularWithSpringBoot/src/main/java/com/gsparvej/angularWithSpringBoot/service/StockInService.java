package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.repository.IItemRepo;
import com.gsparvej.angularWithSpringBoot.repository.IStockInRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StockInService {
    @Autowired
    private IStockInRepo stockInRepo;
    @Autowired
    private IItemRepo itemRepo;




    public List<StockInModel> getAllStockIn() {
        return stockInRepo.findAll();
    }

//    public StockInModel saveOrUpdate(StockInModel stockInModel) {
//
//        Item item = itemRepo.findById(stockInModel.getItem().getId())
//                .orElseThrow(() -> new RuntimeException("Item Not Found" + stockInModel.getItem().getId()));
//
//
//
//
//        stockInModel.setItem(item);
//
//
//        return stockInRepo.save(stockInModel);
//    }


    public List<StockInResponseDTO> getAllStockInResponseDTOS() {
        return stockInRepo.findAll().stream().map(raw -> {
            StockInResponseDTO dto = new StockInResponseDTO();
            dto.setId(raw.getId());
            dto.setQuantity(raw.getQuantity());
            dto.setReceivedTransactionDate(raw.getReceivedTransactionDate());

            Item item = raw.getItem();
            if (item != null) {
                ItemResponseDTO itemResponseDTO = new ItemResponseDTO();
                itemResponseDTO.setId(item.getId());
                itemResponseDTO.setCategoryName(item.getCategoryName());
                itemResponseDTO.setUnit(item.getUnit());

                dto.setItem(itemResponseDTO);


            }
            return dto;
        }).toList();
    }
}
