import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gmsflutter/admin%20page/admin_profile.dart';
import 'package:gmsflutter/merchandiser%20page/merchandiser_profile.dart';
import 'package:gmsflutter/purchase%20pages/purchase_manager_profile.dart';
import 'package:gmsflutter/service/admin_service/admin_profile_service.dart';
import 'package:gmsflutter/service/auth_service.dart';
import 'package:gmsflutter/service/merchandiser_service/merchandiser_profile_service.dart';
import 'package:gmsflutter/service/production_service/production_manager_profile_service.dart';
import 'package:gmsflutter/service/purchase_service/purchase_manager_profile_service.dart';

import '../production pages/production_manager_profile.dart';

// Converted to StatefulWidget to manage password visibility and login state
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  // State for password visibility
  bool _obscurePassword = true;
  // State for loading indicator
  bool _isLoading = false;

  // Services and Storage setup
  final storage = new FlutterSecureStorage();
  final AuthService authService = AuthService();
  final AdminProfileService adminProfileService = AdminProfileService();
  final MerchandiserManagerService merchandiserManagerService = MerchandiserManagerService();
  final PurchaseManagerService purchaseManagerService = PurchaseManagerService();
  final ProductionManagerProfileService productionManagerProfileService = ProductionManagerProfileService();

  // Primary brand color for a vibrant look
  final Color primaryColor = Color(0xFF4A148C); // Deep Purple 900
  // Accent color for buttons/highlights
  final Color accentColor = Color(0xFFFFC107); // Amber/Gold

  // Function to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a darker background for contrast
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- SMART LOGO/TITLE SECTION ---
              Icon(
                Icons.business_center_rounded,
                size: 80,
                color: primaryColor,
              ),
              SizedBox(height: 10),
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'GMS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Sign in to continue to your dashboard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),

              // --- EMAIL TEXT FIELD ---
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  labelText: "Email Address",
                  hintText: "example@company.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.email_outlined, color: primaryColor),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                ),
              ),
              SizedBox(height: 20),

              // --- PASSWORD TEXT FIELD ---
              TextField(
                controller: password,
                obscureText: _obscurePassword,
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your secure password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: primaryColor,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                ),
              ),
              SizedBox(height: 40),

              // --- LOGIN BUTTON ---
              _isLoading
                  ? Center(child: CircularProgressIndicator(color: primaryColor))
                  : ElevatedButton(
                onPressed: () => _isLoading ? null : loginUser(context),
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: accentColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5, // Adds a nice shadow
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to show a simple error message
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    if (email.text.isEmpty || password.text.isEmpty) {
      _showErrorSnackBar(context, 'Please enter both email and password.');
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      // 1. Attempt Login
      await authService.login(email.text, password.text);

      // 2. Successful login, get role and profile
      final role = await authService.getUserRole();
      dynamic profile;
      Widget nextPage;

      switch (role) {
        case 'ADMIN':
          profile = await adminProfileService.getAdminProfile();
          nextPage = AdminProfile(profile: profile);
          break;
        case 'MERCHANDISERMANAGER':
          profile = await merchandiserManagerService.getMerchandiserManagerProfile();
          nextPage = MerchandiserProfile(profile: profile);
          break;
        case 'PURCHASEMANAGER':
          profile = await purchaseManagerService.getPurchaseManagerProfile();
          nextPage = PurchaseManagerProfile(profile: profile);
          break;
        case 'PRODUCTIONMANAGER':
          profile = await productionManagerProfileService.getProductionManagerProfile();
          nextPage = ProductionManagerProfile(profile: profile);
          break;
        default:
          _showErrorSnackBar(context, 'Unknown user role.');
          return;
      }

      // 3. Navigation
      if (profile != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      } else {
        _showErrorSnackBar(context, 'Could not load profile data.');
      }

    } catch (error) {
      print('Login Failed: $error');
      _showErrorSnackBar(context, 'Login failed. Check your credentials.');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading regardless of success/failure
      });
    }
  }
}