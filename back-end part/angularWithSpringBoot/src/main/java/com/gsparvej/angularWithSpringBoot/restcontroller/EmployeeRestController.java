package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.EmployeeDTO;
import com.gsparvej.angularWithSpringBoot.entity.Buyer;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.entity.Designation;
import com.gsparvej.angularWithSpringBoot.entity.Employee;
import com.gsparvej.angularWithSpringBoot.repository.IDepartmentRepo;
import com.gsparvej.angularWithSpringBoot.repository.IDesignationRepo;
import com.gsparvej.angularWithSpringBoot.repository.IEmployeeRepo;
import com.gsparvej.angularWithSpringBoot.service.DepartmentService;
import com.gsparvej.angularWithSpringBoot.service.DesignationService;
import com.gsparvej.angularWithSpringBoot.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/employee")


public class EmployeeRestController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private DesignationService designationService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private IEmployeeRepo employeeRepo;

    @Autowired
    private IDepartmentRepo departmentRepo;

    @Autowired
    private IDesignationRepo designationRepo;


    @GetMapping("")
    public List<EmployeeDTO> getAllEmp() {
        return employeeService.getAllEmployeeDTOS();
    }


    @PostMapping("")
    public ResponseEntity<Employee> createEmployee(
            @RequestBody Employee employee

    ){
        Department department = departmentRepo.findById(employee.getDepartment().getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Department not found"));
        Designation designation = designationRepo.findById(employee.getDesignation().getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Designation not found"));
        Employee saved = employeeService.saveOrUpdate(employee,designation,department);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }




}
