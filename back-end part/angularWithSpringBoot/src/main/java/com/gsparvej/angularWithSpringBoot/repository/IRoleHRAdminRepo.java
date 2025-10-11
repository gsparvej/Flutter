package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.RoleHRAdmin;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRoleHRAdminRepo extends JpaRepository<RoleHRAdmin, Long> {

    Optional<RoleHRAdmin> findByUserId(int userId);
}
