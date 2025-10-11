package com.gsparvej.angularWithSpringBoot.restcontroller;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.gsparvej.angularWithSpringBoot.dto.AuthenticationResponse;
import com.gsparvej.angularWithSpringBoot.dto.UserResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.User;
import com.gsparvej.angularWithSpringBoot.repository.ITokenRepo;
import com.gsparvej.angularWithSpringBoot.service.AuthService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/auth")
public class AuthRestController {

    @Autowired
    private AuthService authService;

    @Autowired
    private ITokenRepo tokenRepo;


//    @GetMapping("/all")
//    public ResponseEntity<List<User>> getAllUsers() {
//        List<User> users = authService.findAllUsers();
//        return ResponseEntity.ok(users);
//    }


    @GetMapping("/all")
    public ResponseEntity<List<UserResponseDTO>> getAllUsersDTOs() {
        List<UserResponseDTO> users = authService.getAllUsersResponseDTOS();
        return ResponseEntity.ok(users);
    }

    @GetMapping("/active/{id}")
    public ResponseEntity<String> activeUser(@PathVariable("id") int id){

        String response= authService.activeUser(id);
        return  ResponseEntity.ok(response);
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(@RequestBody User request){
        return ResponseEntity.ok(authService.authenticate(request));

    }

    @PostMapping("/logout")
    public ResponseEntity<String> logout(HttpServletRequest request) {
        final String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.badRequest().body("Missing or invalid Authorization header.");
        }

        String token = authHeader.substring(7);  // Strip "Bearer "

        tokenRepo.findByToken(token).ifPresent(savedToken -> {
            savedToken.setLogout(true);  // Mark token as logged out
            tokenRepo.save(savedToken);
        });

        return ResponseEntity.ok("Logged out successfully.");
    }

}
