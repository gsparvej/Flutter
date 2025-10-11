package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.RoleAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RoleHRAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleAdmin;
import com.gsparvej.angularWithSpringBoot.entity.RoleHRAdmin;
import com.gsparvej.angularWithSpringBoot.repository.IRoleHRAdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleHRAdminService {

    @Autowired
    private IRoleHRAdminRepo roleHRAdminRepo;


    public List<RoleHRAdmin> getAll() {
        return roleHRAdminRepo.findAll();
    }


    public List<RoleHRAdminResponseDTO> getAllRoleHRAdminResponseDTOS() {
        return roleHRAdminRepo.findAll().stream().map(admin -> {
            RoleHRAdminResponseDTO dto = new RoleHRAdminResponseDTO();


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



    public RoleHRAdmin save(RoleHRAdmin roleHRAdmin) {
        return roleHRAdminRepo.save(roleHRAdmin);
    }

    public void delete(Long id) {
        roleHRAdminRepo.deleteById(id);
    }

    public RoleHRAdmin getProfileByUserId(int userId) {
        return roleHRAdminRepo.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Role HR Admin not found"));
    }
}
