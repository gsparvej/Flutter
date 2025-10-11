package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRoleSuperAdminRepo extends JpaRepository<RoleSuperAdmin, Long> {

    Optional<RoleSuperAdmin> findByUserId(int userId);

    Optional<RoleSuperAdmin> findByEmail(String email);
}
