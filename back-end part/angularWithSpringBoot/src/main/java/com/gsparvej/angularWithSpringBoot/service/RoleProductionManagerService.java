package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.RoleMerchandiserManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RoleProductionManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleMerchandiserManager;
import com.gsparvej.angularWithSpringBoot.entity.RoleProductionManager;
import com.gsparvej.angularWithSpringBoot.repository.IRoleProductionManagerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleProductionManagerService {

    @Autowired
    private IRoleProductionManagerRepo roleProductionManagerRepo;

    public List<RoleProductionManager> getAll() {
        return roleProductionManagerRepo.findAll();
    }




    public List<RoleProductionManagerResponseDTO> getAllProductionManagerResponseDTOS() {
        return roleProductionManagerRepo.findAll().stream().map(manager -> {
            RoleProductionManagerResponseDTO dto = new RoleProductionManagerResponseDTO();


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

    public RoleProductionManager save(RoleProductionManager roleProductionManager) {
        return roleProductionManagerRepo.save(roleProductionManager);
    }

    public void delete(Long id) {
        roleProductionManagerRepo.deleteById(id);
    }

    public RoleProductionManager getProfileByUserId(int userId) {
        return roleProductionManagerRepo.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Role Production Manager not found"));
    }
}
