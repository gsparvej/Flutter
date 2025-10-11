package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.entity.Line;
import com.gsparvej.angularWithSpringBoot.entity.Machine;
import com.gsparvej.angularWithSpringBoot.service.MachineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/machine")
@CrossOrigin("*")
public class MachineRestController {

    @Autowired
    private MachineService machineService;

    @GetMapping("")
    public List<Machine> getAllMachine() {
        return machineService.getAllMachines();
    }

    @PostMapping("")
    public ResponseEntity<Machine> createMachine(@RequestBody Machine machine) {
        Machine savedMachine = machineService.saveMachines(machine);
        return ResponseEntity.ok(savedMachine);
    }
}
