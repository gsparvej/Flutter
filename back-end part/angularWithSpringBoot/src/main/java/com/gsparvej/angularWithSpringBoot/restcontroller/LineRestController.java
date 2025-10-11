package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.gsparvej.angularWithSpringBoot.entity.Item;
import com.gsparvej.angularWithSpringBoot.entity.Line;
import com.gsparvej.angularWithSpringBoot.service.LineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/line")
@CrossOrigin("*")
public class LineRestController {

    @Autowired
    private LineService lineService;


    @GetMapping("")
    public List<Line> getAllLine() {
        return lineService.getAlLines();
    }

    @PostMapping("")
    public ResponseEntity<Line> createLines(@RequestBody Line line) {
        Line savedLines = lineService.saveLines(line);
        return ResponseEntity.ok(savedLines);
    }
}
