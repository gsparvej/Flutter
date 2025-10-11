package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.AttendanceResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.CutBundleDTO;
import com.gsparvej.angularWithSpringBoot.dto.CuttingPlanResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.EmployeeDTO;
import com.gsparvej.angularWithSpringBoot.entity.Attendance;
import com.gsparvej.angularWithSpringBoot.entity.CutBundle;
import com.gsparvej.angularWithSpringBoot.entity.CuttingPlan;
import com.gsparvej.angularWithSpringBoot.entity.Employee;
import com.gsparvej.angularWithSpringBoot.repository.IAttendanceRepo;
import com.gsparvej.angularWithSpringBoot.repository.IEmployeeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AttendanceService {

    @Autowired
    private IAttendanceRepo attendanceRepo;

    @Autowired
    private IEmployeeRepo employeeRepo;


    public List<Attendance> getAllAttendances() {
        return attendanceRepo.findAll();
    }
    public Optional<Attendance> getAttendanceById (Integer id) {
        return attendanceRepo.findById(id);
    }
    public Attendance saveOrUpdate(Attendance attendance) {
        Employee employee = employeeRepo.findById(attendance.getEmployee().getId())
                .orElseThrow(() -> new RuntimeException("Employee not found with id: " + attendance.getEmployee().getId()));


        attendance.setEmployee(employee);


        return attendanceRepo.save(attendance);
    }

    public void deleteById(Integer id) {
        attendanceRepo.deleteById(id);
    }

    public List<AttendanceResponseDTO> getAllAttendanceResponseDTOS() {
        return attendanceRepo.findAll().stream().map(atten -> {
            AttendanceResponseDTO dto = new AttendanceResponseDTO();
            dto.setId(atten.getId());
            dto.setAttDate(atten.getAttDate());
            dto.setStatus(atten.getStatus());


            Employee employee = atten.getEmployee();
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
