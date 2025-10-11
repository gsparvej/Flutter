package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.DepartmentResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.repository.IDepartmentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private IDepartmentRepo departmentRepo;


    public List<Department> getAllDepartments() {
        return departmentRepo.findAll();
    }

    public List<DepartmentResponseDTO> getAllDepartmentDTOs() {
        return getAllDepartments().stream().map(depart -> {
            DepartmentResponseDTO dto = new DepartmentResponseDTO();
            dto.setId(depart.getId());
            dto.setName(depart.getName());

            List<Integer> designationsIds = depart.getDesignations().stream()
                    .map(d -> d.getId())
                    .toList();
            return dto;
        }).toList();
    }


    public Department saveDepartment(Department department) {
        return departmentRepo.save(department);
    }

    public void deleteById(Integer id) {
        departmentRepo.deleteById(id);
    }
}
