package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.dto.LeaveResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Attendance;
import com.gsparvej.angularWithSpringBoot.entity.Leave;
import com.gsparvej.angularWithSpringBoot.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/leave")

public class LeaveRestController {
    @Autowired
    private LeaveService leaveService;


    @GetMapping("all")
    public List<Leave> getAllLeave() {
        return leaveService.getAllLeaves();
    }

        @GetMapping("")
    public List<LeaveResponseDTO> getAllLeaveDTOS() {
        return leaveService.getAllLeaveResponseDTOS();
    }
    @PostMapping("")
    public ResponseEntity<Leave> createLeave(
            @RequestBody Leave leave

    ) {

        Leave saved = leaveService.saveOrUpdate(leave);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }
}
