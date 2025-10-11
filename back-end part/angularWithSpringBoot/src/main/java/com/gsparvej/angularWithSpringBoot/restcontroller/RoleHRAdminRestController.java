package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gsparvej.angularWithSpringBoot.dto.RoleAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RoleHRAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleAdmin;
import com.gsparvej.angularWithSpringBoot.entity.RoleHRAdmin;
import com.gsparvej.angularWithSpringBoot.entity.User;
import com.gsparvej.angularWithSpringBoot.repository.IUserRepo;
import com.gsparvej.angularWithSpringBoot.service.AuthService;
import com.gsparvej.angularWithSpringBoot.service.RoleHRAdminService;
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
@RequestMapping("/api/hr_admin")
public class RoleHRAdminRestController {



    @Autowired
    private AuthService authService;
    @Autowired
    private IUserRepo userRepo;

    @Autowired
    private RoleHRAdminService roleHRAdminService;

    private final ObjectMapper objectMapper = new ObjectMapper();


    // HR Admin Registration

    @PostMapping("/reg")
    public ResponseEntity<Map<String, String>> saveHRAdmin(
            @RequestPart("user") String userJson,
            @RequestPart("hradmin") String hrAdminJson,
            @RequestPart(value = "photo", required = false) MultipartFile file
    ) throws JsonProcessingException {

        Map<String, String> response = new HashMap<>();

        try {
            // Deserialize JSON strings to Java objects
            User user = objectMapper.readValue(userJson, User.class);
            RoleHRAdmin roleHRAdmin = objectMapper.readValue(hrAdminJson, RoleHRAdmin.class);

            // Call service to register hr admin
            authService.registerHRAdmin(user, file, roleHRAdmin);

            response.put("message", "HR Admin saved successfully");
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
            response.put("message", "Admin save failed: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(Authentication authentication) {
        System.out.println("Authenticated User: " + authentication.getName());
        System.out.println("Authorities: " + authentication.getAuthorities());
        String email = authentication.getName();
        Optional<User> user =userRepo.findByEmail(email);
        RoleHRAdmin roleHRAdmin = roleHRAdminService.getProfileByUserId(user.get().getId());
        return ResponseEntity.ok(roleHRAdmin);

    }

    // Get all hr admins
    @GetMapping("all")
    public ResponseEntity<List<RoleHRAdminResponseDTO>> getAllHRAdminDTOs() {
        List<RoleHRAdminResponseDTO> admins = roleHRAdminService.getAllRoleHRAdminResponseDTOS();
        return ResponseEntity.ok(admins);
    }

}
