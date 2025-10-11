package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.BuyerResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.repository.IBuyerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BuyerService {

    @Autowired
    private IBuyerRepo buyerRepo;

    public List<Buyer> getAllBuyers() {
        return buyerRepo.findAll();
    }
    public Buyer saveBuyer(Buyer buyer) {
        return buyerRepo.save(buyer);
    }
    public void deleteById(Integer id) {
        buyerRepo.deleteById(id);
    }

    public List<BuyerResponseDTO> getAllBuyerResponseDTOS() {
        return buyerRepo.findAll().stream().map(buyer -> {
            BuyerResponseDTO dto = new BuyerResponseDTO();
            dto.setId(buyer.getId());
            dto.setName(buyer.getName());
            dto.setCountry(buyer.getCountry());
            dto.setPhone(buyer.getPhone());
            dto.setEmail(buyer.getEmail());
            dto.setAddress(buyer.getAddress());
            dto.setWebsite(buyer.getWebsite());
            dto.setContactPerson(buyer.getContactPerson());
            return dto;
        }).toList();
    }
}
