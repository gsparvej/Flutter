package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.RoleHRAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RoleMerchandiserManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleMerchandiserManager;
import com.gsparvej.angularWithSpringBoot.repository.IRoleMerchandiserManagerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleMerchandiserManagerService {

    @Autowired
    private IRoleMerchandiserManagerRepo roleMerchandiserManagerRepo;

    public List<RoleMerchandiserManager> getAll() {
        return roleMerchandiserManagerRepo.findAll();
    }


    public List<RoleMerchandiserManagerResponseDTO> getAllMerchandiserManagerResponseDTOS() {
        return roleMerchandiserManagerRepo.findAll().stream().map(merchandiser -> {
            RoleMerchandiserManagerResponseDTO dto = new RoleMerchandiserManagerResponseDTO();


            dto.setId(merchandiser.getId());
            dto.setEmail(merchandiser.getEmail());
            dto.setName(merchandiser.getName());
            dto.setAddress(merchandiser.getAddress());
            dto.setPhone(merchandiser.getPhone());
            dto.setGender(merchandiser.getGender());
            dto.setPhoto(merchandiser.getPhoto());
            dto.setDateOfBirth(merchandiser.getDateOfBirth());


            return dto;
        }).toList();
    }



    public RoleMerchandiserManager save(RoleMerchandiserManager roleMerchandiserManager) {
        return roleMerchandiserManagerRepo.save(roleMerchandiserManager);
    }

    public void delete(Long id) {
        roleMerchandiserManagerRepo.deleteById(id);
    }

    public RoleMerchandiserManager getProfileByUserId(int userId) {
        return roleMerchandiserManagerRepo.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Role Merchandiser Manager not found"));
    }
}
