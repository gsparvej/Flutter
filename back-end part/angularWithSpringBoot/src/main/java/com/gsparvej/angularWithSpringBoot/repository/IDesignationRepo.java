package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.Designation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IDesignationRepo extends JpaRepository<Designation, Integer> {
    List<Designation> findByDepartmentId(Integer departmentId);
}
