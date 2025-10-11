package com.gsparvej.angularWithSpringBoot.service;

import com.gsparvej.angularWithSpringBoot.dto.AuthenticationResponse;
import com.gsparvej.angularWithSpringBoot.dto.RoleSuperAdminResponseDTO;
import com.gsparvej.angularWithSpringBoot.dto.UserResponseDTO;
import com.gsparvej.angularWithSpringBoot.entity.*;
import com.gsparvej.angularWithSpringBoot.jwt.JwtService;
import com.gsparvej.angularWithSpringBoot.repository.ITokenRepo;
import com.gsparvej.angularWithSpringBoot.repository.IUserRepo;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service
public class AuthService {

    @Autowired
    RolePurchaseManagerService rolePurchaseManagerService;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private IUserRepo userRepo;
    @Autowired
    private ITokenRepo tokenRepo;
    @Autowired
    private EmailService emailService;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private RoleSuperAdminService roleSuperAdminService;
    @Autowired
    private RoleHRAdminService roleHRAdminService;
    @Autowired
    private RoleAdminService roleAdminService;
    @Autowired
    private RoleMerchandiserManagerService roleMerchandiserManagerService;

    @Autowired
    private RoleProductionManagerService roleProductionManagerService;
    @Autowired
    @Lazy
    private AuthenticationManager authenticationManager;

    @Value("src/main/resources/static/images")
    private String uploadDir;


    public void saveOrUpdate(User user, MultipartFile imageFile) {

        if (imageFile != null && !imageFile.isEmpty()) {
            String filename = saveImage(imageFile, user);
            user.setPhoto(filename);
        }

        user.setRole(Role.SUPERADMIN);
        userRepo.save(user);
//        sendActivationEmail(user);
    }


    public List<User> findAllUsers() {
        return userRepo.findAll();
    }



    public List<UserResponseDTO> getAllUsersResponseDTOS() {
        return userRepo.findAll().stream().map(user -> {
            UserResponseDTO dto = new UserResponseDTO();


            dto.setId(user.getId());
            dto.setEmail(user.getEmail());
            dto.setName(user.getName());
            dto.setPhoto(user.getPhoto());
            dto.setPhone(user.getPhone());

            return dto;
        }).toList();
    }





    public User findById(int id) {
        return userRepo.findById(id).get();
    }

    public void delete(User user) {
        userRepo.delete(user);
    }


    private void sendActivationEmail(User user) {
        String subject = "Welcome to Our Service – Confirm Your Registration";

        String activationLink = "http://localhost:8080/api/user/active/" + user.getId();

        String mailText = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<style>"
                + "  body { font-family: Arial, sans-serif; line-height: 1.6; }"
                + "  .container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px; }"
                + "  .header { background-color: #4CAF50; color: white; padding: 10px; text-align: center; border-radius: 10px 10px 0 0; }"
                + "  .content { padding: 20px; }"
                + "  .footer { font-size: 0.9em; color: #777; margin-top: 20px; text-align: center; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "  <div class='container'>"
                + "    <div class='header'>"
                + "      <h2>Welcome to Our Platform</h2>"
                + "    </div>"
                + "    <div class='content'>"
                + "      <p>Dear " + user.getName() + ",</p>"
                + "      <p>Thank you for registering with us. We are excited to have you on board!</p>"
                + "      <p>Please confirm your email address to activate your account and get started.</p>"
                + "      <p>If you have any questions or need help, feel free to reach out to our support team.</p>"
                + "      <br>"
                + "      <p>Best regards,<br>The Support Team</p>"
                + "      <p>To Activate Your Account, please click the following link:</p>"
                + "      <p><a href=\"" + activationLink + "\">Activate Account</a></p>"
                + "    </div>"
                + "    <div class='footer'>"
                + "      &copy; " + java.time.Year.now() + " YourCompany. All rights reserved."
                + "    </div>"
                + "  </div>"
                + "</body>"
                + "</html>";

        try {
            emailService.sendSimpleEmail(user.getEmail(), subject, mailText);
        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send activation email", e);
        }
    }



    // Super Admin Part start

    public String saveImageForSuperAdmin(MultipartFile file, RoleSuperAdmin roleSuperAdmin) {

        Path uploadPath = Paths.get(uploadDir + "/roleSuperAdmin");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String superAdminName = roleSuperAdmin.getName();
        String fileName = superAdminName.trim().replaceAll("\\s+", "_");

        String savedFileName = fileName + "_" + UUID.randomUUID().toString();

        try {
            Path filePath = uploadPath.resolve(savedFileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return savedFileName;

    }


    public void registerSuperAdmin(User user, MultipartFile imageFile, RoleSuperAdmin superAdminData) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            // Save image for both User and Super Admin
            String fileName = saveImage(imageFile, user);
            String superAdminImage = saveImageForSuperAdmin(imageFile, superAdminData);
            superAdminData.setPhoto(superAdminImage);
            user.setPhoto(fileName);
        }

        // Encode password before saving User
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.SUPERADMIN);
        user.setActive(true);

