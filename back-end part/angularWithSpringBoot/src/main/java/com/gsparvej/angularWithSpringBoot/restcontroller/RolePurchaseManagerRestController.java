package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gsparvej.angularWithSpringBoot.dto.RoleProductionManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.RolePurchaseManagerResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.RoleProductionManager;
import com.gsparvej.angularWithSpringBoot.entity.RolePurchaseManager;
import com.gsparvej.angularWithSpringBoot.entity.RoleSuperAdmin;
import com.gsparvej.angularWithSpringBoot.entity.User;
import com.gsparvej.angularWithSpringBoot.repository.IUserRepo;
import com.gsparvej.angularWithSpringBoot.service.AuthService;
import com.gsparvej.angularWithSpringBoot.service.RolePurchaseManagerService;
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
@RequestMapping("/api/purchase_manager")
public class RolePurchaseManagerRestController {

    @Autowired
    private AuthService authService;
    @Autowired
    private IUserRepo userRepo;


    @Autowired
    private RolePurchaseManagerService rolePurchaseManagerService;

    private final ObjectMapper objectMapper = new ObjectMapper();


    // Purchase Manager Registration

    @PostMapping("/reg")
    public ResponseEntity<Map<String, String>> savePurchaseManager(
            @RequestPart("user") String userJson,
            @RequestPart("purManager") String purManagerJson,
            @RequestPart(value = "photo", required = false) MultipartFile file
    ) throws JsonProcessingException {

        Map<String, String> response = new HashMap<>();

        try {
            // Deserialize JSON strings to Java objects
            User user = objectMapper.readValue(userJson, User.class);
            RolePurchaseManager rolePurchaseManager = objectMapper.readValue(purManagerJson, RolePurchaseManager.class);

            // Call service to register Purchase Manager
            authService.registerPurchaseManager(user, file, rolePurchaseManager);

            response.put("message", " Purchase Manager saved successfully");
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
        RolePurchaseManager rolePurchaseManager = rolePurchaseManagerService.getProfileByUserId(user.get().getId());
        return ResponseEntity.ok(rolePurchaseManager);

    }


    // Get all Purchase manager
    @GetMapping("all")
    public ResponseEntity<List<RolePurchaseManagerResponseDTO>> getAllPurManagerResponseDTOs() {
        List<RolePurchaseManagerResponseDTO> manager = rolePurchaseManagerService.getAllPurchaseManagerResponseDTOS();
        return ResponseEntity.ok(manager);
    }
}
