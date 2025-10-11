package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.BomStyleResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.VendorResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.BomStyle;
import com.gsparvej.angularWithSpringBoot.entity.Vendor;
import com.gsparvej.angularWithSpringBoot.repository.IVendorRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VendorService {

    @Autowired
    private IVendorRepo vendorRepo;

    public List<Vendor> getAllVendors() {
        return vendorRepo.findAll();
    }
    public Vendor saveVendor(Vendor vendor) {
        return vendorRepo.save(vendor);
    }
    public void deleteById(Integer id) {
        vendorRepo.deleteById(id);
    }

    public List<VendorResponseDTO> getAllVendorResponseDTOS() {
        return vendorRepo.findAll().stream().map(ven -> {
            VendorResponseDTO dto = new VendorResponseDTO();
            dto.setId(ven.getId());
            dto.setCompanyName(ven.getCompanyName());
            dto.setPhone(ven.getPhone());

            return dto;
        }).toList();
    }
}