        // Save User FIRST and get persisted instance
        User savedUser = userRepo.save(user);

        // Now, associate saved User with Super Admin
        superAdminData.setUser(savedUser);
        roleSuperAdminService.save(superAdminData);

        // Now generate token and save Token associated with savedUser
        String jwt = jwtService.generateToken(savedUser);
        saveUserToken(jwt, savedUser);

        // Send Activation Email
//        sendActivationEmail(savedUser);
    }










    // for User folder
    public String saveImage(MultipartFile file, User user) {

        Path uploadPath = Paths.get(uploadDir + "/users");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String fileName = user.getName() + "_" + UUID.randomUUID().toString();


        try {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return fileName;

    }

// start Admin
    public String saveImageForAdmin(MultipartFile file, RoleAdmin roleAdmin) {

        Path uploadPath = Paths.get(uploadDir + "/roleAdmin");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String adminName = roleAdmin.getName();
        String fileName = adminName.trim().replaceAll("\\s+", "_");

        String savedFileName = fileName + "_" + UUID.randomUUID().toString();

        try {
            Path filePath = uploadPath.resolve(savedFileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return savedFileName;

    }

    public void registerAdmin(User user, MultipartFile imageFile, RoleAdmin adminData) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            // Save image for both User and Admin
            String filename = saveImage(imageFile, user);
            String adminImage = saveImageForAdmin(imageFile, adminData);
            adminData.setPhoto(adminImage);
            user.setPhoto(filename);
        }

        // Encode password before saving User
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.ADMIN);
        user.setActive(false);

        // Save User FIRST and get persisted instance
        User savedUser = userRepo.save(user);

        // Now, associate saved User with JobSeeker and save JobSeeker
        adminData.setUser(savedUser);
        roleAdminService.save(adminData);

        // Now generate token and save Token associated with savedUser
        String jwt = jwtService.generateToken(savedUser);
        saveUserToken(jwt, savedUser);

        // Send Activation Email
//        sendActivationEmail(savedUser);
    }

    // end Admin


    // start HR Admin

    public String saveImageForHRAdmin(MultipartFile file, RoleHRAdmin roleHRAdmin) {

        Path uploadPath = Paths.get(uploadDir + "/roleHRAdmin");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String hrAdminName = roleHRAdmin.getName();
        String fileName = hrAdminName.trim().replaceAll("\\s+", "_");

        String savedFileName = fileName + "_" + UUID.randomUUID().toString();

        try {
            Path filePath = uploadPath.resolve(savedFileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return savedFileName;

    }

    public void registerHRAdmin(User user, MultipartFile imageFile, RoleHRAdmin hrAdminData) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            // Save image for both User and HRAdmin
            String fileName = saveImage(imageFile, user);
            String hrAdminImage = saveImageForHRAdmin(imageFile, hrAdminData);
            hrAdminData.setPhoto(hrAdminImage);
            user.setPhoto(fileName);
        }

        // Encode password before saving User
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.HRADMIN);
        user.setActive(false);

        // Save User FIRST and get persisted instance
        User savedUser = userRepo.save(user);

        // Now, associate saved User with JobSeeker and save JobSeeker
        hrAdminData.setUser(savedUser);
        roleHRAdminService.save(hrAdminData);

        // Now generate token and save Token associated with savedUser
        String jwt = jwtService.generateToken(savedUser);
        saveUserToken(jwt, savedUser);

        // Send Activation Email
//        sendActivationEmail(savedUser);
    }


    // end HR Admin







    // start Purchase Manager

    public String saveImageForPurchaseManager(MultipartFile file, RolePurchaseManager rolePurchaseManager) {

        Path uploadPath = Paths.get(uploadDir + "/rolePurchaseManager");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String purchaseManagerName = rolePurchaseManager.getName();
        String fileName = purchaseManagerName.trim().replaceAll("\\s+", "_");

        String savedFileName = fileName + "_" + UUID.randomUUID().toString();

        try {
            Path filePath = uploadPath.resolve(savedFileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return savedFileName;

    }

    public void registerPurchaseManager(User user, MultipartFile imageFile, RolePurchaseManager purchaseManagerData) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            // Save image for both User and Purchase Manager
            String fileName = saveImage(imageFile, user);
            String purchaseManagerImage = saveImageForPurchaseManager(imageFile, purchaseManagerData);
            purchaseManagerData.setPhoto(purchaseManagerImage);
            user.setPhoto(fileName);
        }

        // Encode password before saving User
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.PURCHASEMANAGER);
        user.setActive(false);

        // Save User FIRST and get persisted instance
        User savedUser = userRepo.save(user);

        // Now, associate saved User with Purchase Manager
        purchaseManagerData.setUser(savedUser);
        rolePurchaseManagerService.save(purchaseManagerData);

        // Now generate token and save Token associated with savedUser
        String jwt = jwtService.generateToken(savedUser);
        saveUserToken(jwt, savedUser);

        // Send Activation Email
