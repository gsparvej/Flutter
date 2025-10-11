package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.DesignationResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.entity.Designation;
import com.gsparvej.angularWithSpringBoot.repository.IDepartmentRepo;
import com.gsparvej.angularWithSpringBoot.service.DesignationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/designation")
@CrossOrigin("*")
public class DesignationRestController {

    @Autowired
    private DesignationService designationService;

    @Autowired
    private IDepartmentRepo departmentRepo;

    // Create

    @GetMapping("")
    public List<DesignationResponseDTO> getAllDesignation() {
        return designationService.getAllDesignationDTOs();
    }

    @PostMapping
    public ResponseEntity<Designation> createDesignation(
            @RequestBody Designation designation

    ) {
        Department department = departmentRepo.findById(designation.getDepartment().getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Department not found"));
        Designation saved = designationService.saveOrUpdate(designation, department);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public Designation getById(@PathVariable Integer id) {
        return designationService.findById(id)
                .orElseThrow(() -> new RuntimeException("Designation not found"));
    }
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable Integer id) {
        designationService.delete(id);
    }
    @PutMapping("/{id}")
    public Designation update(@PathVariable Integer id, @RequestBody Designation designation) {
        return designationService.update(id, designation);
    }

    @GetMapping("/by-department/{departId}")
    public List<DesignationResponseDTO> getByDepartment(@PathVariable int departId) {
        return designationService.getByDepartmentId(departId);
    }


}
