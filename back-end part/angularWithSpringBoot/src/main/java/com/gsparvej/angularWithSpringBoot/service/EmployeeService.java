package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.*;
import com.gsparvej.angularWithSpringBoot.entity.CuttingPlan;
import com.gsparvej.angularWithSpringBoot.entity.Department;
import com.gsparvej.angularWithSpringBoot.entity.Designation;
import com.gsparvej.angularWithSpringBoot.entity.Employee;
import com.gsparvej.angularWithSpringBoot.repository.IDepartmentRepo;
import com.gsparvej.angularWithSpringBoot.repository.IDesignationRepo;
import com.gsparvej.angularWithSpringBoot.repository.IEmployeeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {
    @Autowired
    private IEmployeeRepo employeeRepo;

    @Autowired
    private IDepartmentRepo departmentRepo;

    @Autowired
    private IDesignationRepo designationRepo;

    public List<EmployeeDTO> getAllEmployeeDTOS() {
        return employeeRepo.findAll().stream().map(employee -> {
            EmployeeDTO dto = new EmployeeDTO();
            dto.setId(employee.getId());
            dto.setName(employee.getName());
            dto.setEmail(employee.getEmail());
            dto.setJoinDate(employee.getJoinDate());
            dto.setPhoneNumber(employee.getPhoneNumber());



            Department department = employee.getDepartment();
            if (department != null) {
                DepartmentResponseDTO departmentResponseDTO = new DepartmentResponseDTO();
                departmentResponseDTO.setName(department.getName());

                dto.setDepartment(departmentResponseDTO);


            }
            Designation designation = employee.getDesignation();
            if (designation != null) {
                DesignationResponseDTO designationResponseDTO = new DesignationResponseDTO();
                designationResponseDTO.setDesignationTitle(designation.getDesignationTitle());

                dto.setDesignation(designationResponseDTO);


            }




            return dto;
        }).toList();
    }
    //  public String getDesignationTitle() {
    //        return designationTitle;
    //    }


    // public Designation getDesignation() {
    //        return designation;




    public Optional<Employee> getEmployeeById(Integer id) {
        return employeeRepo.findById(id);
    }
    public Employee saveOrUpdate(Employee employee,Designation designation, Department department) {
        employee.setDesignation(designation);
        employee.setDepartment(department);
        return employeeRepo.save(employee);

    }
    public void deleteById(Integer id) {
        employeeRepo.deleteById(id);
    }
    public Employee getProfileById(Integer id) {
        return employeeRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found"));
    }
}
