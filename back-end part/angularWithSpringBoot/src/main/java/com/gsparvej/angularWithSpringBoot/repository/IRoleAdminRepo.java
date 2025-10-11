package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.RoleAdmin;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRoleAdminRepo extends JpaRepository<RoleAdmin, Long> {

    Optional<RoleAdmin> findByUserId(int userId);
}
