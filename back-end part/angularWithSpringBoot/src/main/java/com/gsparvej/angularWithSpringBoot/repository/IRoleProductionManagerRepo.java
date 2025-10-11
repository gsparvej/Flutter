package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.RoleHRAdmin;
import com.gsparvej.angularWithSpringBoot.entity.RoleProductionManager;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRoleProductionManagerRepo extends JpaRepository<RoleProductionManager, Long> {
    Optional<RoleProductionManager> findByUserId(int userId);
}
