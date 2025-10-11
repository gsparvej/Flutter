package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.RoleProductionManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RolePurchaseManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleMerchandiserManager;
import com.gsparvej.angularWithSpringBoot.entity.RolePurchaseManager;
import com.gsparvej.angularWithSpringBoot.repository.IRolePurchaseManagerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RolePurchaseManagerService {

    @Autowired
    private IRolePurchaseManagerRepo rolePurchaseManagerRepo;


    public List<RolePurchaseManager> getAll() {
        return rolePurchaseManagerRepo.findAll();
    }


    public List<RolePurchaseManagerResponseDTO> getAllPurchaseManagerResponseDTOS() {
        return rolePurchaseManagerRepo.findAll().stream().map(manager -> {
            RolePurchaseManagerResponseDTO dto = new RolePurchaseManagerResponseDTO();


            dto.setId(manager.getId());
            dto.setEmail(manager.getEmail());
            dto.setName(manager.getName());
            dto.setAddress(manager.getAddress());
            dto.setPhone(manager.getPhone());
            dto.setGender(manager.getGender());
            dto.setPhoto(manager.getPhoto());
            dto.setDateOfBirth(manager.getDateOfBirth());


            return dto;
        }).toList();
    }


    public RolePurchaseManager save(RolePurchaseManager rolePurchaseManager) {
        return rolePurchaseManagerRepo.save(rolePurchaseManager);
    }

    public void delete(Long id) {
        rolePurchaseManagerRepo.deleteById(id);
    }

    public RolePurchaseManager getProfileByUserId(int userId) {
        return rolePurchaseManagerRepo.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Role Purchase Manager not found"));
    }
}