//        sendActivationEmail(savedUser);
    }


    // end Purchase Manager



    // start Merchandiser Manager

    public String saveImageForMerchandiserManager(MultipartFile file, RoleMerchandiserManager roleMerchandiserManager) {

        Path uploadPath = Paths.get(uploadDir + "/roleMerchandiserManager");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String merchandiserManagerName = roleMerchandiserManager.getName();
        String fileName = merchandiserManagerName.trim().replaceAll("\\s+", "_");

        String savedFileName = fileName + "_" + UUID.randomUUID().toString();

        try {
            Path filePath = uploadPath.resolve(savedFileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return savedFileName;

    }

    public void registerMerchandiserManager(User user, MultipartFile imageFile, RoleMerchandiserManager merchandiserManagerData) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            // Save image for both User and Merchandiser Manager
            String fileName = saveImage(imageFile, user);
            String merchandiserManagerImage = saveImageForMerchandiserManager(imageFile, merchandiserManagerData);
            merchandiserManagerData.setPhoto(merchandiserManagerImage);
            user.setPhoto(fileName);
        }

        // Encode password before saving User
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.MERCHANDISERMANAGER);
        user.setActive(false);

        // Save User FIRST and get persisted instance
        User savedUser = userRepo.save(user);

        // Now, associate saved User with Merchandiser Manager
        merchandiserManagerData.setUser(savedUser);
        roleMerchandiserManagerService.save(merchandiserManagerData);

        // Now generate token and save Token associated with savedUser
        String jwt = jwtService.generateToken(savedUser);
        saveUserToken(jwt, savedUser);

        // Send Activation Email
//        sendActivationEmail(savedUser);
    }


    // end Merchandiser Manager


    // start Production Manager

    public String saveImageForProductionManager(MultipartFile file, RoleProductionManager roleProductionManager) {

        Path uploadPath = Paths.get(uploadDir + "/roleProductionManager");
        if (!Files.exists(uploadPath)) {
            try {
                Files.createDirectory(uploadPath);

            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        String productionManagerName = roleProductionManager.getName();
        String fileName = productionManagerName.trim().replaceAll("\\s+", "_");

        String savedFileName = fileName + "_" + UUID.randomUUID().toString();

        try {
            Path filePath = uploadPath.resolve(savedFileName);
            Files.copy(file.getInputStream(), filePath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return savedFileName;

    }

    public void registerProductionManager(User user, MultipartFile imageFile, RoleProductionManager productionManagerData) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            // Save image for both User and Production Manager
            String fileName = saveImage(imageFile, user);
            String productionManagerImage = saveImageForProductionManager(imageFile, productionManagerData);
            productionManagerData.setPhoto(productionManagerImage);
            user.setPhoto(fileName);
        }

        // Encode password before saving User
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.PRODUCTIONMANAGER);
        user.setActive(false);

        // Save User FIRST and get persisted instance
        User savedUser = userRepo.save(user);

        // Now, associate saved User with Production Manager
        productionManagerData.setUser(savedUser);
        roleProductionManagerService.save(productionManagerData);

        // Now generate token and save Token associated with savedUser
        String jwt = jwtService.generateToken(savedUser);
        saveUserToken(jwt, savedUser);

        // Send Activation Email
//        sendActivationEmail(savedUser);
    }


    // end Production Manager



    private void saveUserToken(String jwt, User user) {
        Token token = new Token();
        token.setToken(jwt);
        token.setLogout(false);
        token.setUser(user);
        tokenRepo.save(token);
    }

    private void removeAllTokenByUser(User user) {

        List<Token> validTokens = tokenRepo.findAllTokenByUser(user.getId());

        if (validTokens.isEmpty()) {
            return;
        }
        validTokens.forEach(t -> {
            t.setLogout(true);
        });

        tokenRepo.saveAll(validTokens);

    }


    // It is Login Method
    public AuthenticationResponse authenticate(User request) {
        // Authenticate Username & Password
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );

        // Fetch User from DB
        User user = userRepo.findByEmail(request.getEmail())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        // Check Activation Status
        if (!user.isActive()) {
            throw new RuntimeException("Account is not activated. Please check your email for activation link.");
        }

        // Generate JWT Token
        String jwt = jwtService.generateToken(user);

        // Remove Existing Tokens (Invalidate Old Sessions)
        removeAllTokenByUser(user);

        // Save New Token to DB (Optional if stateless)
        saveUserToken(jwt, user);

        // Return Authentication Response
        return new AuthenticationResponse(jwt, "User Login Successful");
    }



    public  String activeUser(int id){

        User user=userRepo.findById(id)
                .orElseThrow(()-> new RuntimeException("User not Found with this ID "+id));

        if(user !=null){
            user.setActive(true);

            userRepo.save(user);
            return "User Activated Successfully!";

        }else {
            return  "Invalid Activation Token!";
        }

    }


}
