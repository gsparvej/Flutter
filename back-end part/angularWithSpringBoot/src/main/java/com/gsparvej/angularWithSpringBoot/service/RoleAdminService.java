package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.RoleAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RoleSuperAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleAdmin;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import com.gsparvej.angularWithSpringBoot.repository.IRoleAdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleAdminService {

    @Autowired
    private IRoleAdminRepo roleAdminRepo;

    public List<RoleAdmin> getAllAdmin() {
        return roleAdminRepo.findAll();
    }



    public List<RoleAdminResponseDTO> getAllRoleAdminResponseDTOS() {
        return roleAdminRepo.findAll().stream().map(admin -> {
            RoleAdminResponseDTO dto = new RoleAdminResponseDTO();


            dto.setId(admin.getId());
            dto.setEmail(admin.getEmail());
            dto.setName(admin.getName());
            dto.setAddress(admin.getAddress());
            dto.setPhone(admin.getPhone());
            dto.setGender(admin.getGender());
            dto.setPhoto(admin.getPhoto());
            dto.setDateOfBirth(admin.getDateOfBirth());


            return dto;
        }).toList();
    }


    public RoleAdmin save(RoleAdmin roleAdmin) {
        return roleAdminRepo.save(roleAdmin);
    }

    public void delete(Long id) {
        roleAdminRepo.deleteById(id);
    }

    public RoleAdmin getProfileByUserId(int userId) {
        return roleAdminRepo.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Role Admin not found"));
    }
}
