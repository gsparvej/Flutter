package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gsparvej.angularWithSpringBoot.dto.RoleSuperAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import com.gsparvej.angularWithSpringBoot.entity.User;
import com.gsparvej.angularWithSpringBoot.repository.IUserRepo;
import com.gsparvej.angularWithSpringBoot.service.AuthService;
import com.gsparvej.angularWithSpringBoot.service.RoleSuperAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.security.sasl.AuthenticationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/super_admin")
public class RoleSuperAdminRestController {

    @Autowired
    private IUserRepo userRepo;


    @Autowired
    private RoleSuperAdminService roleSuperAdminService;

    @Autowired
    private AuthService authService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    // Super Admin Registration
    @PostMapping("/reg")
    public ResponseEntity<Map<String, String>> saveSuperAdmin(
            @RequestPart("user") String userJson,
            @RequestPart("superadmin") String superAdminJson,
            @RequestPart(value = "photo", required = false) MultipartFile file
    ) throws JsonProcessingException {

        Map<String, String> response = new HashMap<>();

        try {
            // Deserialize JSON strings to Java objects
            User user = objectMapper.readValue(userJson, User.class);
            RoleSuperAdmin roleSuperAdmin = objectMapper.readValue(superAdminJson, RoleSuperAdmin.class);

            // Call service to register super admin
            authService.registerSuperAdmin(user, file, roleSuperAdmin);

            response.put("message", "Super Admin saved successfully");
            return ResponseEntity.ok(response);

        } catch (AuthenticationException authEx) {
            // If there's an authentication issue, return 401 Unauthorized
            response.put("message", "Authentication failed: " + authEx.getMessage());
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);

        } catch (JsonProcessingException jsonEx) {
            // Bad JSON format
            response.put("message", "Invalid input data format: " + jsonEx.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);

        } catch (Exception e) {
            // Unexpected server error
            e.printStackTrace(); // Log full stack trace to console or log file
            response.put("message", "Super Admin save failed: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }



    // Get all super admins
    @GetMapping("all")
    public ResponseEntity<List<RoleSuperAdminResponseDTO>> getAllSuperAdminDTOs() {
        List<RoleSuperAdminResponseDTO> admins = roleSuperAdminService.getAllRoleSuperAdminResponseDTOS();
        return ResponseEntity.ok(admins);
    }

    // Get logged-in admin profile
//    @GetMapping("/profile")
//    public ResponseEntity<RoleSuperAdminResponseDTO> getProfile(Authentication authentication) {
//        if (authentication == null || authentication.getName() == null) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
//        }
//        String email = authentication.getName();
//        RoleSuperAdminResponseDTO admin = roleSuperAdminService.getProfileByEmail(email);
//        return ResponseEntity.ok(admin);
//    }


    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(Authentication authentication) {
        System.out.println("Authenticated User: " + authentication.getName());
        System.out.println("Authorities: " + authentication.getAuthorities());
        String email = authentication.getName();
        Optional<User> user =userRepo.findByEmail(email);
        RoleSuperAdmin roleSuperAdmin = roleSuperAdminService.getProfileByUserId(user.get().getId());
        return ResponseEntity.ok(roleSuperAdmin);

    }


}
