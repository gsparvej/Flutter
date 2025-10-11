package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.AttendanceResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.EmployeeDTO;
import com.gsparvej.angularWithSpringBoot.dto.LeaveResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Attendance;
import com.gsparvej.angularWithSpringBoot.entity.Employee;
import com.gsparvej.angularWithSpringBoot.entity.Leave;
import com.gsparvej.angularWithSpringBoot.repository.IEmployeeRepo;
import com.gsparvej.angularWithSpringBoot.repository.ILeaveRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LeaveService {
    @Autowired
    private ILeaveRepo leaveRepo;

    @Autowired
    private IEmployeeRepo employeeRepo;


    public List<Leave> getAllLeaves() {
        return leaveRepo.findAll();
    }
    public Optional<Leave> getLeaveById (Integer id) {
        return leaveRepo.findById(id);
    }
    public Leave saveOrUpdate(Leave leave) {
        Employee employee = employeeRepo.findById(leave.getEmployee().getId())
                .orElseThrow(() -> new RuntimeException("Employee not found with id: " + leave.getEmployee().getId()));


        leave.setEmployee(employee);


        return leaveRepo.save(leave);
    }

    public void deleteById(Integer id) {
        leaveRepo.deleteById(id);
    }


    public List<LeaveResponseDTO> getAllLeaveResponseDTOS() {
        return leaveRepo.findAll().stream().map(leave -> {
            LeaveResponseDTO dto = new LeaveResponseDTO();
            dto.setId(leave.getId());
            dto.setLeaveType(leave.getLeaveType());
            dto.setStatus(leave.getStatus());
            dto.setFromDate(leave.getFromDate());
            dto.setToDate(leave.getToDate());



            Employee employee = leave.getEmployee();
            if (employee != null) {
                EmployeeDTO employeeDTO = new EmployeeDTO();
                employeeDTO.setId(employee.getId());
                employeeDTO.setName(employee.getName());

                dto.setEmployee(employeeDTO);


            }
            return dto;
        }).toList();
    }
}
