package com.gsparvej.angularWithSpringBoot.repository;

import com.gsparvej.angularWithSpringBoot.entity.RoleMerchandiserManager;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRoleMerchandiserManagerRepo extends JpaRepository<RoleMerchandiserManager, Long> {
    Optional<RoleMerchandiserManager> findByUserId(int userId);
}
