package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.AttendanceResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.CutBundleDTO;
import com.gsparvej.angularWithSpringBoot.entity.Attendance;
import com.gsparvej.angularWithSpringBoot.entity.CutBundle;
import com.gsparvej.angularWithSpringBoot.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/attendance")
@CrossOrigin("*")
public class AttendanceRestController {

    @Autowired
    private AttendanceService attendanceService;


    @GetMapping("all")
    public List<Attendance> getAllAtten() {
        return attendanceService.getAllAttendances();
    }

    @GetMapping("")
    public List<AttendanceResponseDTO> getAllAttendanceDTOS() {
        return attendanceService.getAllAttendanceResponseDTOS();
    }
    @PostMapping("")
    public ResponseEntity<Attendance> createAttendance(
            @RequestBody Attendance attendance

    ) {

        Attendance saved = attendanceService.saveOrUpdate(attendance);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }
}
