package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.ItemResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.Item;
import com.gsparvej.angularWithSpringBoot.entity.Line;
import com.gsparvej.angularWithSpringBoot.repository.ILineRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LineService {
    @Autowired
    private ILineRepo lineRepo;


    public List<Line> getAlLines() {
        return lineRepo.findAll();
    }
    public Line saveLines(Line line) {
        return lineRepo.save(line);
    }
    public void deleteById(Integer id) {
        lineRepo.deleteById(id);
    }


}
