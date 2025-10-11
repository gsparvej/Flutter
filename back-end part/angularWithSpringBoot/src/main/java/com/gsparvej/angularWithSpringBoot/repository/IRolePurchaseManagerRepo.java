package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.RolePurchaseManager;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRolePurchaseManagerRepo extends JpaRepository<RolePurchaseManager, Long> {

    Optional<RolePurchaseManager> findByUserId(int userId);
}
