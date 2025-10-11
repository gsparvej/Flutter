package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.DepartmentResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.service.DepartmentService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/department")
@CrossOrigin("*")
public class DepartmentRestController {

    @Autowired
    private DepartmentService departmentService;

    @GetMapping("")
    public List<DepartmentResponseDTO> getAllDepartment() {
        return departmentService.getAllDepartmentDTOs();
    }

    // Get single Department by id
    @GetMapping("/{id}")
    public ResponseEntity<Department> getDepartmentById(@PathVariable int id) {
        Optional<Department> department = departmentService.getAllDepartments()
                .stream()
                .filter(depart -> depart.getId() == id)
                .findFirst();

        return department.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());

    }
    // create new department
    @PostMapping("")
    public ResponseEntity<Department> createDepartment(@RequestBody Department department) {
        Department savedDepartment = departmentService.saveDepartment(department);
        return ResponseEntity.ok(savedDepartment);
    }
    // update existing department

    @PutMapping("/{id}")
    public ResponseEntity<Department> updateDepartment(@PathVariable int id, @RequestBody Department department) {
        Optional<Department> existingDepartment = departmentService.getAllDepartments()
                .stream()
                .filter(depart -> depart.getId() == id)
                .findFirst();
        if (existingDepartment.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Department d = existingDepartment.get();
        d.setName(department.getName());

        Department updatedDepartment = departmentService.saveDepartment(d);
        return ResponseEntity.ok(updatedDepartment);

    }

    // Delete department by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDepartment(@PathVariable int id) {
        Optional<Department> existingDepartOpt = departmentService.getAllDepartments()
                .stream()
                .filter(c -> c.getId() == id)
                .findFirst();

        if (existingDepartOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        departmentService.saveDepartment(existingDepartOpt.get()); // you can remove this line if unnecessary
        departmentService.deleteById(id);
        return ResponseEntity.noContent().build();
    }



}
