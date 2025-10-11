package com.gsparvej.angularWithSpringBoot.service;


import com.gsparvej.angularWithSpringBoot.dto.ItemResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Item;
import com.gsparvej.angularWithSpringBoot.entity.Machine;
import com.gsparvej.angularWithSpringBoot.repository.IMachineRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MachineService {

    @Autowired
    private IMachineRepo machineRepo;



    public List<Machine> getAllMachines() {
        return machineRepo.findAll();
    }
    public Machine saveMachines(Machine machine) {
        return machineRepo.save(machine);
    }
    public void deleteById(Integer id) {
        machineRepo.deleteById(id);
    }
//
//    public List<ItemResponseDTO> getAllItemResponseDTOS() {
//        return itemRepo.findAll().stream().map(item -> {
//            ItemResponseDTO dto = new ItemResponseDTO();
//            dto.setId(item.getId());
//            dto.setCategoryName(item.getCategoryName());
//            dto.setUnit(item.getUnit());
//
//
//            return dto;
//        }).toList();
//    }
}
